import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/accounting/widgets/incomingInvoicesWidgets/mode_of_payment_dropdown.dart';
import 'package:toolkit/screens/accounting/widgets/invoice_currency_dropdown.dart';

import '../../../../blocs/accounting/accounting_bloc.dart';

class IncomingInvoicePaymentCurrencyDropdowns extends StatelessWidget {
  const IncomingInvoicePaymentCurrencyDropdowns({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Mode of payment',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: xxxTinierSpacing),
        ModeOfPaymentDropdown(onPaymentModeSelected: (String paymentMode) {
          context.read<AccountingBloc>().manageIncomingInvoiceMap['mode'] =
              paymentMode;
        }),
        const SizedBox(height: xxTinySpacing),
        Text('Invoice Currency',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: xxxTinierSpacing),
        InvoiceCurrencyDropdown(
          onCurrencySelected: (String currency) {
            context
                .read<AccountingBloc>()
                .manageIncomingInvoiceMap['othercurrency'] = currency;
          },
          manageInvoiceMap:
              context.read<AccountingBloc>().manageIncomingInvoiceMap,
        ),
        const SizedBox(height: xxTinySpacing),
      ],
    );
  }
}
