import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../../blocs/expense/expense_bloc.dart';
import '../../../../blocs/expense/expense_event.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../widgets/generic_app_bar.dart';
import '../expense_details_tab_one.dart';

class ExpenseWorkingAtNumberList extends StatelessWidget {
  final Map workingAtNumberMap;

  const ExpenseWorkingAtNumberList({Key? key, required this.workingAtNumberMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            const GenericAppBar(title: StringConstants.kSelectWorkingAtNumber),
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
                          ExpenseDetailsTabOne.itemMasterList[3].isNotEmpty,
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
                              ExpenseDetailsTabOne.itemMasterList[3].length,
                          itemBuilder: (context, index) {
                            return RadioListTile(
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                activeColor: AppColor.deepBlue,
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                title: Text(ExpenseDetailsTabOne
                                    .itemMasterList[3][index].workingatnumber),
                                value: ExpenseDetailsTabOne
                                    .itemMasterList[3][index].workingat,
                                groupValue: workingAtNumberMap[
                                        'working_at_number_id'] ??
                                    '',
                                onChanged: (value) {
                                  workingAtNumberMap['working_at_number_id'] =
                                      ExpenseDetailsTabOne
                                          .itemMasterList[3][index].workingat;
                                  workingAtNumberMap['working_at_number'] =
                                      ExpenseDetailsTabOne
                                          .itemMasterList[3][index]
                                          .workingatnumber;
                                  context.read<ExpenseBloc>().add(
                                      SelectExpenseWorkingAtNumber(
                                          workingAtNumberMap:
                                              workingAtNumberMap));
                                  Navigator.pop(context);
                                });
                          }),
                    ),
                    const SizedBox(height: xxxSmallerSpacing)
                  ])),
        ));
  }
}
