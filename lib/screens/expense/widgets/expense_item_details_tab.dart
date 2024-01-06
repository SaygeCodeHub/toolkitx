import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/expense/fetch_expense_details_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_card.dart';

class ExpenseItemDetailTab extends StatelessWidget {
  final int tabIndex;
  final ExpenseDetailsData expenseDetailsData;

  const ExpenseItemDetailTab(
      {super.key, required this.tabIndex, required this.expenseDetailsData});

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: expenseDetailsData.itemlist.isNotEmpty,
        replacement: Center(
          child: Text(StringConstants.kNoItems,
              style: Theme.of(context).textTheme.medium),
        ),
        child: Expanded(
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: expenseDetailsData.itemlist.length,
                itemBuilder: (context, index) {
                  return CustomCard(
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(xxTinierSpacing),
                      title: Padding(
                          padding:
                              const EdgeInsets.only(bottom: xxTinierSpacing),
                          child: Text(
                              expenseDetailsData.itemlist[index].itemname,
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
                })));
  }
}
