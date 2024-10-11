import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_event.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/accounting/fetch_outgoing_invoices_model.dart';
import 'package:toolkit/widgets/android_pop_up.dart';
import 'package:toolkit/widgets/custom_icon_button.dart';

import '../../../../configs/app_color.dart';
import '../../../../configs/app_spacing.dart';

class OutgoingListTileTitle extends StatelessWidget {
  final OutgoingInvoicesDatum outgoingInvoices;

  const OutgoingListTileTitle({super.key, required this.outgoingInvoices});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: xxTinierSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(outgoingInvoices.entity,
                  style: Theme.of(context).textTheme.small.copyWith(
                      color: AppColor.black, fontWeight: FontWeight.w600)),
              const Spacer(),
              CustomIconButton(icon: Icons.edit, onPressed: () {}, size: 20),
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
                                    DeleteOutgoingInvoice(
                                        invoiceId: outgoingInvoices.id));
                              });
                        });
                  },
                  size: 20),
              const SizedBox(width: tiniestSpacing)
            ],
          ),
          const SizedBox(height: tinierSpacing),
          Text(outgoingInvoices.client,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
