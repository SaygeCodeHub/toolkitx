import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../blocs/expense/expense_bloc.dart';
import '../../../blocs/expense/expense_event.dart';
import '../../../blocs/expense/expense_state.dart';
import '../../../blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import '../../../blocs/pickAndUploadImage/pick_and_upload_image_events.dart';
import '../../../data/models/expense/fetch_expense_details_model.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_floating_action_button.dart';
import 'addItemsWidgets/expense_add_item_form_one.dart';
import 'addItemsWidgets/expense_add_item_form_two.dart';
import 'addItemsWidgets/expense_add_item_hotel_layout.dart';
import 'addItemsWidgets/expense_item_meal_layout.dart';
import 'expense_add_item_bottom_bar.dart';
import 'expense_details_tab_one_body.dart';

class ExpenseDetailsTabOne extends StatelessWidget {
  final int tabIndex;
  final ExpenseDetailsData expenseDetailsData;
  final String expenseId;
  static List itemMasterList = [];

  const ExpenseDetailsTabOne(
      {Key? key,
      required this.tabIndex,
      required this.expenseDetailsData,
      required this.expenseId})
      : super(key: key);
  static Map addItemMap = {};

  @override
  Widget build(BuildContext context) {
    context.read<PickAndUploadImageBloc>().isInitialUpload = true;
    context.read<PickAndUploadImageBloc>().add(UploadInitial());
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: ExpenseAddItemBottomBar(
          expenseId: expenseId, expenseDetailsData: expenseDetailsData),
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
                  context
                      .read<ExpenseBloc>()
                      .add(FetchExpenseItemMaster(isScreenChange: false));
                },
                textValue: DatabaseUtil.getText('AddItems'));
          }
        },
      ),
      body: BlocBuilder<ExpenseBloc, ExpenseStates>(
        buildWhen: (previousState, currentState) =>
            currentState is FetchingExpenseItemMaster ||
            currentState is ExpenseItemMasterFetched ||
            currentState is ExpenseItemMasterCouldNotFetch,
        builder: (context, state) {
          if (state is ExpenseItemMasterFetched) {
            itemMasterList.addAll(state.fetchItemMasterModel.data);
            if (state.isScreenChange == false) {
              return const ExpenseAddItemFormOne();
            } else if (state.isScreenChange == true) {
              if (ExpenseDetailsTabOne.addItemMap['itemid'] == '6') {
                return const ExpenseAddItemHotelLayout();
              } else if (ExpenseDetailsTabOne.addItemMap['itemid'] == '3') {
                return ExpenseItemMealLayout(
                    expenseDetailsData: expenseDetailsData);
              } else {
                return ExpenseAddItemFormTwo(
                    expenseDetailsData: expenseDetailsData);
              }
            } else {
              return const SizedBox.shrink();
            }
          } else if (state is ExpenseItemMasterCouldNotFetch) {
            return const Center(child: Text(StringConstants.kNoRecordsFound));
          } else {
            if (state is ExpenseDetailsFetched) {
              return ExpenseDetailsTabOneBody(
                  expenseDetailsData: expenseDetailsData);
            } else if (state is FetchingExpenseItemMaster) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const SizedBox.shrink();
            }
          }
        },
      ),
    );
  }
}
