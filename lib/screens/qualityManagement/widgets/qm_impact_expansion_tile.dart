import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/qm_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/qm_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../blocs/qualityManagement/qm_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';

class QualityManagementImpactExpansionTile extends StatelessWidget {
  final Map reportNewQMMap;

  const QualityManagementImpactExpansionTile(
      {Key? key, required this.reportNewQMMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context
        .read<QualityManagementBloc>()
        .add(ReportNewQualityManagementImpactChange(impactId: ''));
    String impactValue = '';
    return BlocBuilder<QualityManagementBloc, QualityManagementStates>(
        buildWhen: (previousState, currentState) =>
            currentState is ReportNewQualityManagementImpactSelected,
        builder: (context, state) {
          if (state is ReportNewQualityManagementImpactSelected) {
            reportNewQMMap['impact'] = state.impactId;
            return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: AppColor.transparent),
                child: ExpansionTile(
                    maintainState: true,
                    key: GlobalKey(),
                    title: Text(
                        (impactValue == '')
                            ? DatabaseUtil.getText('select_item')
                            : impactValue,
                        style: Theme.of(context).textTheme.xSmall),
                    children: [
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.fetchQualityManagementMasterModel
                              .data![3].length,
                          itemBuilder: (BuildContext context, int index) {
                            return RadioListTile(
                                contentPadding: const EdgeInsets.only(
                                    left: xxxTinierSpacing),
                                activeColor: AppColor.deepBlue,
                                title: Text(
                                    state.fetchQualityManagementMasterModel
                                        .data![3][index].name,
                                    style: Theme.of(context).textTheme.xSmall),
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                value: state.fetchQualityManagementMasterModel
                                    .data![3][index].id
                                    .toString(),
                                groupValue: state.impactId,
                                onChanged: (value) {
                                  value = state
                                      .fetchQualityManagementMasterModel
                                      .data![3][index]
                                      .id
                                      .toString();
                                  impactValue = state
                                      .fetchQualityManagementMasterModel
                                      .data![3][index]
                                      .name;
                                  context.read<QualityManagementBloc>().add(
                                      ReportNewQualityManagementImpactChange(
                                          impactId: value));
                                });
                          })
                    ]));
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
