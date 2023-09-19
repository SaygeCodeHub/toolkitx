import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';

import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/primary_button.dart';
import 'create_similar_work_order_screen_one.dart';
import 'create_similar_workorder_screen_three.dart';
import 'widgets/workorder_company_expansion_tile.dart';
import 'widgets/workorder_origination_expansion_tile.dart';
import 'widgets/workorder_priority_expansion_tile.dart';
import 'widgets/workorder_type_expansion_tile.dart';

class CreateWorkOrderScreenTwo extends StatelessWidget {
  static const routeName = 'CreateWorkOrderScreenTwo';
  final Map workOrderDetailsMap;

  const CreateWorkOrderScreenTwo({Key? key, required this.workOrderDetailsMap})
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
                      if (workOrderDetailsMap['type'] == null ||
                          workOrderDetailsMap['type'].isEmpty) {
                        showCustomSnackBar(context, 'Please select type!', '');
                      } else {
                        Navigator.pushNamed(context,
                            CreateSimilarWorkOrderScreenThree.routeName,
                            arguments: workOrderDetailsMap);
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
                      Text(DatabaseUtil.getText('type'),
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: xxxTinierSpacing),
                      WorkOrderTypeExpansionTile(
                          data:
                              CreateSimilarWorkOrderScreen.workOrderMasterData,
                          workOrderDetailsMap: workOrderDetailsMap),
                      const SizedBox(height: xxTinySpacing),
                      Text(DatabaseUtil.getText('type'),
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
                          data:
                              CreateSimilarWorkOrderScreen.workOrderMasterData,
                          workOrderDetailsMap: workOrderDetailsMap),
                      const SizedBox(height: xxTinySpacing),
                      Text(DatabaseUtil.getText('Origination'),
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: xxxTinierSpacing),
                      WorkOrderOriginationExpansionTile(
                          data:
                              CreateSimilarWorkOrderScreen.workOrderMasterData,
                          workOrderDetailsMap: workOrderDetailsMap)
                    ]))));
  }
}
