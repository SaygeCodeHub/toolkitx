import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/expense/expense_bloc.dart';
import '../../../../blocs/expense/expense_event.dart';
import '../../../../blocs/expense/expense_state.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../data/models/expense/fetch_expense_details_model.dart';
import '../../../../utils/database_utils.dart';
import '../../../../utils/expense_add_item_custom_field_util.dart';
import '../../../../widgets/primary_button.dart';
import 'expense_edit_form_three.dart';
import 'expense_edit_items_screen.dart';

class ExpenseEditFormTwo extends StatelessWidget {
  static const routeName = 'ExpenseEditFormTwo';
  final ExpenseDetailsData expenseDetailsData;
  static List<Map<String, dynamic>> expenseCustomFieldsList = [];

  const ExpenseEditFormTwo({super.key, required this.expenseDetailsData});

  @override
  Widget build(BuildContext context) {
    context
        .read<ExpenseBloc>()
        .add(FetchExpenseItemCustomFields(customFieldsMap: {
          "itemid": ExpenseEditItemsScreen.editExpenseMap['itemid'] ?? '',
          "expenseitemid": expenseDetailsData.id
        }));
    return Scaffold(
        appBar: AppBar(),
        bottomNavigationBar: BottomAppBar(
          child: PrimaryButton(
              onPressed: () {
                Navigator.pushNamed(context, ExpenseEditFormThree.routeName);
              },
              textValue: DatabaseUtil.getText('nextButtonText')),
        ),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing),
            child: BlocBuilder<ExpenseBloc, ExpenseStates>(
              buildWhen: (previousState, currentState) =>
                  currentState is ExpenseCustomFieldsFetched ||
                  currentState is ExpenseCustomFieldsNotFetched,
              builder: (context, state) {
                if (state is ExpenseCustomFieldsFetched) {
                  return ExpenseAddItemCustomFieldUtil().viewCustomFields(
                      context,
                      state.expenseItemCustomFieldsModel.data,
                      expenseCustomFieldsList);
                } else if (state is ExpenseCustomFieldsNotFetched) {
                  return Text(state.fieldsNotFetched);
                } else {
                  return const SizedBox.shrink();
                }
              },
            )));
  }
}
