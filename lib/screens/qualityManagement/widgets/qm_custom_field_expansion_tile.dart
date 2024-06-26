import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/qm_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/qm_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../blocs/qualityManagement/qm_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';

typedef CustomFieldCallBack = Function(String customFieldOptionId);

class QualityManagementCustomFieldInfoExpansionTile extends StatelessWidget {
  final CustomFieldCallBack onCustomFieldChanged;
  final int index;
  final Map addAndEditIncidentMap;

  const QualityManagementCustomFieldInfoExpansionTile(
      {Key? key,
      required this.onCustomFieldChanged,
      required this.index,
      required this.addAndEditIncidentMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<QualityManagementBloc>().add(
        ReportNewQualityManagementCustomInfoFiledExpansionChange(
            reportQMCustomInfoOptionId: ''));
    String customFieldName = (addAndEditIncidentMap['customfields'] == null ||
            addAndEditIncidentMap['customfields'].isEmpty)
        ? ""
        : addAndEditIncidentMap['customfields'][index]['value'];
    return BlocBuilder<QualityManagementBloc, QualityManagementStates>(
        buildWhen: (previousState, currentState) =>
            currentState is ReportNewQualityManagementCustomFieldSelected,
        builder: (context, state) {
          if (state is ReportNewQualityManagementCustomFieldSelected) {
            return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: AppColor.transparent),
                child: ExpansionTile(
                    maintainState: true,
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
                          itemCount: state.fetchQualityManagementMasterModel
                              .data![4][index].queoptions.length,
                          itemBuilder: (BuildContext context, int itemIndex) {
                            return RadioListTile(
                                contentPadding: const EdgeInsets.only(
                                    left: xxxTinierSpacing),
                                activeColor: AppColor.deepBlue,
                                title: Text(
                                    state
                                        .fetchQualityManagementMasterModel
                                        .data![4][index]
                                        .queoptions[itemIndex]
                                        .optiontext,
                                    style: Theme.of(context).textTheme.xSmall),
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                value: state
                                    .fetchQualityManagementMasterModel
                                    .data![4][index]
                                    .queoptions[itemIndex]
                                    .optionid
                                    .toString(),
                                groupValue: state
                                    .fetchQualityManagementMasterModel
                                    .toString(),
                                onChanged: (value) {
                                  value = state
                                      .fetchQualityManagementMasterModel
                                      .data![4][index]
                                      .queoptions[itemIndex]
                                      .optionid
                                      .toString();
                                  customFieldName = state
                                      .fetchQualityManagementMasterModel
                                      .data![4][index]
                                      .queoptions[itemIndex]
                                      .optiontext;
                                  onCustomFieldChanged(value);
                                  context.read<QualityManagementBloc>().add(
                                      ReportNewQualityManagementCustomInfoFiledExpansionChange(
                                          reportQMCustomInfoOptionId: value));
                                });
                          })
                    ]));
          } else {
            return const SizedBox();
          }
        });
  }
}
