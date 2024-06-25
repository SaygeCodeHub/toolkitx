import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/expense/expense_bloc.dart';
import '../../../../blocs/expense/expense_event.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../data/models/expense/fetch_item_master_model.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../widgets/generic_app_bar.dart';
import '../expense_details_tab_one.dart';
import 'expense_edit_items_screen.dart';

class ExpenseAddItemsCurrencyList extends StatelessWidget {
  final Map currencyDetailsMap;
  static List<List<ItemMasterDatum>> fetchItemMaster = [];

  const ExpenseAddItemsCurrencyList(
      {Key? key, required this.currencyDetailsMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    fetchItemMaster = context.read<ExpenseBloc>().fetchItemMaster;
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
                        itemCount: (fetchItemMaster.isNotEmpty)
                            ? fetchItemMaster[1].length
                            : ExpenseDetailsTabOne.itemMasterList[1].length,
                        itemBuilder: (context, index) {
                          return RadioListTile(
                              contentPadding: EdgeInsets.zero,
                              activeColor: AppColor.deepBlue,
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Text((fetchItemMaster.isNotEmpty)
                                  ? fetchItemMaster[1][index].currency
                                  : ExpenseDetailsTabOne
                                      .itemMasterList[1][index].currency),
                              value: (fetchItemMaster.isNotEmpty)
                                  ? fetchItemMaster[1][index].id.toString()
                                  : ExpenseDetailsTabOne
                                      .itemMasterList[1][index].id
                                      .toString(),
                              groupValue:
                                  currencyDetailsMap['currency_id'] ?? '',
                              onChanged: (value) {
                                currencyDetailsMap['currency_id'] =
                                    (fetchItemMaster.isNotEmpty)
                                        ? fetchItemMaster[1][index]
                                                .id
                                                ?.toString() ??
                                            ''
                                        : ExpenseDetailsTabOne
                                                .itemMasterList[1][index].id
                                                ?.toString() ??
                                            '';
                                ExpenseDetailsTabOne
                                        .manageItemsMap['reportcurrency'] =
                                    currencyDetailsMap['currency_id'] ?? '';
                                ExpenseEditItemsScreen
                                        .editExpenseMap['reportcurrency'] =
                                    currencyDetailsMap['currency_id'] ?? '';
                                currencyDetailsMap['currency_name'] =
                                    (fetchItemMaster.isNotEmpty)
                                        ? fetchItemMaster[1][index].currency
                                        : ExpenseDetailsTabOne
                                            .itemMasterList[1][index].currency;
                                context.read<ExpenseBloc>().add(
                                    SelectExpenseAddItemsCurrency(
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
