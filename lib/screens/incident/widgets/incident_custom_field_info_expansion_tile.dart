import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/incident/reportNewIncident/report_new_incident_states.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../blocs/incident/reportNewIncident/report_new_incident_bloc.dart';
import '../../../blocs/incident/reportNewIncident/report_new_incident_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';

typedef CustomFieldCallBack = Function(String customFieldOptionId);

class IncidentReportCustomFiledInfoExpansionTile extends StatelessWidget {
  final CustomFieldCallBack onCustomFieldChanged;
  final int index;
  final Map addAndEditIncidentMap;

  const IncidentReportCustomFiledInfoExpansionTile(
      {Key? key,
      required this.onCustomFieldChanged,
      required this.index,
      required this.addAndEditIncidentMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ReportNewIncidentBloc>().add(
        ReportNewIncidentCustomInfoFiledExpansionChange(
            reportIncidentCustomInfoOptionId:
                (addAndEditIncidentMap['optionIds'] == null ||
                        addAndEditIncidentMap['optionIds'].isEmpty)
                    ? '[]'
                    : addAndEditIncidentMap['optionIds'][index]['optionId']
                        .toString()));
    String customFieldName = (addAndEditIncidentMap['customfields'] == null ||
            addAndEditIncidentMap['customfields'].isEmpty)
        ? ""
        : addAndEditIncidentMap['customfields'][index]['value'];
    return BlocBuilder<ReportNewIncidentBloc, ReportNewIncidentStates>(
        buildWhen: (previousState, currentState) =>
            currentState is ReportNewIncidentCustomFieldSelected,
        builder: (context, state) {
          if (state is ReportNewIncidentCustomFieldSelected) {
            return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                    tilePadding: const EdgeInsets.only(
                        left: kExpansionTileMargin,
                        right: kExpansionTileMargin),
                    collapsedBackgroundColor: AppColor.white,
                    maintainState: true,
                    iconColor: AppColor.deepBlue,
                    textColor: AppColor.black,
                    key: GlobalKey(),
                    title: Text(
                        (customFieldName == '')
                            ? DatabaseUtil.getText('select_item')
                            : customFieldName,
                        style: Theme.of(context).textTheme.xSmall),
                    children: [
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.fetchIncidentMasterModel
                              .incidentMasterDatum![7][index].queoptions.length,
                          itemBuilder: (BuildContext context, int itemIndex) {
                            return RadioListTile(
                                contentPadding: const EdgeInsets.only(
                                    left: xxxTinierSpacing),
                                activeColor: AppColor.deepBlue,
                                title: Text(
                                    state
                                        .fetchIncidentMasterModel
                                        .incidentMasterDatum![7][index]
                                        .queoptions[itemIndex]['optiontext'],
                                    style: Theme.of(context).textTheme.xSmall),
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                value: state
                                    .fetchIncidentMasterModel
                                    .incidentMasterDatum![7][index]
                                    .queoptions[itemIndex]['optionid']
                                    .toString(),
                                groupValue: state
                                    .reportIncidentCustomInfoOptionId
                                    .toString(),
                                onChanged: (value) {
                                  value = state
                                      .fetchIncidentMasterModel
                                      .incidentMasterDatum![7][index]
                                      .queoptions[itemIndex]['optionid']
                                      .toString();
                                  customFieldName = state
                                      .fetchIncidentMasterModel
                                      .incidentMasterDatum![7][index]
                                      .queoptions[itemIndex]['optiontext'];
                                  onCustomFieldChanged(value);
                                  context.read<ReportNewIncidentBloc>().add(
                                      ReportNewIncidentCustomInfoFiledExpansionChange(
                                          reportIncidentCustomInfoOptionId:
                                              value));
                                });
                          })
                    ]));
          } else {
            return const SizedBox();
          }
        });
  }
}
