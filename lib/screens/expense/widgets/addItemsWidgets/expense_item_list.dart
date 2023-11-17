import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../../blocs/expense/expense_bloc.dart';
import '../../../../blocs/expense/expense_event.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../widgets/generic_app_bar.dart';
import '../expense_details_tab_one.dart';

class ExpenseItemList extends StatelessWidget {
  final Map itemMap;

  const ExpenseItemList({Key? key, required this.itemMap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kSelectItem),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.only(
                  left: leftRightMargin, right: leftRightMargin),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible:
                          ExpenseDetailsTabOne.itemMasterList[0].isNotEmpty,
                      replacement: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 2.7),
                        child: Center(
                            child: Text(StringConstants.kNoRecordsFound,
                                style: Theme.of(context).textTheme.medium)),
                      ),
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              ExpenseDetailsTabOne.itemMasterList[0].length,
                          itemBuilder: (context, index) {
                            return RadioListTile(
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                activeColor: AppColor.deepBlue,
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                title: Text(ExpenseDetailsTabOne
                                    .itemMasterList[0][index].name),
                                value: ExpenseDetailsTabOne
                                    .itemMasterList[0][index].id
                                    .toString(),
                                groupValue: itemMap['item_id'],
                                onChanged: (value) {
                                  itemMap['item_id'] = ExpenseDetailsTabOne
                                      .itemMasterList[0][index].id
                                      .toString();
                                  itemMap['item_name'] = ExpenseDetailsTabOne
                                      .itemMasterList[0][index].name;
                                  context.read<ExpenseBloc>().add(
                                      SelectExpenseItem(itemsMap: itemMap));
                                  Navigator.pop(context);
                                });
                          }),
                    ),
                    const SizedBox(height: xxxSmallerSpacing)
                  ])),
        ));
  }
}
