import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../../blocs/expense/expense_bloc.dart';
import '../../../../blocs/expense/expense_event.dart';
import '../../../../blocs/expense/expense_state.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_dimensions.dart';
import '../../../../utils/constants/string_constants.dart';
import 'expense_working_at_number_list.dart';

class ExpenseWorkingAtNumberListTile extends StatelessWidget {
  static Map workingAtNumberMap = {};

  const ExpenseWorkingAtNumberListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context
        .read<ExpenseBloc>()
        .add(SelectExpenseWorkingAtNumber(workingAtNumberMap: {}));
    return BlocBuilder<ExpenseBloc, ExpenseStates>(
      buildWhen: (previousState, currentState) =>
          currentState is ExpenseWorkingAtNumberSelected,
      builder: (context, state) {
        if (state is ExpenseWorkingAtNumberSelected) {
          return ListTile(
              contentPadding: EdgeInsets.zero,
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ExpenseWorkingAtNumberList(
                        workingAtNumberMap: workingAtNumberMap)));
              },
              title: Text(
                StringConstants.kWorkingAtNumber,
                style: Theme.of(context).textTheme.xSmall.copyWith(
                    color: AppColor.black, fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                state.workingAtNumberMap['working_at_number'] ?? '',
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
