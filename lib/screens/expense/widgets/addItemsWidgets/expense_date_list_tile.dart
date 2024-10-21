import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/expense/widgets/addItemsWidgets/expense_edit_items_screen.dart';

import '../../../../blocs/expense/expense_bloc.dart';
import '../../../../blocs/expense/expense_state.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_dimensions.dart';
import '../../../../utils/database_utils.dart';
import 'expense_date_list.dart';

class ExpenseDateExpansionTile extends StatelessWidget {
  const ExpenseDateExpansionTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseBloc, ExpenseStates>(
        buildWhen: (previousState, currentState) =>
            currentState is ExpenseDateSelected,
        builder: (context, state) {
          if (state is ExpenseDateSelected) {
            ExpenseEditItemsScreen.editExpenseMap['date'] = state.date;
            return ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: () async {
                  await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ExpenseDateList(date: state.date)));
                },
                title: Text(
                  DatabaseUtil.getText('Date'),
                  style: Theme.of(context).textTheme.xSmall.copyWith(
                      color: AppColor.black, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  state.date,
                  style: Theme.of(context)
                      .textTheme
                      .xSmall
                      .copyWith(color: AppColor.black),
                ),
                trailing:
                    const Icon(Icons.navigate_next_rounded, size: kIconSize));
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
