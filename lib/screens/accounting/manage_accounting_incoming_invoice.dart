import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/accounting/widgets/accounting_entity_dropdown.dart';
import 'package:toolkit/screens/accounting/widgets/incomingInvoicesWidgets/billable_dropdown.dart';
import 'package:toolkit/screens/accounting/widgets/incomingInvoicesWidgets/manage_accounting_incoming_invoice_section.dart';
import 'package:toolkit/screens/incident/widgets/date_picker.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../configs/app_spacing.dart';
import '../../widgets/generic_app_bar.dart';

class ManageAccountingIncomingInvoice extends StatelessWidget {
  static const routeName = 'AccountingAddIncomingInvoice';

  const ManageAccountingIncomingInvoice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(title: 'Add Incoming Invoice'),
        bottomNavigationBar: BottomAppBar(
            child: Row(
          children: [
            Expanded(
              child: PrimaryButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  textValue: StringConstants.kBack),
            ),
            const SizedBox(width: xxTinierSpacing),
            Expanded(
              child: PrimaryButton(
                  onPressed: () {
                    Navigator.pushNamed(context,
                        ManageAccountingIncomingInvoiceSection.routeName);
                  },
                  textValue: StringConstants.kNext),
            ),
          ],
        )),
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
                Text(StringConstants.kEntity,
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: xxxTinierSpacing),
                AccountingEntityDropdown(
                    onEntityChanged: (String entity) {}, selectedEntity: ''),
                const SizedBox(height: xxTinySpacing),
                Text('Billable',
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: xxxTinierSpacing),
                BillableDropdown(onBillableChanged: (String selectedValue) {}),
                const SizedBox(height: xxTinySpacing),
                Text(StringConstants.kClient,
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: xxxTinierSpacing),
                BillableDropdown(onBillableChanged: (String selectedValue) {}),
                const SizedBox(height: xxTinySpacing),
                Text('Project',
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: xxxTinierSpacing),
                BillableDropdown(onBillableChanged: (String selectedValue) {}),
                const SizedBox(height: xxTinySpacing),
                Text('Invoice Date',
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: xxxTinierSpacing),
                DatePickerTextField(
                  onDateChanged: (String date) {},
                ),
                const SizedBox(height: xxTinySpacing),
                Text('Purpose of payment',
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: xxxTinierSpacing),
                TextFieldWidget(
                  onTextFieldChanged: (String value) {},
                ),
                const SizedBox(height: xxTinySpacing),
                Text('Mode of payment',
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: xxxTinierSpacing),
                BillableDropdown(onBillableChanged: (String selectedValue) {}),
                const SizedBox(height: xxTinySpacing)
              ],
            ),
          ),
        ));
  }
}
