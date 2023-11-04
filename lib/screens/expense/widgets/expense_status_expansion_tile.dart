import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/expense/expense_state.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../blocs/expense/expense_bloc.dart';
import '../../../blocs/expense/expense_event.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/enums/expense_status_enum.dart';
import '../expense_filter_screen.dart';

class ExpenseStatusExpansionTile extends StatelessWidget {
  const ExpenseStatusExpansionTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ExpenseBloc>().add(SelectExpenseStatus(
        statusIdList: [], statusId: '', statusName: '', statusNameList: []));
    return BlocBuilder<ExpenseBloc, ExpenseStates>(
      buildWhen: (previousState, currentState) =>
          currentState is ExpenseStatusSelected,
      builder: (context, state) {
        if (state is ExpenseStatusSelected) {
          ExpenseFilterScreen.expenseFilterMap['status'] = state.statusIdList
              .toString()
              .replaceAll('[', '')
              .replaceAll(']', '')
              .replaceFirst(',', '');
          return Theme(
              data: Theme.of(context)
                  .copyWith(dividerColor: AppColor.transparent),
              child: ExpansionTile(
                  title: Text(
                      (state.statusValueList.isEmpty)
                          ? StringConstants.kSelect
                          : state.statusValueList
                              .toString()
                              .replaceAll('[', '')
                              .replaceAll(']', '')
                              .replaceFirst(',', ''),
                      style: Theme.of(context).textTheme.xSmall),
                  children: [
                    ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: ExpenseStatusEnum.values.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CheckboxListTile(
                              contentPadding:
                                  const EdgeInsets.only(left: xxxTinierSpacing),
                              activeColor: AppColor.deepBlue,
                              title: Text(
                                  ExpenseStatusEnum.values
                                      .elementAt(index)
                                      .status,
                                  style: Theme.of(context).textTheme.xSmall),
                              controlAffinity: ListTileControlAffinity.trailing,
                              value: state.statusIdList.contains(
                                  ExpenseStatusEnum.values
                                      .elementAt(index)
                                      .value),
                              onChanged: (value) {
                                context.read<ExpenseBloc>().add(
                                    SelectExpenseStatus(
                                        statusIdList: state.statusIdList,
                                        statusId:
                                            ExpenseStatusEnum
                                                .values
                                                .elementAt(index)
                                                .value,
                                        statusName: ExpenseStatusEnum.values
                                            .elementAt(index)
                                            .status,
                                        statusNameList: state.statusValueList));
                              });
                        })
                  ]));
        } else {
          return const Text(StringConstants.kNoData);
        }
      },
    );
  }
}
