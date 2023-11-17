import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../blocs/expense/expense_bloc.dart';
import '../../../blocs/expense/expense_event.dart';
import '../../../blocs/expense/expense_state.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/expense/fetch_expense_details_model.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_floating_action_button.dart';
import 'addItemsWidgets/expense_date_list_tile.dart';
import 'addItemsWidgets/expense_item_list_tile.dart';
import 'addItemsWidgets/expense_working_at_expansion_tile.dart';
import 'addItemsWidgets/expense_working_at_number_list_tile.dart';
import 'expense_details_tab_one_body.dart';

class ExpenseDetailsTabOne extends StatelessWidget {
  final int tabIndex;
  final ExpenseDetailsData expenseDetailsData;
  static List itemMasterList = [];

  const ExpenseDetailsTabOne(
      {Key? key, required this.tabIndex, required this.expenseDetailsData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<ExpenseBloc, ExpenseStates>(
        buildWhen: (previousState, currentState) =>
            currentState is FetchingExpenseItemMaster ||
            currentState is ExpenseItemMasterFetched,
        builder: (context, state) {
          if (state is FetchingExpenseItemMaster) {
            return const SizedBox.shrink();
          } else if (state is ExpenseItemMasterFetched) {
            return const SizedBox.shrink();
          } else {
            return CustomFloatingActionButton(
                onPressed: () {
                  context.read<ExpenseBloc>().add(FetchExpenseItemMaster());
                },
                textValue: DatabaseUtil.getText('AddItems'));
          }
        },
      ),
      body: BlocBuilder<ExpenseBloc, ExpenseStates>(
        buildWhen: (previousState, currentState) =>
            currentState is FetchingExpenseItemMaster ||
            currentState is ExpenseItemMasterFetched,
        builder: (context, state) {
          if (state is FetchingExpenseItemMaster) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ExpenseItemMasterFetched) {
            itemMasterList.addAll(state.fetchItemMasterModel.data);
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ExpenseDateExpansionTile(),
                  const ExpenseItemListTile(),
                  const SizedBox(height: xxxTinierSpacing),
                  Text(StringConstants.kWorkingAt,
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: xxxTinierSpacing),
                  const ExpenseWorkingAtExpansionTile(),
                  const SizedBox(height: xxTinySpacing),
                  const ExpenseWorkingAtNumberListTile(),
                  const SizedBox(height: xxxTinierSpacing),
                ],
              ),
            );
          } else if (state is ExpenseItemMasterCouldNotFetch) {
            return const Center(child: Text(StringConstants.kNoRecordsFound));
          } else {
            return ExpenseDetailsTabOneBody(
                expenseDetailsData: expenseDetailsData);
          }
        },
      ),
    );
  }
}
