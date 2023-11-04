import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../blocs/expense/expense_bloc.dart';
import '../../../blocs/expense/expense_event.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/custom_card.dart';
import '../expense_list_screen.dart';

class ExpenseListBody extends StatelessWidget {
  final List expenseListDatum;

  const ExpenseListBody({Key? key, required this.expenseListDatum})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: (context.read<ExpenseBloc>().expenseListReachedMax)
                ? expenseListDatum.length
                : expenseListDatum.length + 1,
            itemBuilder: (context, index) {
              if (index < expenseListDatum.length) {
                return CustomCard(
                  child: ListTile(
                    onTap: () {},
                    contentPadding: const EdgeInsets.all(xxTinierSpacing),
                    title: Padding(
                        padding: const EdgeInsets.only(bottom: xxTinierSpacing),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(expenseListDatum[index].refno,
                                  style: Theme.of(context)
                                      .textTheme
                                      .small
                                      .copyWith(
                                          color: AppColor.black,
                                          fontWeight: FontWeight.w600)),
                              const SizedBox(width: tiniestSpacing),
                              Visibility(
                                  visible: expenseListDatum[index].isdraft == 1,
                                  child: Text(StringConstants.kIsDraft,
                                      style: Theme.of(context)
                                          .textTheme
                                          .xxSmall
                                          .copyWith(color: AppColor.errorRed)))
                            ])),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset("assets/icons/calendar.png",
                                height: kIconSize, width: kIconSize),
                            const SizedBox(width: tiniestSpacing),
                            Text(expenseListDatum[index].schedule,
                                style: Theme.of(context).textTheme.xSmall)
                          ],
                        ),
                        const SizedBox(height: tinierSpacing),
                        Text(expenseListDatum[index].location,
                            style: Theme.of(context).textTheme.xSmall)
                      ],
                    ),
                  ),
                );
              } else {
                ExpenseListScreen.pageNo++;
                context.read<ExpenseBloc>().add(FetchExpenseList(
                    pageNo: ExpenseListScreen.pageNo, isFromHome: false));
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: xxTinySpacing);
            }));
  }
}
