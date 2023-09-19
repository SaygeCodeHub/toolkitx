import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';

import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/primary_button.dart';
import 'create_similar_work_order_screen_one.dart';
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
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: [
              Expanded(
                  child: PrimaryButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                textValue: DatabaseUtil.getText('buttonBack'),
              )),
              const SizedBox(width: xxTinierSpacing),
              Expanded(
                child: PrimaryButton(
                    onPressed: () {
                      if (workOrderDetailsMap['subject'] == null ||
                          workOrderDetailsMap['subject'].isEmpty ||
                          workOrderDetailsMap['description'] == null ||
                          workOrderDetailsMap['description'].isEmpty) {
                        showCustomSnackBar(
                            context,
                            DatabaseUtil.getText('SubjectDescriptionMandatory'),
                            '');
                      }
                    },
                    textValue: DatabaseUtil.getText('nextButtonText')),
              ),
            ],
          ),
        ),
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
