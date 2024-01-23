import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/expense/expense_event.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/android_pop_up.dart';
import 'package:toolkit/widgets/text_button.dart';

import '../../../blocs/expense/expense_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/expense/fetch_expense_details_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_card.dart';
import 'addItemsWidgets/expense_edit_items_screen.dart';
import 'addItemsWidgets/expense_working_at_expansion_tile.dart';

class ExpenseItemDetailTab extends StatelessWidget {
  final int tabIndex;
  final ExpenseDetailsData expenseDetailsData;
  final String expenseId;

  const ExpenseItemDetailTab(
      {super.key,
      required this.tabIndex,
      required this.expenseDetailsData,
      required this.expenseId});

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: expenseDetailsData.itemlist.isNotEmpty,
        replacement: Center(
          child: Text(StringConstants.kNoItems,
              style: Theme.of(context).textTheme.medium),
        ),
        child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: expenseDetailsData.itemlist.length,
            itemBuilder: (context, index) {
              return CustomCard(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(xxTinierSpacing),
                  trailing: PopupMenuButton(
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem(
                          padding: EdgeInsets.zero,
                          child: CustomTextButton(
                              textColor: AppColor.black,
                              onPressed: () => showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AndroidPopUp(
                                        titleValue: DatabaseUtil.getText(
                                            'ApproveLotoTitle'),
                                        contentValue:
                                            StringConstants.kDeleteItem,
                                        onPrimaryButton: () {
                                          context.read<ExpenseBloc>().add(
                                              DeleteExpenseItem(
                                                  itemId: expenseDetailsData
                                                      .itemlist[index].id));
                                          Navigator.pop(context);
                                        });
                                  }),
                              textValue: DatabaseUtil.getText('Delete')),
                        ),
                        PopupMenuItem(
                            padding: EdgeInsets.zero,
                            child: CustomTextButton(
                                textColor: AppColor.black,
                                onPressed: () {
                                  ExpenseEditItemsScreen
                                          .editExpenseMap['details_model'] =
                                      expenseDetailsData;
                                  ExpenseEditItemsScreen
                                      .editExpenseMap['expense_id'] = expenseId;
                                  context
                                      .read<ExpenseBloc>()
                                      .expenseWorkingAtMap
                                      .clear();
                                  ExpenseWorkingAtExpansionTile.workingAt = '';
                                  Navigator.pushNamed(context,
                                          ExpenseEditItemsScreen.routeName,
                                          arguments: expenseDetailsData
                                              .itemlist[index].id)
                                      .then((value) => context
                                          .read<ExpenseBloc>()
                                          .add(FetchExpenseDetails(
                                              tabIndex: 2,
                                              expenseId: expenseId)));
                                },
                                textValue: DatabaseUtil.getText('Edit')))
                      ];
                    },
                  ),
                  title: Padding(
                      padding: const EdgeInsets.only(bottom: xxTinierSpacing),
                      child: Text(expenseDetailsData.itemlist[index].itemname,
                          style: Theme.of(context).textTheme.small.copyWith(
                              color: AppColor.black,
                              fontWeight: FontWeight.w600))),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(expenseDetailsData.itemlist[index].workingat,
                          style: Theme.of(context).textTheme.xSmall),
                      const SizedBox(height: tinierSpacing),
                      Text(expenseDetailsData.itemlist[index].cost,
                          style: Theme.of(context).textTheme.xSmall),
                      const SizedBox(height: tinierSpacing),
                      Row(
                        children: [
                          Image.asset("assets/icons/calendar.png",
                              height: kIconSize, width: kIconSize),
                          const SizedBox(width: tiniestSpacing),
                          Text(expenseDetailsData.itemlist[index].date,
                              style: Theme.of(context).textTheme.xSmall)
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: xxTinySpacing);
            }));
  }
}
