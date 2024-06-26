import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/expense/widgets/editItemsWidgets/expense_edit_item_list.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_no_records_text.dart';

import '../../../../blocs/expense/expense_bloc.dart';
import '../../../../blocs/expense/expense_event.dart';
import '../../../../blocs/expense/expense_state.dart';
import '../../../../blocs/imagePickerBloc/image_picker_bloc.dart';
import '../../../../blocs/imagePickerBloc/image_picker_event.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../utils/database_utils.dart';
import '../../../../widgets/primary_button.dart';
import 'expense_date_list_tile.dart';
import 'expense_edit_form_three.dart';
import 'expense_edit_form_two.dart';
import 'expense_working_at_expansion_tile.dart';
import 'expense_working_at_number_list_tile.dart';

class ExpenseEditItemsScreen extends StatelessWidget {
  static const routeName = 'ExpenseEditItemsScreen';
  final String expenseItemId;
  static Map editExpenseMap = {};

  const ExpenseEditItemsScreen({super.key, required this.expenseItemId});

  @override
  Widget build(BuildContext context) {
    context
        .read<ExpenseBloc>()
        .add(FetchExpenseItemDetails(expenseItemId: expenseItemId));
    return Scaffold(
      appBar: const GenericAppBar(title: StringConstants.kEditItem),
      bottomNavigationBar: BottomAppBar(
        child: PrimaryButton(
          onPressed: () {
            if (editExpenseMap['item_details_model'].itemid == '3' ||
                ExpenseEditItemsScreen.editExpenseMap['itemid'] == '3' ||
                editExpenseMap['item_details_model'].itemid == '6' ||
                ExpenseEditItemsScreen.editExpenseMap['itemid'] == '6') {
              Navigator.pushNamed(context, ExpenseEditFormTwo.routeName,
                  arguments: [
                    (editExpenseMap['item_details_model'].itemid !=
                            ExpenseEditItemsScreen.editExpenseMap['itemid'])
                        ? ExpenseEditItemsScreen.editExpenseMap['itemid']
                        : editExpenseMap['item_details_model'].itemid,
                    expenseItemId
                  ]);
            } else {
              context.read<ImagePickerBloc>().pickedImagesList.clear();
              context.read<ImagePickerBloc>().add(PickImageInitial());
              Navigator.pushNamed(context, ExpenseEditFormThree.routeName);
            }
          },
          textValue: DatabaseUtil.getText('nextButtonText'),
        ),
      ),
      body: BlocBuilder<ExpenseBloc, ExpenseStates>(
        buildWhen: (previousState, currentState) =>
            currentState is FetchingExpenseItemDetails ||
            currentState is ExpenseItemDetailsFetched ||
            currentState is ExpenseItemDetailsNotFetched,
        builder: (context, state) {
          if (state is FetchingExpenseItemDetails) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ExpenseItemDetailsFetched) {
            editExpenseMap['item_details_model'] =
                state.fetchExpenseItemDetailsModel.data;
            editExpenseMap['id'] = state.fetchExpenseItemDetailsModel.data.id;
            ExpenseEditItemsScreen.editExpenseMap['images'] =
                state.fetchExpenseItemDetailsModel.data.filenames;
            ExpenseEditItemsScreen.editExpenseMap['clientId'] = state.clientId;
            return Padding(
              padding: const EdgeInsets.only(
                  left: leftRightMargin,
                  right: leftRightMargin,
                  top: xxTinierSpacing),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ExpenseDateExpansionTile(),
                  ExpenseEditItemListTile(
                      itemId: state.fetchExpenseItemDetailsModel.data.itemid,
                      itemName:
                          state.fetchExpenseItemDetailsModel.data.itemName),
                  Text(StringConstants.kWorkingAt,
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: xxxTinierSpacing),
                  const ExpenseWorkingAtExpansionTile(),
                  const ExpenseWorkingAtNumberListTile(),
                  const SizedBox(height: xxTinySpacing)
                ],
              ),
            );
          } else if (state is ExpenseItemDetailsNotFetched) {
            return NoRecordsText(text: state.itemDetailsNotFetched);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
