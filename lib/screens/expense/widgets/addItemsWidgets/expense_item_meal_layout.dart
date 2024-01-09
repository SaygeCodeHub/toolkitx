import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/expense/expense_state.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../../blocs/expense/expense_bloc.dart';
import '../../../../blocs/expense/expense_event.dart';
import '../../../../data/models/expense/fetch_expense_details_model.dart';
import '../expense_details_tab_one.dart';

class ExpenseItemMealLayout extends StatelessWidget {
  final ExpenseDetailsData expenseDetailsData;

  const ExpenseItemMealLayout({super.key, required this.expenseDetailsData});

  @override
  Widget build(BuildContext context) {
    context
        .read<ExpenseBloc>()
        .add(FetchExpenseItemCustomFields(customFieldsMap: {
          "itemid": ExpenseDetailsTabOne.addItemMap['itemid'] ?? '',
          "expenseitemid": expenseDetailsData.id
        }));
    return BlocBuilder<ExpenseBloc, ExpenseStates>(
      buildWhen: (previousState, currentState) =>
          currentState is FetchingExpenseCustomFields ||
          currentState is ExpenseCustomFieldsFetched ||
          currentState is ExpenseCustomFieldsNotFetched,
      builder: (context, state) {
        if (state is FetchingExpenseCustomFields) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ExpenseCustomFieldsFetched) {
          return ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                switch (state.expenseItemCustomFieldsModel.data[index].type) {
                  case 3:
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            state
                                .expenseItemCustomFieldsModel.data[index].title,
                            style: Theme.of(context)
                                .textTheme
                                .xSmall
                                .copyWith(fontWeight: FontWeight.w600)),
                        const SizedBox(height: xxxTinierSpacing),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.expenseItemCustomFieldsModel
                                .data[index].queoptions.length,
                            itemBuilder: (context, itemIndex) {
                              return RadioListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(state
                                      .expenseItemCustomFieldsModel
                                      .data[index]
                                      .queoptions[itemIndex]
                                      .queoptiontext),
                                  value: state
                                      .expenseItemCustomFieldsModel
                                      .data[index]
                                      .queoptions[itemIndex]
                                      .queoptionid,
                                  groupValue: '',
                                  onChanged: (_) {});
                            }),
                      ],
                    );
                  default:
                    return const SizedBox();
                }
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: xxTinierSpacing);
              },
              itemCount: state.expenseItemCustomFieldsModel.data.length);
        } else if (state is ExpenseCustomFieldsNotFetched) {
          return Text(state.fieldsNotFetched);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
