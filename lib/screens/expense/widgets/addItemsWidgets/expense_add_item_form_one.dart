import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../../configs/app_spacing.dart';
import '../../../../utils/constants/string_constants.dart';
import 'expense_date_list_tile.dart';
import 'expense_item_list_tile.dart';
import 'expense_working_at_expansion_tile.dart';
import 'expense_working_at_number_list_tile.dart';

class ExpenseAddItemFormOne extends StatelessWidget {
  const ExpenseAddItemFormOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ExpenseDateExpansionTile(),
          const ExpenseItemListTile(),
          const ExpenseWorkingAtNumberListTile(),
          const SizedBox(height: xxTinySpacing),
          Text(StringConstants.kWorkingAt,
              style: Theme.of(context)
                  .textTheme
                  .xSmall
                  .copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: xxxTinierSpacing),
          const ExpenseWorkingAtExpansionTile(),
          const SizedBox(height: xxxTinierSpacing),
        ],
      ),
    );
  }
}
