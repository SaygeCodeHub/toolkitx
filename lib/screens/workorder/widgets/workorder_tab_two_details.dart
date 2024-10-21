import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/android_pop_up.dart';

import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/workorder/fetch_workorder_details_model.dart';
import '../../../utils/workorder_tab_two_status_tag_util.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/custom_icon_button.dart';
import '../../../widgets/status_tag.dart';
import '../workorder_edit_workforce_screen.dart';

class WorkOrderTabTwoDetails extends StatelessWidget {
  final WorkOrderDetailsData data;
  final int tabIndex;

  const WorkOrderTabTwoDetails(
      {super.key, required this.data, required this.tabIndex});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: data.workforce.isNotEmpty,
      replacement: Center(
        child: Text(StringConstants.kNoWorkForce,
            style: Theme.of(context).textTheme.medium),
      ),
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.workforce.length,
          itemBuilder: (context, index) {
            return CustomCard(
              child: ListTile(
                contentPadding: const EdgeInsets.all(xxTinierSpacing),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(data.workforce[index].name,
                        style: Theme.of(context).textTheme.small.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.w600)),
                    const Spacer(),
                    CustomIconButton(
                        icon: Icons.delete,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AndroidPopUp(
                                    titleValue:
                                        DatabaseUtil.getText('DeleteRecord'),
                                    contentValue: '',
                                    onPrimaryButton: () {
                                      context
                                          .read<WorkOrderTabDetailsBloc>()
                                          .add(DeleteWorkOrderWorkForce(
                                              workForceId:
                                                  data.workforce[index].id));
                                      Navigator.pop(context);
                                    });
                              });
                        },
                        size: kEditAndDeleteIconTogether),
                    const SizedBox(width: xxxTinierSpacing),
                    CustomIconButton(
                        icon: Icons.edit,
                        onPressed: () {
                          WorkOrderEditWorkForceScreen
                                  .editWorkOrderWorkForceMap['plannedhrs'] =
                              data.workforce[index].plannedhrs.toString();
                          WorkOrderEditWorkForceScreen
                                  .editWorkOrderWorkForceMap['workForceName'] =
                              data.workforce[index].name;
                          WorkOrderEditWorkForceScreen
                                  .editWorkOrderWorkForceMap['workorderId'] =
                              data.id;
                          WorkOrderEditWorkForceScreen
                                  .editWorkOrderWorkForceMap['workForceId'] =
                              data.workforce[index].workforceid;
                          WorkOrderEditWorkForceScreen
                                  .editWorkOrderWorkForceMap['workForceId2'] =
                              data.workforce[index].workforceid2;
                          WorkOrderEditWorkForceScreen
                                  .editWorkOrderWorkForceMap['actualhrs'] =
                              data.workforce[index].actualhrs;
                          Navigator.pushNamed(
                              context, WorkOrderEditWorkForceScreen.routeName);
                        },
                        size: kEditAndDeleteIconTogether)
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.workforce[index].jobTitle,
                        style: Theme.of(context).textTheme.xSmall.copyWith()),
                    const SizedBox(height: tinierSpacing),
                    Row(children: [
                      Text(DatabaseUtil.getText('PlannedWorkingHours'),
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(color: AppColor.grey)),
                      const SizedBox(width: tiniestSpacing),
                      Text(data.workforce[index].plannedhrs.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(color: AppColor.grey))
                    ]),
                    const SizedBox(height: tinierSpacing),
                    Row(
                      children: [
                        Text(DatabaseUtil.getText('ActualWorkingHours'),
                            style: Theme.of(context)
                                .textTheme
                                .xSmall
                                .copyWith(color: AppColor.grey)),
                        const SizedBox(width: tiniestSpacing),
                        Text(
                            data.workforce[index].actualhrs.toString() == 'null'
                                ? ''
                                : data.workforce[index].actualhrs.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .xSmall
                                .copyWith(color: AppColor.grey))
                      ],
                    ),
                    const SizedBox(height: tinierSpacing),
                    StatusTag(tags: [
                      WorkOrderTabTwoStatusUtil().workOrderStatusTag(
                          data.workforce[index].certificatecode)
                    ])
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: xxTinySpacing);
          }),
    );
  }
}
