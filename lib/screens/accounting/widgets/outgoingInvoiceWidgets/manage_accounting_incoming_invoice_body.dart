import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/accounting/widgets/accounting_entity_dropdown.dart';
import 'package:toolkit/screens/accounting/widgets/incomingInvoicesWidgets/billable_dropdown.dart';
import 'package:toolkit/screens/accounting/widgets/incomingInvoicesWidgets/incoming_invoice_payment_currency_dropdowns.dart';
import 'package:toolkit/screens/incident/widgets/date_picker.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_text_field.dart';

class ManageAccountingIncomingInvoiceBody extends StatelessWidget {
  final bool isFromEdit;

  const ManageAccountingIncomingInvoiceBody({
    super.key,
    required this.isFromEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(StringConstants.kEntity,
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(fontWeight: FontWeight.w600)),
      const SizedBox(height: xxxTinierSpacing),
      AccountingEntityDropdown(
          onEntityChanged: (String entity) {
            context.read<AccountingBloc>().manageIncomingInvoiceMap['entity'] =
                entity;
          },
          selectedEntity: isFromEdit
              ? context
                  .read<AccountingBloc>()
                  .manageIncomingInvoiceMap['entity']
              : '',
          isFromEdit: isFromEdit),
      const SizedBox(height: xxTinySpacing),
      Text(StringConstants.kBillable,
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(fontWeight: FontWeight.w600)),
      const SizedBox(height: xxxTinierSpacing),
      BillableDropdown(
        onBillableChanged: (String selectedValue) {
          context.read<AccountingBloc>().manageIncomingInvoiceMap['billable'] =
              selectedValue;
        },
        initialValue: isFromEdit
            ? (context
                    .read<AccountingBloc>()
                    .manageIncomingInvoiceMap['billable'] ??
                '')
            : '',
      ),
      Text(StringConstants.kInvoiceDate,
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(fontWeight: FontWeight.w600)),
      const SizedBox(height: xxxTinierSpacing),
      DatePickerTextField(
        onDateChanged: (String date) {
          context.read<AccountingBloc>().manageIncomingInvoiceMap['date'] =
              date;
        },
        editDate: isFromEdit
            ? context.read<AccountingBloc>().manageIncomingInvoiceMap['date']
            : '',
      ),
      const SizedBox(height: xxTinySpacing),
      Text(StringConstants.kPurposeOfPayment,
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(fontWeight: FontWeight.w600)),
      const SizedBox(height: xxxTinierSpacing),
      TextFieldWidget(
        onTextFieldChanged: (String value) {
          context
              .read<AccountingBloc>()
              .manageIncomingInvoiceMap['purposename'] = value;
        },
        value: isFromEdit
            ? context
                .read<AccountingBloc>()
                .manageIncomingInvoiceMap['purposename']
            : "",
      ),
      const SizedBox(height: xxTinySpacing),
      IncomingInvoicePaymentCurrencyDropdowns(
        isFromEdit: isFromEdit,
      )
    ]);
  }
}
