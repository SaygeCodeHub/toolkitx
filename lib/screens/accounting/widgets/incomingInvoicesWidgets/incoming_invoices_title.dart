import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_event.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/accounting/fetch_incoming_invoices_model.dart';
import 'package:toolkit/screens/accounting/edit_incoming_invoice_screen.dart';
import 'package:toolkit/widgets/android_pop_up.dart';
import 'package:toolkit/widgets/custom_icon_button.dart';

import '../../../../configs/app_color.dart';
import '../../../../configs/app_spacing.dart';

class IncomingInvoicesTitle extends StatelessWidget {
  final IncomingInvoicesDatum incomingInvoices;

  const IncomingInvoicesTitle({super.key, required this.incomingInvoices});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: xxTinierSpacing),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(incomingInvoices.entity,
                style: Theme.of(context).textTheme.small.copyWith(
                    color: AppColor.black, fontWeight: FontWeight.w600)),
            const Spacer(),
            CustomIconButton(
                icon: Icons.edit,
                onPressed: () {
                  Navigator.pushNamed(
                      context, EditIncomingInvoiceScreen.routeName);
                  context.read<AccountingBloc>().add(
                      FetchIncomingInvoice(invoiceId: incomingInvoices.id));
                },
                size: 20),
            const SizedBox(width: xxTinierSpacing),
            CustomIconButton(
                icon: Icons.delete,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AndroidPopUp(
                            titleValue:
                                'Are you sure you want to delete this invoice?',
                            contentValue: '',
                            onPrimaryButton: () {
                              Navigator.pop(context);
                              context.read<AccountingBloc>().add(
                                  DeleteIncomingInvoice(
                                      invoiceId: incomingInvoices.id));
                            });
                      });
                },
                size: 20),
            const SizedBox(width: tiniestSpacing)
          ],
        ));
  }
}
