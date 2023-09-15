import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/workorder/fetch_workorder_details_model.dart';
import '../../../utils/workorder_tab_two_status_tag_util.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/status_tag.dart';

class WorkOrderTabTwoDetails extends StatelessWidget {
  final WorkOrderDetailsData data;
  final int tabIndex;

  const WorkOrderTabTwoDetails(
      {Key? key, required this.data, required this.tabIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: data.workforce.length,
        itemBuilder: (context, index) {
          return CustomCard(
            child: ListTile(
              contentPadding: const EdgeInsets.all(xxTinierSpacing),
              title: Padding(
                  padding: const EdgeInsets.only(bottom: xxTinierSpacing),
                  child: Text(data.workforce[index].name,
                      style: Theme.of(context).textTheme.small.copyWith(
                          color: AppColor.black, fontWeight: FontWeight.w600))),
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
                      Text(data.workforce[index].actualhrs.toString(),
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
        });
  }
}
