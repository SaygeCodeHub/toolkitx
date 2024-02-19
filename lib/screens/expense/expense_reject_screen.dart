import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/expense/expense_bloc.dart';
import 'package:toolkit/blocs/expense/expense_event.dart';
import 'package:toolkit/blocs/expense/expense_state.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/android_pop_up.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import 'expense_list_screen.dart';

class ExpenseRejectScreen extends StatelessWidget {
  const ExpenseRejectScreen({super.key});

  static const routeName = 'ExpenseRejectScreen';
  static String comment = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(leftRightMargin),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
              child: PrimaryButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  textValue: DatabaseUtil.getText("Cancel")),
            ),
            const SizedBox(width: xxTinierSpacing),
            Expanded(
                child: BlocListener<ExpenseBloc, ExpenseStates>(
              listener: (context, state) {
                if (state is RejectingExpense) {
                  ProgressBar.show(context);
                } else if (state is ExpenseReject) {
                  ProgressBar.dismiss(context);
                  showCustomSnackBar(
                      context, StringConstants.kExpenseReportRejected, '');
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(
                      context, ExpenseListScreen.routeName,
                      arguments: false);
                } else if (state is ExpenseNotReject) {
                  ProgressBar.dismiss(context);
                  showCustomSnackBar(context, state.errorMessage, '');
                }
              },
              child: PrimaryButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AndroidPopUp(
                        titleValue: DatabaseUtil.getText('ExpenseReport'),
                        contentValue:
                            DatabaseUtil.getText('CloseExpenseReportMessage'),
                        onPrimaryButton: () {
                          context
                              .read<ExpenseBloc>()
                              .add(RejectExpense(comments: comment));
                        },
                      ),
                    );
                  },
                  textValue: DatabaseUtil.getText("Reject")),
            )),
          ]),
        ),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxxSmallerSpacing),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(StringConstants.kComments,
                  style: Theme.of(context).textTheme.smallTextBlack),
              const SizedBox(height: xxTinierSpacing),
              TextFieldWidget(
                  onTextFieldChanged: (textField) {
                    comment = textField;
                  },
                  maxLines: 3,
                  hintText: DatabaseUtil.getText("AddComment")),
            ])));
  }
}
