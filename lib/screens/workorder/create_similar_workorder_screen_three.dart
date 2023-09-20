import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/generic_text_field.dart';

import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/primary_button.dart';
import 'create_simiar_workorder_screen_four.dart';
import 'create_similar_work_order_screen_one.dart';
import 'widgets/workoder_save_button_bottom_nav_bar.dart';
import 'widgets/workorder_cost_center_list_tile.dart';

class CreateSimilarWorkOrderScreenThree extends StatelessWidget {
  static const routeName = 'CreateSimilarWorkOrderScreenThree';
  final Map workOrderDetailsMap;

  const CreateSimilarWorkOrderScreenThree(
      {Key? key, required this.workOrderDetailsMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('NewWorkOrder')),
        bottomNavigationBar: WorkOrderSaveButtonBottomNavBar(
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
                          data:
                              CreateSimilarWorkOrderScreen.workOrderMasterData,
                          workOrderDetailsMap: workOrderDetailsMap),
                      const SizedBox(height: xxTinySpacing),
                      Text(DatabaseUtil.getText('Subject'),
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: xxxTinierSpacing),
                      TextFieldWidget(
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
                          value: workOrderDetailsMap['description'] ?? '',
                          onTextFieldChanged: (String textField) {
                            workOrderDetailsMap['description'] = textField;
                          }),
                      const SizedBox(height: xxTinySpacing)
                    ]))));
  }
}
