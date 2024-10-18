import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../../configs/app_color.dart';
import '../../../../configs/app_dimensions.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../data/models/accounting/fetch_incoming_invoices_model.dart';

class IncomingInvoicesSubtitle extends StatelessWidget {
  final IncomingInvoicesDatum incomingInvoices;

  const IncomingInvoicesSubtitle({super.key, required this.incomingInvoices});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(incomingInvoices.client,
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(color: AppColor.grey)),
      const SizedBox(height: tinierSpacing),
      Text(incomingInvoices.amount,
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(color: AppColor.grey)),
      const SizedBox(height: tinierSpacing),
      Row(children: [
        Image.asset("assets/icons/calendar.png",
            height: kIconSize, width: kIconSize),
        const SizedBox(width: tiniestSpacing),
        Text(incomingInvoices.date,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.grey))
      ])
    ]);
  }
}
