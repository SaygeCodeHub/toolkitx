import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/expense/expense_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/expense/expense_reject_screen.dart';
import 'package:toolkit/widgets/android_pop_up.dart';

import '../../blocs/expense/expense_event.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';
import 'manage_expense_form_screen.dart';

class ExpensePopUpMenuScreen extends StatelessWidget {
  final List popUpMenuOptions;
  final Map manageExpenseMap;

  const ExpensePopUpMenuScreen(
      {super.key,
      required this.popUpMenuOptions,
      required this.manageExpenseMap});

  PopupMenuItem _buildPopupMenuItem(context, String title, String position) {
    return PopupMenuItem(
        value: position,
        child: Text(title, style: Theme.of(context).textTheme.xSmall));
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kCardRadius)),
      iconSize: kIconSize,
      icon: const Icon(Icons.more_vert_outlined),
      offset: const Offset(0, xxTinierSpacing),
      onSelected: (value) {
        if (value == DatabaseUtil.getText('Edit')) {
          ManageExpenseFormScreen.manageExpenseMap = manageExpenseMap;
          ManageExpenseFormScreen.isFromEditOption = true;
          Navigator.pushNamed(context, ManageExpenseFormScreen.routeName);
        }
        if (value == DatabaseUtil.getText('SubmitForApproval')) {
          showDialog(
              context: context,
              builder: (context) {
                return AndroidPopUp(
                    titleValue: DatabaseUtil.getText('SubmitExpenseReport'),
                    contentValue:
                        DatabaseUtil.getText('SubmitExpenseReportMessage'),
                    onPrimaryButton: () {
                      context
                          .read<ExpenseBloc>()
                          .add(SubmitExpenseForApproval());
                    });
              });
        }
        if (value == DatabaseUtil.getText('ApproveReport')) {
          showDialog(
              context: context,
              builder: (context) {
                return AndroidPopUp(
                    titleValue: DatabaseUtil.getText('ExpenseReport'),
                    contentValue: DatabaseUtil.getText('ApproveExpenseReport'),
                    onPrimaryButton: () {
                      context.read<ExpenseBloc>().add(ApproveExpense());
                    });
              });
        }
        if (value == DatabaseUtil.getText('CloseReport')) {
          showDialog(
              context: context,
              builder: (context) {
                return AndroidPopUp(
                    titleValue: DatabaseUtil.getText('ExpenseReport'),
                    contentValue:
                        DatabaseUtil.getText('CloseExpenseReportMessage'),
                    onPrimaryButton: () {
                      context.read<ExpenseBloc>().add(CloseExpense());
                    });
              });
        }
        if (value == DatabaseUtil.getText('RejectReport')) {
          Navigator.pushNamed(context, ExpenseRejectScreen.routeName);
        }
      },
      position: PopupMenuPosition.under,
      itemBuilder: (BuildContext context) => [
        for (int i = 0; i < popUpMenuOptions.length; i++)
          _buildPopupMenuItem(context, popUpMenuOptions[i], popUpMenuOptions[i])
      ],
    );
  }
}
