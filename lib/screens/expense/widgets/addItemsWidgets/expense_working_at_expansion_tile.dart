import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../../blocs/expense/expense_bloc.dart';
import '../../../../blocs/expense/expense_event.dart';
import '../../../../blocs/expense/expense_state.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_dimensions.dart';
import '../../../../data/enums/expense_working_at_enum.dart';

class ExpenseWorkingAtExpansionTile extends StatelessWidget {
  const ExpenseWorkingAtExpansionTile({Key? key}) : super(key: key);
  static Map workingAtMap = {};

  @override
  Widget build(BuildContext context) {
    context
        .read<ExpenseBloc>()
        .add(SelectExpenseWorkingAtOption(workingAtMap: {}));
    return BlocBuilder<ExpenseBloc, ExpenseStates>(
      buildWhen: (previousState, currentState) =>
          currentState is ExpenseWorkingAtOptionSelected,
      builder: (context, state) {
        if (state is ExpenseWorkingAtOptionSelected) {
          return Theme(
              data: Theme.of(context)
                  .copyWith(dividerColor: AppColor.transparent),
              child: ExpansionTile(
                  key: GlobalKey(),
                  title: Text(
                      state.workingAtMap['working_at_value'] ??
                          StringConstants.kSelect,
                      style: Theme.of(context).textTheme.xSmall),
                  children: [
                    ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: ExpenseWorkingAtEnum.values.length,
                        itemBuilder: (BuildContext context, int index) {
                          return RadioListTile(
                              contentPadding: const EdgeInsets.only(
                                  left: kExpansionTileMargin,
                                  right: kExpansionTileMargin),
                              activeColor: AppColor.deepBlue,
                              title: Text(
                                  ExpenseWorkingAtEnum.values
                                      .elementAt(index)
                                      .status,
                                  style: Theme.of(context).textTheme.xSmall),
                              controlAffinity: ListTileControlAffinity.trailing,
                              value: ExpenseWorkingAtEnum.values
                                  .elementAt(index)
                                  .value,
                              groupValue:
                                  state.workingAtMap['working_at_id'] ?? '',
                              onChanged: (value) {
                                workingAtMap['working_at_id'] =
                                    ExpenseWorkingAtEnum.values
                                        .elementAt(index)
                                        .value;
                                workingAtMap['working_at_value'] =
                                    ExpenseWorkingAtEnum.values
                                        .elementAt(index)
                                        .status;
                                context.read<ExpenseBloc>().add(
                                    SelectExpenseWorkingAtOption(
                                        workingAtMap: workingAtMap));
                              });
                        })
                  ]));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
