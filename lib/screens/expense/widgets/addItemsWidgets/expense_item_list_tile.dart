import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../../blocs/expense/expense_bloc.dart';
import '../../../../blocs/expense/expense_event.dart';
import '../../../../blocs/expense/expense_state.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_dimensions.dart';
import '../../../../utils/database_utils.dart';
import 'expense_item_list.dart';

class ExpenseItemListTile extends StatelessWidget {
  final String itemId;
  final String itemName;

  const ExpenseItemListTile({super.key, this.itemId = '', this.itemName = ''});

  @override
  Widget build(BuildContext context) {
    context.read<ExpenseBloc>().add(SelectExpenseItem(
        itemsMap: {'item_id': itemId, 'item_name': itemName}));
    return BlocBuilder<ExpenseBloc, ExpenseStates>(
      buildWhen: (previousState, currentState) =>
          currentState is ExpenseItemSelected,
      builder: (context, state) {
        if (state is ExpenseItemSelected) {
          return ListTile(
              contentPadding: EdgeInsets.zero,
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ExpenseItemList(itemMap: state.itemsMap)));
              },
              title: Text(DatabaseUtil.getText('Item'),
                  style: Theme.of(context).textTheme.xSmall.copyWith(
                      color: AppColor.black, fontWeight: FontWeight.w600)),
              subtitle: Text(
                state.itemsMap['item_name'] ?? '',
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
      },
    );
  }
}
