import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../../blocs/expense/expense_bloc.dart';
import '../../../../blocs/expense/expense_event.dart';
import '../../../../blocs/expense/expense_state.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_dimensions.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../utils/database_utils.dart';
import 'expense_add_items_currency_list.dart';

class ExpenseAddItemCurrencyListTile extends StatelessWidget {
  const ExpenseAddItemCurrencyListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context
        .read<ExpenseBloc>()
        .add(SelectExpenseAddItemsCurrency(currencyDetailsMap: {}));
    return BlocBuilder<ExpenseBloc, ExpenseStates>(
      builder: (context, state) {
        if (state is ExpenseAddItemsCurrencySelected) {
          return ListTile(
              contentPadding: EdgeInsets.zero,
              onTap: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ExpenseAddItemsCurrencyList(
                            currencyDetailsMap: state.currencyDetailsMap)));
              },
              title: Text(DatabaseUtil.getText('Currency'),
                  style: Theme.of(context).textTheme.xSmall.copyWith(
                      color: AppColor.black, fontWeight: FontWeight.w600)),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: tiniestSpacing),
                child: Text(state.currencyDetailsMap['currency_name'] ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(color: AppColor.black)),
              ),
              trailing:
                  const Icon(Icons.navigate_next_rounded, size: kIconSize));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
