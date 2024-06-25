import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/qm_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/qm_states.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/qualityManagement/qm_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';

class QualityManagementSeverityExpansionTile extends StatelessWidget {
  final Map reportNewQMMap;

  const QualityManagementSeverityExpansionTile(
      {Key? key, required this.reportNewQMMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<QualityManagementBloc>().add(
        ReportNewQualityManagementSeverityChange(
            severityId: (reportNewQMMap['severity'] == null)
                ? ''
                : reportNewQMMap['severity']));
    String severityValue = (reportNewQMMap['severityname'] == null)
        ? ''
        : reportNewQMMap['severityname'];
    return BlocBuilder<QualityManagementBloc, QualityManagementStates>(
        buildWhen: (previousState, currentState) =>
            currentState is ReportNewQualityManagementSeveritySelected,
        builder: (context, state) {
          if (state is ReportNewQualityManagementSeveritySelected) {
            reportNewQMMap['severity'] = state.severityId;
            return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: AppColor.transparent),
                child: ExpansionTile(
                    maintainState: true,
                    key: GlobalKey(),
                    title: Text(
                        (severityValue == '')
                            ? DatabaseUtil.getText('select_item')
                            : severityValue,
                        style: Theme.of(context).textTheme.xSmall),
                    children: [
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.fetchQualityManagementMasterModel
                              .data![2].length,
                          itemBuilder: (BuildContext context, int index) {
                            return RadioListTile(
                                contentPadding: const EdgeInsets.only(
                                    left: xxxTinierSpacing),
                                activeColor: AppColor.deepBlue,
                                title: Text(
                                    state.fetchQualityManagementMasterModel
                                        .data![2][index].name,
                                    style: Theme.of(context).textTheme.xSmall),
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                value: state.fetchQualityManagementMasterModel
                                    .data![2][index].id
                                    .toString(),
                                groupValue: state.severityId,
                                onChanged: (value) {
                                  value = state
                                      .fetchQualityManagementMasterModel
                                      .data![2][index]
                                      .id
                                      .toString();
                                  severityValue = state
                                      .fetchQualityManagementMasterModel
                                      .data![2][index]
                                      .name;
                                  context.read<QualityManagementBloc>().add(
                                      ReportNewQualityManagementSeverityChange(
                                          severityId: value));
                                });
                          })
                    ]));
          } else {
            return const SizedBox();
          }
        });
  }
}
