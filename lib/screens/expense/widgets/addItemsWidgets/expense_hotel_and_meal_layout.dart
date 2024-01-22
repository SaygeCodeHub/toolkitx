import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/expense/expense_bloc.dart';
import '../../../../blocs/expense/expense_event.dart';
import '../../../../blocs/expense/expense_state.dart';
import '../../../../data/models/expense/fetch_expense_details_model.dart';
import '../../../../utils/expense_add_item_custom_field_util.dart';
import '../expense_details_tab_one.dart';
import 'expense_edit_items_screen.dart';

class ExpenseHotelAndMealLayout extends StatelessWidget {
  final ExpenseDetailsData expenseDetailsData;
  static List<Map<String, dynamic>> expenseCustomFieldsList = [];

  const ExpenseHotelAndMealLayout(
      {super.key, required this.expenseDetailsData});

  @override
  Widget build(BuildContext context) {
    context
        .read<ExpenseBloc>()
        .add(FetchExpenseItemCustomFields(customFieldsMap: {
          "itemid": (ExpenseEditItemsScreen.editExpenseMap['itemid'] != null ||
                  ExpenseEditItemsScreen.editExpenseMap['itemid'] != '')
              ? ExpenseEditItemsScreen.editExpenseMap['itemid']
              : ExpenseDetailsTabOne.manageItemsMap['itemid'] ?? '',
          "expenseitemid": expenseDetailsData.id
        }));
    return BlocBuilder<ExpenseBloc, ExpenseStates>(
      buildWhen: (previousState, currentState) =>
          currentState is ExpenseCustomFieldsFetched ||
          currentState is ExpenseCustomFieldsNotFetched,
      builder: (context, state) {
        if (state is ExpenseCustomFieldsFetched) {
          return ExpenseAddItemCustomFieldUtil().viewCustomFields(context,
              state.expenseItemCustomFieldsModel.data, expenseCustomFieldsList);
        } else if (state is ExpenseCustomFieldsNotFetched) {
          return Text(state.fieldsNotFetched);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
