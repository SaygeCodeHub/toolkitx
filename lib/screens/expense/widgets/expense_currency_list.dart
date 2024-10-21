import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/expense/expense_bloc.dart';

import '../../../blocs/expense/expense_event.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/expense/fetch_expense_master_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/generic_app_bar.dart';

class ExpenseCurrencyList extends StatelessWidget {
  final List<List<ExpenseMasterDatum>> data;
  final Map currencyDetailsMap;

  const ExpenseCurrencyList(
      {super.key, required this.data, required this.currencyDetailsMap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kSelectCurrency),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.only(
                  left: leftRightMargin, right: leftRightMargin),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data[0].length,
                        itemBuilder: (context, index) {
                          return RadioListTile(
                              contentPadding: EdgeInsets.zero,
                              activeColor: AppColor.deepBlue,
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Text(data[0][index].currency),
                              value: data[0][index].id.toString(),
                              groupValue: currencyDetailsMap['currency_id'],
                              onChanged: (value) {
                                currencyDetailsMap['currency_id'] ==
                                        currencyDetailsMap['currency_id']
                                    ? currencyDetailsMap['new_currency_id'] =
                                        value
                                    : currencyDetailsMap['currency_id'] = '';
                                currencyDetailsMap['currency_name'] =
                                    data[0][index].currency;
                                context.read<ExpenseBloc>().add(
                                    ExpenseSelectCurrency(
                                        currencyDetailsMap:
                                            currencyDetailsMap));
                                Navigator.pop(context);
                              });
                        }),
                    const SizedBox(height: xxxSmallerSpacing)
                  ])),
        ));
  }
}
