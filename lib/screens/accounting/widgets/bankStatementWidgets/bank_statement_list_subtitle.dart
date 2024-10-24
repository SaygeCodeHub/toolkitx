import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/accounting/fetch_bank_statements_model.dart';

import '../../../../configs/app_color.dart';
import '../../../../configs/app_dimensions.dart';

class BankStatementListSubtitle extends StatelessWidget {
  final BankStatementsDatum bankStatement;

  const BankStatementListSubtitle({super.key, required this.bankStatement});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(bankStatement.bank,
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(color: AppColor.grey)),
      const SizedBox(height: tinierSpacing),
      Row(children: [
        Image.asset("assets/icons/calendar.png",
            height: kIconSize, width: kIconSize),
        const SizedBox(width: tiniestSpacing),
        Text(bankStatement.date,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.grey))
      ])
    ]);
  }
}
