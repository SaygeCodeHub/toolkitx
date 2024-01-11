import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/expense/expense_state.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../../blocs/expense/expense_bloc.dart';
import '../../../../blocs/expense/expense_event.dart';
import '../../../../configs/app_color.dart';
import '../../../../data/models/expense/expense_item_custom_field_model.dart';
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
                        const SizedBox(height: tinierSpacing),
                        Row(
                          children: [
                            Text('${index + 1}] ',
                                style: Theme.of(context)
                                    .textTheme
                                    .xSmall
                                    .copyWith(fontWeight: FontWeight.w600)),
                            Text(
                                state.expenseItemCustomFieldsModel.data[index]
                                    .title,
                                style: Theme.of(context)
                                    .textTheme
                                    .xSmall
                                    .copyWith(fontWeight: FontWeight.w600)),
                          ],
                        ),
                        const SizedBox(height: xxTinierSpacing),
                        CustomQuestionsRadioTile(
                            queOption: state.expenseItemCustomFieldsModel
                                .data[index].queoptions,
                            index: index)
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

class CustomQuestionsRadioTile extends StatefulWidget {
  final List<QueOption> queOption;
  final int index;

  const CustomQuestionsRadioTile(
      {super.key, required this.queOption, required this.index});

  @override
  State<CustomQuestionsRadioTile> createState() =>
      _CustomQuestionsRadioTileState();
}

class _CustomQuestionsRadioTileState extends State<CustomQuestionsRadioTile> {
  String questionId = '';
  String questionAnswer = StringConstants.kSelect;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: AppColor.transparent),
      child: ExpansionTile(
        maintainState: true,
        key: GlobalKey(),
        title: Text(questionAnswer, style: Theme.of(context).textTheme.xSmall),
        children: [
          ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: widget.queOption.length,
              itemBuilder: (context, itemIndex) {
                return RadioListTile(
                    activeColor: AppColor.deepBlue,
                    controlAffinity: ListTileControlAffinity.trailing,
                    contentPadding: EdgeInsets.zero,
                    title: Text(widget.queOption[itemIndex].queoptiontext),
                    value: widget.queOption[itemIndex].queoptionid.toString(),
                    groupValue: questionId,
                    onChanged: (val) {
                      setState(() {
                        questionId =
                            widget.queOption[itemIndex].queoptionid.toString();
                        questionAnswer =
                            widget.queOption[itemIndex].queoptiontext;
                        ExpenseDetailsTabOne.addItemMap['answer'] = questionId;
                      });
                    });
              })
        ],
      ),
    );
  }
}
