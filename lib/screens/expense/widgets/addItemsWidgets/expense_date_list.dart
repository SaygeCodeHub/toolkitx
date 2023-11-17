import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../../../blocs/expense/expense_bloc.dart';
import '../../../../blocs/expense/expense_event.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_spacing.dart';
import '../expense_details_tab_one.dart';

class ExpenseDateList extends StatelessWidget {
  final String date;

  const ExpenseDateList({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kSelectDate),
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
                          ExpenseDetailsTabOne.itemMasterList[2].isNotEmpty,
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
                              ExpenseDetailsTabOne.itemMasterList[2].length,
                          itemBuilder: (context, index) {
                            return RadioListTile(
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                activeColor: AppColor.deepBlue,
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                title: Text(ExpenseDetailsTabOne
                                    .itemMasterList[2][index].date),
                                value: ExpenseDetailsTabOne
                                    .itemMasterList[2][index].date,
                                groupValue: date,
                                onChanged: (value) {
                                  context.read<ExpenseBloc>().add(
                                      SelectExpenseDate(
                                          date: ExpenseDetailsTabOne
                                              .itemMasterList[2][index].date));
                                  Navigator.pop(context);
                                });
                          }),
                    ),
                    const SizedBox(height: xxxSmallerSpacing)
                  ])),
        ));
  }
}
