import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../configs/app_spacing.dart';
import '../../data/models/workorder/fetch_workorder_master_model.dart';
import '../../utils/database_utils.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/generic_text_field.dart';
import 'widgets/workorder_mis_cost_currency_expansion_tile.dart';
import 'widgets/workorder_mis_cost_vendor_expansion_tile.dart';
import 'widgets/workorder_save_mis_cost_button.dart';

class WorkOrderAddMisCostScreen extends StatelessWidget {
  static const routeName = 'WorkOrderAddMisCostScreen';
  static Map workOrderDetailsMap = {};
  static List<List<WorkOrderMasterDatum>> workOrderMasterDatum = [];

  const WorkOrderAddMisCostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('AddMiscCost')),
        bottomNavigationBar: const WorkOrderSaveMisCostButton(),
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
                    Text(DatabaseUtil.getText('Service'),
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: xxxTinierSpacing),
                    TextFieldWidget(
                        maxLength: 70,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.text,
                        onTextFieldChanged: (String textField) {
                          workOrderDetailsMap['service'] = textField;
                        }),
                    const SizedBox(height: xxTinySpacing),
                    Text(DatabaseUtil.getText('Vendor'),
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: xxxTinierSpacing),
                    const WorkOrderMisCostVendorExpansionTile(),
                    const SizedBox(height: xxTinySpacing),
                    Text(DatabaseUtil.getText('Quantity'),
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: xxxTinierSpacing),
                    TextFieldWidget(
                        maxLength: 30,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.number,
                        onTextFieldChanged: (String textField) {
                          workOrderDetailsMap['quan'] = textField;
                        }),
                    const SizedBox(height: xxTinySpacing),
                    Text(DatabaseUtil.getText('Currency'),
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: xxxTinierSpacing),
                    const WorkOrderMiscCostCurrencyExpansionTile(),
                    const SizedBox(height: xxTinySpacing),
                    Text(DatabaseUtil.getText('Amount'),
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: xxxTinierSpacing),
                    TextFieldWidget(
                        maxLength: 30,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.number,
                        onTextFieldChanged: (String textField) {
                          workOrderDetailsMap['amount'] = textField;
                        }),
                  ],
                ))));
  }
}
