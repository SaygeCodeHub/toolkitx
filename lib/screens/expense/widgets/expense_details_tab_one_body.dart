import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_spacing.dart';
import '../../../data/models/expense/fetch_expense_details_model.dart';
import '../../../utils/database_utils.dart';

class ExpenseDetailsTabOneBody extends StatelessWidget {
  final ExpenseDetailsData expenseDetailsData;

  const ExpenseDetailsTabOneBody({Key? key, required this.expenseDetailsData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: tiniestSpacing),
            Text(DatabaseUtil.getText('Reportedby'),
                style: Theme.of(context).textTheme.medium),
            const SizedBox(height: xxTinierSpacing),
            Text(expenseDetailsData.createdbyname),
            const SizedBox(height: tinySpacing),
            Text(DatabaseUtil.getText('ReportedDate'),
                style: Theme.of(context).textTheme.medium),
            const SizedBox(height: xxTinierSpacing),
            Text(expenseDetailsData.reportdate,
                style: Theme.of(context).textTheme.small),
            const SizedBox(height: tinySpacing),
            Text(DatabaseUtil.getText('Location'),
                style: Theme.of(context).textTheme.medium),
            const SizedBox(height: xxTinierSpacing),
            Text(expenseDetailsData.location,
                style: Theme.of(context).textTheme.small),
            const SizedBox(height: tinySpacing),
            Text(
              DatabaseUtil.getText('Currency'),
              style: Theme.of(context).textTheme.medium,
            ),
            const SizedBox(height: xxTinierSpacing),
            Text(expenseDetailsData.currencyname,
                style: Theme.of(context).textTheme.small),
            const SizedBox(height: tinySpacing),
            Text(DatabaseUtil.getText('Total'),
                style: Theme.of(context).textTheme.medium),
            const SizedBox(height: xxTinierSpacing),
            Text(expenseDetailsData.total,
                style: Theme.of(context).textTheme.small),
            const SizedBox(height: tinySpacing),
            Text(DatabaseUtil.getText('Purpose'),
                style: Theme.of(context).textTheme.medium),
            const SizedBox(height: xxTinierSpacing),
            Text(expenseDetailsData.purpose,
                style: Theme.of(context).textTheme.small),
            const SizedBox(height: xxxSmallestSpacing)
          ],
        ));
  }
}
