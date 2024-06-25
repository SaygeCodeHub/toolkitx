import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/incident/incidentDetails/incident_details_event.dart';
import 'package:toolkit/blocs/incident/incidentListAndFilter/incident_list_and_filter_bloc.dart';
import 'package:toolkit/screens/incident/widgets/permit_selection_list_tile.dart';
import '../../../blocs/incident/incidentDetails/incident_details_bloc.dart';
import '../../../blocs/incident/incidentDetails/incident_details_states.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/error_section.dart';
import '../../../widgets/progress_bar.dart';

class PermitSelectionList extends StatefulWidget {
  static bool noMoreData = false;
  static int page = 1;
  static List permitLinkData = [];
  final String incidentId;
  final int initialIndex;
  final void Function() goBack;

  const PermitSelectionList(
      {Key? key,
      required this.incidentId,
      required this.initialIndex,
      required this.goBack})
      : super(key: key);

  @override
  State<PermitSelectionList> createState() => _PermitSelectionListState();
}

class _PermitSelectionListState extends State<PermitSelectionList> {
  var controller = ScrollController(keepScrollOffset: true);
  static bool waitForData = false;
  bool permitSelected = false;

  checkPermit(isChecked, index) {
    setState(() {
      if (isChecked!) {
        context
            .read<IncidentDetailsBloc>()
            .savedList
            .add(PermitSelectionList.permitLinkData[index].id);
      } else {
        context
            .read<IncidentDetailsBloc>()
            .savedList
            .remove(PermitSelectionList.permitLinkData[index].id);
      }
    });
  }

  @override
  void initState() {
    PermitSelectionList.page = 1;
    PermitSelectionList.noMoreData = false;
    PermitSelectionList.permitLinkData.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    permitSelected = context.read<IncidentDetailsBloc>().savedList.isNotEmpty;
    return Scaffold(
      bottomNavigationBar:
          BlocListener<IncidentDetailsBloc, IncidentDetailsStates>(
        listener: (context, state) {
          if (state is SavingLinkedPermits) {
            ProgressBar.show(context);
          } else if (state is SavedLinkedPermits) {
            ProgressBar.dismiss(context);
            context.read<IncidentDetailsBloc>().add(FetchIncidentDetailsEvent(
                incidentId: widget.incidentId,
                role: context.read<IncidentLisAndFilterBloc>().roleId,
                initialIndex: widget.initialIndex));
          }
          if (state is LinkedPermitsNotSaved) {
            showCustomSnackBar(
                context,
                DatabaseUtil.getText('some_unknown_error_please_try_again'),
                '');
          }
        },
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: widget.goBack,
                child: const Text(StringConstants.kCancel),
              ),
            ),
            const SizedBox(
              width: xxTinierSpacing,
            ),
            Expanded(
              child: ElevatedButton(
                  onPressed: (permitSelected)
                      ? () {
                          context.read<IncidentDetailsBloc>().add(
                              SaveLikedPermits(
                                  savedPermitList: context
                                      .read<IncidentDetailsBloc>()
                                      .savedList
                                      .toString()
                                      .replaceAll('[', '')
                                      .replaceAll(']', '')
                                      .replaceAll(' ', ''),
                                  incidentId: widget.incidentId));
                        }
                      : null,
                  child: const Text(StringConstants.kSelectPermits)),
            ),
          ],
        ),
      ),
      body: BlocConsumer<IncidentDetailsBloc, IncidentDetailsStates>(
        buildWhen: (previousState, currentState) =>
            ((currentState is FetchedPermitToLink &&
                    PermitSelectionList.noMoreData != true) ||
                (currentState is FetchingPermitToLink &&
                    PermitSelectionList.permitLinkData.isEmpty)),
        listener: (context, state) {
          if (state is FetchedPermitToLink) {
            if (state.fetchPermitToLinkModel.status == 204 &&
                PermitSelectionList.permitLinkData.isNotEmpty) {
              PermitSelectionList.noMoreData = true;
              showCustomSnackBar(context, StringConstants.kAllDataLoaded, '');
            }
          }
        },
        builder: (context, state) {
          if (state is FetchingPermitToLink) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is FetchedPermitToLink) {
            if (state.fetchPermitToLinkModel.data!.isNotEmpty) {
              for (var item in state.fetchPermitToLinkModel.data!) {
                PermitSelectionList.permitLinkData.add(item);
              }
              waitForData = false;
              return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  controller: controller
                    ..addListener(() {
                      if (PermitSelectionList.noMoreData != true &&
                          waitForData == false) {
                        if (controller.position.extentAfter < 500) {
                          PermitSelectionList.page++;
                          context.read<IncidentDetailsBloc>().add(
                              FetchPermitToLinkList(
                                  incidentId: widget.incidentId,
                                  pageNo: PermitSelectionList.page));
                          waitForData = true;
                        }
                      }
                    }),
                  shrinkWrap: true,
                  itemCount: PermitSelectionList.permitLinkData.length,
                  itemBuilder: (context, index) {
                    return PermitSelectionListTile(
                      permitLinkDatum:
                          PermitSelectionList.permitLinkData[index],
                      index: index,
                      checkPermit: checkPermit,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: xxTinySpacing);
                  });
            }
          }
          if (state is FetchPermitToLinkError) {
            return GenericReloadButton(
                onPressed: () {}, textValue: StringConstants.kReload);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
