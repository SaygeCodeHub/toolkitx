import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/accounting/fetch_outgoing_invoices_model.dart';

import '../../../../configs/app_color.dart';
import '../../../../configs/app_dimensions.dart';
import '../../../../configs/app_spacing.dart';

class OutgoingListTileSubtitle extends StatelessWidget {
  final OutgoingInvoicesDatum outgoingInvoices;

  const OutgoingListTileSubtitle({super.key, required this.outgoingInvoices});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Image.asset("assets/icons/calendar.png",
            height: kIconSize, width: kIconSize),
        const SizedBox(width: tiniestSpacing),
        Text(outgoingInvoices.date,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.grey))
      ]),
      const SizedBox(height: tinierSpacing),
      Text(outgoingInvoices.amount,
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(color: AppColor.grey)),
      const SizedBox(height: tinierSpacing),
    ]);
  }
}
