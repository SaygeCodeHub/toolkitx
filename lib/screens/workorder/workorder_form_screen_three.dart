import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/generic_text_field.dart';

import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';
import '../../widgets/generic_app_bar.dart';
import 'widgets/workorder_form_three_screen_button.dart';
import 'workorder_form_one_screen.dart';
import 'widgets/workorder_cost_center_list_tile.dart';

class WorkOrderFormScreenThree extends StatelessWidget {
  static const routeName = 'CreateSimilarWorkOrderScreenThree';
  final Map workOrderDetailsMap;

  const WorkOrderFormScreenThree({Key? key, required this.workOrderDetailsMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('NewWorkOrder')),
        bottomNavigationBar: WorkOrderFormThreeScreenButton(
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
                      const SizedBox(height: xxTinySpacing)
                    ]))));
  }
}
