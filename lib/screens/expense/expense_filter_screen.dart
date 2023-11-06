import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/expense/expense_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/expense/expense_list_screen.dart';

import '../../blocs/expense/expense_event.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_filter_date_range_field_widget.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/generic_text_field.dart';
import '../../widgets/primary_button.dart';
import 'widgets/expense_status_expansion_tile.dart';

class ExpenseFilterScreen extends StatelessWidget {
  static const routeName = 'ExpenseFilterScreen';

  const ExpenseFilterScreen({Key? key}) : super(key: key);
  static Map expenseFilterMap = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(title: StringConstants.kApplyFilter),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: topBottomPadding),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(DatabaseUtil.getText('DateRange'),
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: xxTinierSpacing),
                  CustomFilterDateRangeFieldWidget(
                    fromDate: expenseFilterMap['st'] ?? '',
                    toDate: expenseFilterMap['et'] ?? '',
                    onFromDateSelected: (String fromDate) {
                      expenseFilterMap['st'] = fromDate;
                    },
                    onToDateSelected: (String toDate) {
                      expenseFilterMap['et'] = toDate;
                    },
                  ),
                  const SizedBox(height: xxTinySpacing),
                  Text(DatabaseUtil.getText('Keywords'),
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: xxTinierSpacing),
                  TextFieldWidget(
                      value: expenseFilterMap['keyword'] ?? '',
                      onTextFieldChanged: (String textField) {
                        expenseFilterMap['keyword'] = textField;
                      }),
                  const SizedBox(height: xxTinySpacing),
                  Text(DatabaseUtil.getText('Status'),
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: xxTinierSpacing),
                  const ExpenseStatusExpansionTile(),
                  const SizedBox(height: xxxSmallerSpacing),
                  PrimaryButton(
                      onPressed: () {
                        context.read<ExpenseBloc>().add(ExpenseApplyFilter(
                            expenseFilterMap: expenseFilterMap));
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(
                            context, ExpenseListScreen.routeName,
                            arguments: false);
                      },
                      textValue: DatabaseUtil.getText('Apply'))
                ])),
      ),
    );
  }
}
