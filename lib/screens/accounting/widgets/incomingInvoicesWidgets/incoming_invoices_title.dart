import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/accounting/fetch_incoming_invoices_model.dart';

import '../../../../configs/app_color.dart';
import '../../../../configs/app_spacing.dart';

class IncomingInvoicesTitle extends StatelessWidget {
  final IncomingInvoicesDatum incomingInvoices;

  const IncomingInvoicesTitle({super.key, required this.incomingInvoices});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: xxTinierSpacing),
        child: Text(incomingInvoices.entity,
            style: Theme.of(context)
                .textTheme
                .small
                .copyWith(color: AppColor.black, fontWeight: FontWeight.w600)));
  }
}
