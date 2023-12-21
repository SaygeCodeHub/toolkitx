import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/expense/expense_bloc.dart';
import '../../../blocs/expense/expense_event.dart';
import '../../../blocs/expense/expense_state.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/primary_button.dart';

class ExpenseAddItemBottomBar extends StatelessWidget {
  final String expenseId;

  const ExpenseAddItemBottomBar({Key? key, required this.expenseId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseBloc, ExpenseStates>(
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
                        onPressed: () {},
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
                          context.read<ExpenseBloc>().add(
                              FetchExpenseItemMaster(isScreenChange: true));
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
