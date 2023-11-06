import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/expense/expense_bloc.dart';
import 'package:toolkit/blocs/expense/expense_state.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../../blocs/expense/expense_event.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/primary_button.dart';
import '../expense_list_screen.dart';
import '../manage_expense_form_screen.dart';

class SaveExpenseBottomAppBar extends StatelessWidget {
  const SaveExpenseBottomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: [
          Expanded(
              child: PrimaryButton(
            onPressed: () {
              Navigator.pop(context);
            },
            textValue: DatabaseUtil.getText('buttonBack'),
          )),
          const SizedBox(width: xxTinierSpacing),
          BlocListener<ExpenseBloc, ExpenseStates>(
            listener: (context, state) {
              if (state is SavingAddExpense) {
                ProgressBar.show(context);
              } else if (state is AddExpenseSaved) {
                ProgressBar.dismiss(context);
                Navigator.pop(context);
                Navigator.pushReplacementNamed(
                    context, ExpenseListScreen.routeName,
                    arguments: false);
              } else if (state is AddExpenseNotSaved) {
                ProgressBar.dismiss(context);
                showCustomSnackBar(context, state.expenseNotSaved, '');
              }
            },
            child: Expanded(
              child: PrimaryButton(
                  onPressed: () {
                    context.read<ExpenseBloc>().add(AddExpense(
                        saveExpenseMap:
                            ManageExpenseFormScreen.manageExpenseMap));
                  },
                  textValue: DatabaseUtil.getText('buttonSave')),
            ),
          ),
        ],
      ),
    );
  }
}
