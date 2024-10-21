import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';
import '../../widgets/generic_app_bar.dart';
import 'widgets/workorder_form_two_screen_button.dart';
import 'workorder_form_one_screen.dart';
import 'widgets/workorder_company_expansion_tile.dart';
import 'widgets/workorder_origination_expansion_tile.dart';
import 'widgets/workorder_priority_expansion_tile.dart';
import 'widgets/workorder_type_expansion_tile.dart';

class WorkOrderFormScreenTwo extends StatelessWidget {
  static const routeName = 'CreateWorkOrderScreenTwo';
  final Map workOrderDetailsMap;

  const WorkOrderFormScreenTwo({super.key, required this.workOrderDetailsMap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GenericAppBar(
            title: (WorkOrderFormScreenOne.isFromEdit == true)
                ? DatabaseUtil.getText('EditWorkOrder')
                : DatabaseUtil.getText('NewWorkOrder')),
        bottomNavigationBar: WorkOrderFormTwoScreenButton(
            workOrderDetailsMap: workOrderDetailsMap),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinySpacing),
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(DatabaseUtil.getText('type'),
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: xxxTinierSpacing),
                      WorkOrderTypeExpansionTile(
                          data: WorkOrderFormScreenOne.workOrderMasterData,
                          workOrderDetailsMap: workOrderDetailsMap),
                      const SizedBox(height: xxTinySpacing),
                      Text(DatabaseUtil.getText('Priority'),
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: xxxTinierSpacing),
                      WorkOrderPriorityExpansionTile(
                          workOrderDetailsMap: workOrderDetailsMap),
                      const SizedBox(height: xxTinySpacing),
                      Text(DatabaseUtil.getText('Category'),
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: xxxTinierSpacing),
                      WorkOrderCompanyExpansionTile(
                          data: WorkOrderFormScreenOne.workOrderMasterData,
                          workOrderDetailsMap: workOrderDetailsMap),
                      const SizedBox(height: xxTinySpacing),
                      Text(DatabaseUtil.getText('Origination'),
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: xxxTinierSpacing),
                      WorkOrderOriginationExpansionTile(
                          data: WorkOrderFormScreenOne.workOrderMasterData,
                          workOrderDetailsMap: workOrderDetailsMap)
                    ]))));
  }
}
