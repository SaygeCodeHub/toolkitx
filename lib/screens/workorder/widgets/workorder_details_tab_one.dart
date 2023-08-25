import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_spacing.dart';
import '../../../data/models/workorder/fetch_workorder_details_model.dart';
import '../../../utils/database_utils.dart';
import 'workorder_details_tab_one_map_link_list.dart';

class WorkOrderDetailsTabOne extends StatelessWidget {
  final WorkOrderDetailsData data;
  final int tabIndex;

  const WorkOrderDetailsTabOne(
      {Key? key, required this.tabIndex, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: tiniestSpacing),
            Text(
              DatabaseUtil.getText('Company'),
              style: Theme.of(context).textTheme.medium,
            ),
            const SizedBox(height: xxTinierSpacing),
            Text(data.contractorname),
            const SizedBox(height: tinySpacing),
            Text(
              DatabaseUtil.getText('Location'),
              style: Theme.of(context).textTheme.medium,
            ),
            const SizedBox(height: xxTinierSpacing),
            WorkOrderDetailsTabOneMapLinkList(data: data),
            const SizedBox(height: tinySpacing),
            Text(DatabaseUtil.getText('OtherLocation'),
                style: Theme.of(context).textTheme.medium),
            const SizedBox(height: xxTinierSpacing),
            Text(data.otherlocation, style: Theme.of(context).textTheme.small),
            const SizedBox(height: tinySpacing),
            Text(DatabaseUtil.getText('StartDate'),
                style: Theme.of(context).textTheme.medium),
            const SizedBox(height: xxTinierSpacing),
            Text(data.plannedstartdatetime,
                style: Theme.of(context).textTheme.small),
            const SizedBox(height: tinySpacing),
            Text(
              DatabaseUtil.getText('EndDate'),
              style: Theme.of(context).textTheme.medium,
            ),
            const SizedBox(height: xxTinierSpacing),
            Text(data.plannedfinishdate,
                style: Theme.of(context).textTheme.small),
            const SizedBox(height: tinySpacing),
            Text(
              DatabaseUtil.getText('Category'),
              style: Theme.of(context).textTheme.medium,
            ),
            const SizedBox(height: xxTinierSpacing),
            Text(data.category, style: Theme.of(context).textTheme.small),
            const SizedBox(height: tinySpacing),
            Text(
              DatabaseUtil.getText('Priority'),
              style: Theme.of(context).textTheme.medium,
            ),
            const SizedBox(height: xxTinierSpacing),
            Text('', style: Theme.of(context).textTheme.small),
            const SizedBox(height: tinySpacing),
            Text(
              DatabaseUtil.getText('type'),
              style: Theme.of(context).textTheme.medium,
            ),
            const SizedBox(height: xxTinierSpacing),
            Text(data.type, style: Theme.of(context).textTheme.small),
            const SizedBox(height: tinySpacing),
            Text(
              DatabaseUtil.getText('Subject'),
              style: Theme.of(context).textTheme.medium,
            ),
            const SizedBox(height: xxTinierSpacing),
            Text(data.subject, style: Theme.of(context).textTheme.small),
            const SizedBox(height: tinySpacing),
            Text(
              DatabaseUtil.getText('CostCenter'),
              style: Theme.of(context).textTheme.medium,
            ),
            const SizedBox(height: xxTinierSpacing),
            Text(data.costcenter, style: Theme.of(context).textTheme.small),
            const SizedBox(height: tinySpacing),
            Text(
              DatabaseUtil.getText('Origination'),
              style: Theme.of(context).textTheme.medium,
            ),
            const SizedBox(height: xxTinierSpacing),
            Text(data.origination, style: Theme.of(context).textTheme.small),
            const SizedBox(height: tinySpacing),
            Text(
              DatabaseUtil.getText('Description'),
              style: Theme.of(context).textTheme.medium,
            ),
            const SizedBox(height: xxTinierSpacing),
            Text(data.description, style: Theme.of(context).textTheme.small),
            const SizedBox(height: tinySpacing),
            Text(
              DatabaseUtil.getText('WorkSteps'),
              style: Theme.of(context).textTheme.medium,
            ),
            const SizedBox(height: xxTinierSpacing),
            Text(data.worksteps, style: Theme.of(context).textTheme.small),
            const SizedBox(height: tinySpacing),
            Text(
              DatabaseUtil.getText('SafetyMeasures'),
              style: Theme.of(context).textTheme.medium,
            ),
            const SizedBox(height: xxTinierSpacing),
            Text(data.safetymeasure, style: Theme.of(context).textTheme.small),
            const SizedBox(height: tinySpacing),
          ],
        ));
  }
}
