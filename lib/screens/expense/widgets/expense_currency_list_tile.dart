import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/expense/expense_bloc.dart';
import 'package:toolkit/blocs/expense/expense_state.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/expense/expense_event.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/expense/fetch_expense_master_model.dart';
import '../../../utils/database_utils.dart';
import '../manage_expense_form_screen.dart';
import 'expense_currency_list.dart';

class ExpenseCurrencyListTile extends StatelessWidget {
  final List<List<ExpenseMasterDatum>> data;

  const ExpenseCurrencyListTile({Key? key, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ExpenseBloc>().add(ExpenseSelectCurrency(
        currencyDetailsMap: ManageExpenseFormScreen.manageExpenseMap));
    return BlocBuilder<ExpenseBloc, ExpenseStates>(
      buildWhen: (previousState, currentState) =>
          currentState is ExpenseCurrencySelected,
      builder: (context, state) {
        if (state is ExpenseCurrencySelected) {
          ManageExpenseFormScreen.manageExpenseMap['currency'] =
              state.currencyDetailsMap['new_currency_id'] ?? '';
          return ListTile(
              contentPadding: EdgeInsets.zero,
              onTap: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ExpenseCurrencyList(
                            data: data,
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
