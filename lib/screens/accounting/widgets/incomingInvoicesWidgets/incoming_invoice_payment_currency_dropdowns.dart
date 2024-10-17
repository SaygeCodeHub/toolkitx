import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/accounting/widgets/incomingInvoicesWidgets/mode_of_payment_dropdown.dart';
import 'package:toolkit/screens/accounting/widgets/invoice_currency_dropdown.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../../blocs/accounting/accounting_bloc.dart';

class IncomingInvoicePaymentCurrencyDropdowns extends StatelessWidget {
  final bool isFromEdit;

  const IncomingInvoicePaymentCurrencyDropdowns(
      {super.key, required this.isFromEdit});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(StringConstants.kModeOfPayment,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: xxxTinierSpacing),
        ModeOfPaymentDropdown(
            onPaymentModeSelected: (String paymentMode) {
              context.read<AccountingBloc>().manageIncomingInvoiceMap['mode'] =
                  paymentMode;
            },
            initialPaymentMode: isFromEdit
                ? context
                    .read<AccountingBloc>()
                    .manageIncomingInvoiceMap['mode']
                : '',
            isFromEdit: isFromEdit),
        const SizedBox(height: xxTinySpacing),
        Text(StringConstants.kInvoiceCurrency,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: xxxTinierSpacing),
        InvoiceCurrencyDropdown(
            onInvoiceCurrencySelected: (String currency) {
              context.read<AccountingBloc>().manageIncomingInvoiceMap['other'] =
                  currency;
            },
            manageInvoiceMap:
                context.read<AccountingBloc>().manageIncomingInvoiceMap,
            initialCurrency: isFromEdit
                ? context
                            .read<AccountingBloc>()
                            .manageIncomingInvoiceMap['othercurrencyname'] ==
                        ""
                    ? context
                        .read<AccountingBloc>()
                        .manageIncomingInvoiceMap['defaultcurrency']
                    : 'Other'
                : '',
            initialOtherCurrencyName: isFromEdit
                ? context
                        .read<AccountingBloc>()
                        .manageIncomingInvoiceMap['othercurrencyname'] ??
                    ''
                : '',
            initialOtherCurrency: isFromEdit
                ? context
                        .read<AccountingBloc>()
                        .manageIncomingInvoiceMap['othercurrencyname'] ??
                    ''
                : ''),
        const SizedBox(height: xxTinySpacing),
      ],
    );
  }
}
