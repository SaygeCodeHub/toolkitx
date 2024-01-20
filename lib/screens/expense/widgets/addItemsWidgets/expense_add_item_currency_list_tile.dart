import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../../blocs/expense/expense_bloc.dart';
import '../../../../blocs/expense/expense_event.dart';
import '../../../../blocs/expense/expense_state.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_dimensions.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../data/models/expense/fetch_expense_details_model.dart';
import '../../../../utils/database_utils.dart';
import '../../../../widgets/generic_text_field.dart';
import '../expense_details_tab_one.dart';
import 'expense_add_items_currency_list.dart';
import 'expense_edit_items_screen.dart';

class ExpenseAddItemCurrencyListTile extends StatelessWidget {
  final ExpenseDetailsData expenseDetailsData;

  const ExpenseAddItemCurrencyListTile(
      {Key? key, required this.expenseDetailsData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ExpenseEditItemsScreen.editExpenseMap['currency'] =
        ExpenseEditItemsScreen.editExpenseMap['item_details_model'].currency ??
            '';
    context
        .read<ExpenseBloc>()
        .add(SelectExpenseAddItemsCurrency(currencyDetailsMap: {
          'currency_id': ExpenseEditItemsScreen
                  .editExpenseMap['item_details_model'].currency ??
              '',
          'currency_name': expenseDetailsData.currencyname
        }));
    return BlocBuilder<ExpenseBloc, ExpenseStates>(
      buildWhen: (previousState, currentState) =>
          currentState is ExpenseAddItemsCurrencySelected,
      builder: (context, state) {
        if (state is ExpenseAddItemsCurrencySelected) {
          expenseDetailsData.currency.isNotEmpty
              ? ExpenseDetailsTabOne.manageItemsMap['currency'] =
                  expenseDetailsData.currency
              : state.currencyDetailsMap['currency_id'] ??
                  expenseDetailsData.currency;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  onTap: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ExpenseAddItemsCurrencyList(
                                currencyDetailsMap: state.currencyDetailsMap)));
                  },
                  title: Text(DatabaseUtil.getText('Currency'),
                      style: Theme.of(context).textTheme.xSmall.copyWith(
                          color: AppColor.black, fontWeight: FontWeight.w600)),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: tiniestSpacing),
                    child: Text(state.currencyDetailsMap['currency_name'] ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(color: AppColor.black)),
                  ),
                  trailing:
                  const Icon(Icons.navigate_next_rounded, size: kIconSize)),
              Visibility(
                visible: state.currencyDetailsMap['currency_name'] != null,
                child: Text(DatabaseUtil.getText('Exchangerate'),
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: xxxTinierSpacing),
              Visibility(
                  visible: state.currencyDetailsMap['currency_name'] != null,
                  child: TextFieldWidget(
                      value: ExpenseEditItemsScreen
                              .editExpenseMap['item_details_model']
                              .exchangerate ??
                          '',
                      maxLength: 20,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,
                      onTextFieldChanged: (String textField) {
                        ExpenseDetailsTabOne.manageItemsMap['exchange_rate'] =
                            textField;
                      })),
              const SizedBox(height: xxTinySpacing),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
