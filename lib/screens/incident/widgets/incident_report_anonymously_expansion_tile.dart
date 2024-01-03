import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/incident/reportNewIncident/report_new_incident_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../blocs/incident/reportNewIncident/report_new_incident_bloc.dart';
import '../../../blocs/incident/reportNewIncident/report_new_incident_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';

class IncidentReportAnonymousExpansionTile extends StatelessWidget {
  final Map addIncidentMap;

  const IncidentReportAnonymousExpansionTile(
      {Key? key, required this.addIncidentMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ReportNewIncidentBloc>().add(
        ReportNewIncidentAnonymousExpansionChange(
            reportIncidentAnonymousId: ''));
    String anonymousName = '';
    return BlocBuilder<ReportNewIncidentBloc, ReportNewIncidentStates>(
        buildWhen: (previousState, currentState) =>
            currentState is ReportNewIncidentAnonymousSelected,
        builder: (context, state) {
          if (state is ReportNewIncidentAnonymousSelected) {
            addIncidentMap['identity'] = state.reportAnonymousId;
            return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: AppColor.transparent),
                child: ExpansionTile(
                    collapsedShape: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: AppColor.grey,
                      width: kExpansionBorderWidth,
                    )),
                    collapsedBackgroundColor: AppColor.white,
                    backgroundColor: AppColor.white,
                    shape: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: AppColor.grey,
                      width: kExpansionBorderWidth,
                    )),
                    maintainState: true,
                    key: GlobalKey(),
                    title: Text(
                        (anonymousName == '')
                            ? DatabaseUtil.getText('No')
                            : anonymousName,
                        style: Theme.of(context).textTheme.xSmall),
                    children: [
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.reportAnonymousMap.keys.length,
                          itemBuilder: (BuildContext context, int index) {
                            return RadioListTile(
                                contentPadding: const EdgeInsets.only(
                                    left: xxxTinierSpacing),
                                activeColor: AppColor.deepBlue,
                                title: Text(
                                    state.reportAnonymousMap.values
                                        .elementAt(index),
                                    style: Theme.of(context).textTheme.xSmall),
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                value: state.reportAnonymousMap.keys
                                    .elementAt(index),
                                groupValue: state.reportAnonymousId,
                                onChanged: (value) {
                                  value = state.reportAnonymousMap.keys
                                      .elementAt(index);
                                  anonymousName = state
                                      .reportAnonymousMap.values
                                      .elementAt(index);
                                  context.read<ReportNewIncidentBloc>().add(
                                      ReportNewIncidentAnonymousExpansionChange(
                                          reportIncidentAnonymousId: value));
                                });
                          })
                    ]));
          } else {
            return const SizedBox();
          }
        });
  }
}
