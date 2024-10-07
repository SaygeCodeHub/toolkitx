import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/accounting/fetch_outgoing_invoices_model.dart';

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
          Text(outgoingInvoices.entity,
              style: Theme.of(context).textTheme.small.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.w600)),
          const SizedBox(height: tinierSpacing),
          Text(outgoingInvoices.client,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
