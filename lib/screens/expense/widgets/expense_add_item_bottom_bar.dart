import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';

import '../../../blocs/expense/expense_bloc.dart';
import '../../../blocs/expense/expense_event.dart';
import '../../../blocs/expense/expense_state.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/progress_bar.dart';
import 'expense_details_tab_one.dart';

class ExpenseAddItemBottomBar extends StatelessWidget {
  final String expenseId;

  const ExpenseAddItemBottomBar({Key? key, required this.expenseId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExpenseBloc, ExpenseStates>(
      listener: (context, state) {
        if (state is SavingExpenseItem) {
          ProgressBar.show(context);
        } else if (state is ExpenseItemSaved) {
          ProgressBar.dismiss(context);
        } else if (state is ExpenseItemCouldNotSave) {
          ProgressBar.dismiss(context);
          showCustomSnackBar(context, state.itemNotSaved, '');
        }
      },
      buildWhen: (previousState, currentState) =>
          currentState is FetchingExpenseItemMaster ||
          currentState is ExpenseItemMasterFetched,
      builder: (context, state) {
        if (state is ExpenseItemMasterFetched) {
          if (state.isScreenChange == true) {
            return BottomAppBar(
              child: Row(children: [
                Expanded(
                    child: PrimaryButton(
                  onPressed: () {
                    context
                        .read<ExpenseBloc>()
                        .add(FetchExpenseItemMaster(isScreenChange: false));
                  },
                  textValue: DatabaseUtil.getText('buttonBack'),
                )),
                const SizedBox(width: xxTinierSpacing),
                Expanded(
                    child: PrimaryButton(
                        onPressed: () {
                          context.read<ExpenseBloc>().add(SaveExpenseItem(
                              expenseItemMap: ExpenseDetailsTabOne.addItemMap));
                        },
                        textValue: DatabaseUtil.getText('buttonSave')))
              ]),
            );
          } else {
            return BottomAppBar(
              child: Row(children: [
                Expanded(
                    child: PrimaryButton(
                  onPressed: () {
                    context.read<ExpenseBloc>().add(
                        FetchExpenseDetails(tabIndex: 0, expenseId: expenseId));
                  },
                  textValue: DatabaseUtil.getText('buttonBack'),
                )),
                const SizedBox(width: xxTinierSpacing),
                Expanded(
                    child: PrimaryButton(
                        onPressed: () {
                          if (ExpenseDetailsTabOne.addItemMap['date'] == null &&
                              ExpenseDetailsTabOne.addItemMap['itemid'] ==
                                  null) {
                            showCustomSnackBar(
                                context,
                                StringConstants
                                    .kExpenseAddItemDateAndItemValidation,
                                '');
                          } else {
                            context.read<ExpenseBloc>().add(
                                FetchExpenseItemMaster(isScreenChange: true));
                          }
                        },
                        textValue: DatabaseUtil.getText('nextButtonText')))
              ]),
            );
          }
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
