import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/expense/expense_bloc.dart';
import 'package:toolkit/blocs/expense/expense_state.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/generic_no_records_text.dart';

import '../../blocs/expense/expense_event.dart';
import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/generic_text_field.dart';
import '../incident/widgets/date_picker.dart';
import 'widgets/expense_currency_list_tile.dart';
import 'widgets/save_expense_bottom_app_bar.dart';

class ManageExpenseFormScreen extends StatelessWidget {
  static const routeName = 'ManageExpenseFormScreen';

  const ManageExpenseFormScreen({Key? key}) : super(key: key);
  static Map manageExpenseMap = {};
  static bool isFromEditOption = false;

  @override
  Widget build(BuildContext context) {
    context.read<ExpenseBloc>().add(FetchExpenseMaster());
    isFromEditOption == true ? manageExpenseMap : manageExpenseMap.clear();
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('NewExpenseReport')),
      bottomNavigationBar: const SaveExpenseBottomAppBar(),
      body: BlocBuilder<ExpenseBloc, ExpenseStates>(
        buildWhen: (previousState, currentState) =>
            currentState is FetchingExpenseMaster ||
            currentState is ExpenseMasterFetched,
        builder: (context, state) {
          if (state is FetchingExpenseMaster) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ExpenseMasterFetched) {
            return Padding(
              padding: const EdgeInsets.only(
                  left: leftRightMargin,
                  right: leftRightMargin,
                  top: xxTinySpacing),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DatabaseUtil.getText('StartDate'),
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: xxxTinierSpacing),
                    DatePickerTextField(
                        editDate: manageExpenseMap['startdate'] ?? '',
                        onDateChanged: (String date) {
                          manageExpenseMap['startdate'] = date;
                        }),
                    const SizedBox(height: xxTinySpacing),
                    Text(DatabaseUtil.getText('EndDate'),
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: xxxTinierSpacing),
                    DatePickerTextField(
                        editDate: manageExpenseMap['enddate'] ?? '',
                        onDateChanged: (String date) {
                          manageExpenseMap['enddate'] = date;
                        }),
                    const SizedBox(height: xxTinySpacing),
                    Text(DatabaseUtil.getText('Location'),
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: xxxTinierSpacing),
                    TextFieldWidget(
                        value: manageExpenseMap['location'] ?? '',
                        maxLength: 100,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        onTextFieldChanged: (String textField) {
                          manageExpenseMap['location'] = textField;
                        }),
                    const SizedBox(height: xxTinySpacing),
                    Text(DatabaseUtil.getText('Purpose'),
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: xxxTinierSpacing),
                    TextFieldWidget(
                        value: manageExpenseMap['purpose'] ?? '',
                        maxLength: 100,
                        textInputAction: TextInputAction.done,
                        onTextFieldChanged: (String textField) {
                          manageExpenseMap['purpose'] = textField;
                        }),
                    ExpenseCurrencyListTile(
                        data: state.fetchExpenseMasterModel.data)
                  ],
                ),
              ),
            );
          } else if (state is ExpenseMasterNotFetched) {
            return NoRecordsText(text: state.masterNotFetched);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
