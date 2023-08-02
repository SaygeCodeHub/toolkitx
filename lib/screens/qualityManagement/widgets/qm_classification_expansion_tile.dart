import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/qm_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/qm_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../../blocs/qualityManagement/qm_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';

class QualityManagementClassificationExpansionTile extends StatelessWidget {
  final Map qmCommentsMap;

  const QualityManagementClassificationExpansionTile(
      {Key? key, required this.qmCommentsMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context
        .read<QualityManagementBloc>()
        .add(FetchQualityManagementClassificationValue());
    String classificationStatus = '';
    return BlocBuilder<QualityManagementBloc, QualityManagementStates>(
        buildWhen: (previousState, currentState) =>
            currentState is FetchingQualityManagementClassificationValue ||
            currentState is QualityManagementClassificationValueFetched,
        builder: (context, state) {
          if (state is FetchingQualityManagementClassificationValue) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is QualityManagementClassificationValueFetched) {
            qmCommentsMap['classification'] = state.classificationId;
            return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: AppColor.transparent),
                child: ExpansionTile(
                    maintainState: true,
                    key: GlobalKey(),
                    title: Text(
                        (classificationStatus == '')
                            ? DatabaseUtil.getText('select_item')
                            : classificationStatus,
                        style: Theme.of(context).textTheme.xSmall),
                    children: [
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state
                              .fetchQualityManagementClassificationModel
                              .data[0]
                              .length,
                          itemBuilder: (BuildContext context, int index) {
                            return RadioListTile(
                                contentPadding: const EdgeInsets.only(
                                    left: xxxTinierSpacing),
                                activeColor: AppColor.deepBlue,
                                title: Text(
                                    state
                                        .fetchQualityManagementClassificationModel
                                        .data[0][index]
                                        .name,
                                    style: Theme.of(context).textTheme.xSmall),
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                value: state
                                    .fetchQualityManagementClassificationModel
                                    .data[0][index]
                                    .id
                                    .toString(),
                                groupValue: state.classificationId,
                                onChanged: (value) {
                                  value = state
                                      .fetchQualityManagementClassificationModel
                                      .data[0][index]
                                      .id
                                      .toString();
                                  classificationStatus = state
                                      .fetchQualityManagementClassificationModel
                                      .data[0][index]
                                      .name;
                                  context.read<QualityManagementBloc>().add(
                                      SelectQualityManagementClassification(
                                          classificationId: value,
                                          fetchQualityManagementClassificationModel:
                                              state
                                                  .fetchQualityManagementClassificationModel));
                                });
                          })
                    ]));
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
