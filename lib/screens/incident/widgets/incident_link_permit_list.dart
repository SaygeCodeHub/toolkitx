import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../blocs/incident/incidentDetails/incident_details_bloc.dart';
import '../../../blocs/incident/incidentDetails/incident_details_event.dart';
import '../../../blocs/incident/incidentListAndFilter/incident_list_and_filter_bloc.dart';
import '../../../blocs/incident/incidentRemoveLinkedPermit/incident_remove_linked_permit_bloc.dart';
import '../../../blocs/incident/incidentRemoveLinkedPermit/incident_remove_linked_permit_event.dart';
import '../../../blocs/incident/incidentRemoveLinkedPermit/incident_remove_linked_permit_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/incident/fetch_incidents_list_model.dart';
import '../../../data/models/incident/incident_details_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/progress_bar.dart';
import '../../../widgets/text_button.dart';
import 'permit_selection_list.dart';

class IncidentLinkPermitList extends StatefulWidget {
  final IncidentDetailsModel incidentDetailsModel;
  final IncidentListDatum incidentListDatum;
  final int initialIndex;

  const IncidentLinkPermitList(
      {Key? key,
      required this.incidentDetailsModel,
      required this.incidentListDatum,
      required this.initialIndex})
      : super(key: key);

  @override
  State<IncidentLinkPermitList> createState() => _IncidentLinkPermitListState();
}

class _IncidentLinkPermitListState extends State<IncidentLinkPermitList> {
  bool isList = true;

  void goBack() {
    setState(() {
      isList = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: (isList == true)
            ? Container(
                color: AppColor.white,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isList = false;
                      context.read<IncidentDetailsBloc>().add(
                          FetchPermitToLinkList(
                              incidentId: widget.incidentListDatum.id,
                              pageNo: 1));
                    });
                    context.read<IncidentDetailsBloc>().savedList.clear();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add),
                      const SizedBox(width: tiniestSpacing),
                      Text(StringConstants.kAddLinkToPermit,
                          style: Theme.of(context).textTheme.small.copyWith(
                                color: AppColor.white,
                              ))
                    ],
                  ),
                ),
              )
            : null,
        body: Visibility(
          visible: isList,
          replacement: PermitSelectionList(
            initialIndex: widget.initialIndex,
            incidentId: widget.incidentListDatum.id,
            goBack: goBack,
          ),
          child: (widget.incidentDetailsModel.data!.linkedpermits!.isEmpty)
              ? Center(
                  child: Text(StringConstants.kNoILinkedPermit,
                      style: Theme.of(context).textTheme.small.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColor.mediumBlack)))
              : ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount:
                      widget.incidentDetailsModel.data!.linkedpermits!.length,
                  itemBuilder: (context, index) {
                    return CustomCard(
                      child: ListTile(
                          contentPadding: const EdgeInsets.only(
                              left: tinierSpacing,
                              right: tinierSpacing,
                              top: tiniestSpacing,
                              bottom: tiniestSpacing),
                          trailing: BlocListener<IncidentRemoveLinkedPermitBloc,
                                  IncidentRemoveLinkedPermitStates>(
                              listener: (context, state) {
                                if (state
                                    is IncidentRemoveLinkedPermitLoading) {
                                  ProgressBar.show(context);
                                } else if (state
                                    is IncidentLinkedPermitRemoved) {
                                  ProgressBar.dismiss(context);
                                  context.read<IncidentDetailsBloc>().add(
                                      FetchIncidentDetailsEvent(
                                          incidentId:
                                              widget.incidentListDatum.id,
                                          role: context
                                              .read<IncidentLisAndFilterBloc>()
                                              .roleId,
                                          initialIndex: widget.initialIndex));
                                } else if (state
                                    is IncidentLinkedPermitNotRemoved) {
                                  ProgressBar.dismiss(context);
                                  showCustomSnackBar(context,
                                      StringConstants.kCannotUnlinkPermit, '');
                                }
                              },
                              child: CustomTextButton(
                                  onPressed: () {
                                    context
                                        .read<IncidentRemoveLinkedPermitBloc>()
                                        .add(IncidentRemoveLinkedPermitEvent(
                                            permitId: widget
                                                .incidentDetailsModel
                                                .data!
                                                .linkedpermits![index]
                                                .id,
                                            permitLinkedList: widget
                                                .incidentDetailsModel
                                                .data!
                                                .linkedpermits!,
                                            index: index));
                                  },
                                  textValue: StringConstants.kRemove,
                                  textColor: AppColor.errorRed)),
                          title: Text(
                              widget.incidentDetailsModel.data!
                                  .linkedpermits![index].processedPermitName,
                              style: Theme.of(context).textTheme.small.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.mediumBlack))),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: xxTinierSpacing);
                  },
                ),
        ));
  }
}
