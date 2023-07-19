import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/incident/incidentListAndFilter/incident_list_and_filter_event.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../blocs/incident/incidentListAndFilter/incident_list_and_filter_bloc.dart';
import '../../blocs/incident/reportNewIncident/report_new_incident_bloc.dart';
import '../../blocs/incident/reportNewIncident/report_new_incident_events.dart';
import '../../blocs/incident/reportNewIncident/report_new_incident_states.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/custom_floating_action_button.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/progress_bar.dart';
import '../../widgets/text_button.dart';
import 'incident_injuries_screen.dart';

class AddInjuredPersonScreen extends StatelessWidget {
  static const routeName = 'AddInjuredPersonScreen';
  final Map addIncidentMap;
  static List injuredPersonDetailsList = [];

  const AddInjuredPersonScreen({Key? key, required this.addIncidentMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ReportNewIncidentBloc>().add(FetchIncidentInjuredPerson(
        injuredPersonDetailsList: (addIncidentMap['persons'] == null)
            ? []
            : addIncidentMap['persons']));
    return Scaffold(
        appBar: GenericAppBar(
            title: DatabaseUtil.getText('addInjuredPersonPageHeading')),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: CustomFloatingActionButton(
            textValue: DatabaseUtil.getText('addInjuredPersonPageDetails'),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      IncidentInjuriesScreen(addIncidentMap: addIncidentMap)));
            }),
        body: BlocBuilder<ReportNewIncidentBloc, ReportNewIncidentStates>(
            builder: (context, state) {
          if (state is ReportNewIncidentInjuredPersonDetailsFetched) {
            return Padding(
                padding: const EdgeInsets.only(
                    left: leftRightMargin,
                    right: leftRightMargin,
                    top: xxTinierSpacing),
                child: Visibility(
                    visible: state.injuredPersonDetailsList.isNotEmpty,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: state.injuredPersonDetailsList.length,
                      itemBuilder: (context, index) {
                        return CustomCard(
                            child: ListTile(
                                contentPadding: const EdgeInsets.only(
                                    left: tinierSpacing,
                                    right: tinierSpacing,
                                    top: tiniestSpacing,
                                    bottom: tiniestSpacing),
                                trailing: CustomTextButton(
                                    onPressed: () {
                                      context.read<ReportNewIncidentBloc>().add(
                                          IncidentRemoveInjuredPersonDetails(
                                              injuredPersonDetailsList:
                                                  addIncidentMap['persons'],
                                              index: index));
                                    },
                                    textValue: StringConstants.kRemove),
                                title: Text(
                                    state.injuredPersonDetailsList[index]
                                        ['name'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .small
                                        .copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: AppColor.mediumBlack))));
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: xxTinierSpacing);
                      },
                    )));
          } else {
            return const SizedBox();
          }
        }),
        bottomNavigationBar: BottomAppBar(
          child: BlocListener<ReportNewIncidentBloc, ReportNewIncidentStates>(
              listener: (context, state) {
                if (state is ReportNewIncidentSaving) {
                  ProgressBar.show(context);
                } else if (state is ReportNewIncidentSaved ||
                    state is ReportNewIncidentPhotoSaved) {
                  ProgressBar.dismiss(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  context.read<IncidentLisAndFilterBloc>().add(
                      const FetchIncidentListEvent(page: 1, isFromHome: false));
                } else if (state is ReportNewIncidentNotSaved) {
                  ProgressBar.dismiss(context);
                  showCustomSnackBar(
                      context, state.incidentNotSavedMessage, '');
                }
              },
              child: PrimaryButton(
                  onPressed: () {
                    context.read<ReportNewIncidentBloc>().add(
                        SaveReportNewIncident(
                            reportNewIncidentMap: addIncidentMap,
                            role: context
                                .read<IncidentLisAndFilterBloc>()
                                .roleId));
                  },
                  textValue: StringConstants.kDone)),
        ));
  }
}
