import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/generic_text_field.dart';

import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';
import '../../widgets/generic_app_bar.dart';
import 'widgets/workorder_form_three_screen_button.dart';
import 'widgets/workorder_safety_measures_expansion_tile.dart';
import 'widgets/workorder_special_work_expansion_tile.dart';
import 'workorder_form_one_screen.dart';
import 'widgets/workorder_cost_center_list_tile.dart';

class WorkOrderFormScreenThree extends StatelessWidget {
  static const routeName = 'CreateSimilarWorkOrderScreenThree';
  final Map workOrderDetailsMap;

  const WorkOrderFormScreenThree(
      {super.key, required this.workOrderDetailsMap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GenericAppBar(
            title: (WorkOrderFormScreenOne.isFromEdit == true)
                ? DatabaseUtil.getText('EditWorkOrder')
                : DatabaseUtil.getText('NewWorkOrder')),
        bottomNavigationBar: WorkOrderFormThreeScreenButton(
            workOrderDetailsMap: workOrderDetailsMap),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin, right: leftRightMargin),
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WorkOrderCostCenterListTile(
                          data: WorkOrderFormScreenOne.workOrderMasterData,
                          workOrderDetailsMap: workOrderDetailsMap),
                      const SizedBox(height: xxTinySpacing),
                      Text(DatabaseUtil.getText('Subject'),
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: xxxTinierSpacing),
                      TextFieldWidget(
                          maxLength: 70,
                          value: workOrderDetailsMap['subject'] ?? '',
                          onTextFieldChanged: (String textField) {
                            workOrderDetailsMap['subject'] = textField;
                          }),
                      const SizedBox(height: xxTinySpacing),
                      Text(DatabaseUtil.getText('Description'),
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: xxxTinierSpacing),
                      TextFieldWidget(
                          maxLength: 250,
                          value: workOrderDetailsMap['description'] ?? '',
                          onTextFieldChanged: (String textField) {
                            workOrderDetailsMap['description'] = textField;
                          }),
                      const SizedBox(height: xxTinySpacing),
                      Visibility(
                        visible: WorkOrderFormScreenOne.isFromEdit == true,
                        child: Text(DatabaseUtil.getText('SafetyMeasures'),
                            style: Theme.of(context)
                                .textTheme
                                .xSmall
                                .copyWith(fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(height: xxxTinierSpacing),
                      Visibility(
                        visible: WorkOrderFormScreenOne.isFromEdit == true,
                        child: WorkOrderSafetyMeasuresExpansionTile(
                            data: WorkOrderFormScreenOne.workOrderMasterData,
                            workOrderDetailsMap: workOrderDetailsMap),
                      ),
                      const SizedBox(height: xxTinySpacing),
                      Visibility(
                        visible: WorkOrderFormScreenOne.isFromEdit == true,
                        child: Text(DatabaseUtil.getText('SpecialWork'),
                            style: Theme.of(context)
                                .textTheme
                                .xSmall
                                .copyWith(fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(height: xxxTinierSpacing),
                      Visibility(
                        visible: WorkOrderFormScreenOne.isFromEdit == true,
                        child: WorkOrderSpecialWorkExpansionTile(
                            data: WorkOrderFormScreenOne.workOrderMasterData,
                            workOrderDetailsMap: workOrderDetailsMap),
                      )
                    ]))));
  }
}
