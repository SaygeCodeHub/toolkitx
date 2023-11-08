import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';
import 'manage_expense_form_screen.dart';

class ExpensePopUpMenuScreen extends StatelessWidget {
  final List popUpMenuOptions;
  final Map manageExpenseMap;

  const ExpensePopUpMenuScreen(
      {Key? key,
      required this.popUpMenuOptions,
      required this.manageExpenseMap})
      : super(key: key);

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
        if (value == DatabaseUtil.getText('SubmitForApproval')) {}
        if (value == DatabaseUtil.getText('approve')) {}
        if (value == DatabaseUtil.getText('Close')) {}
      },
      position: PopupMenuPosition.under,
      itemBuilder: (BuildContext context) => [
        for (int i = 0; i < popUpMenuOptions.length; i++)
          _buildPopupMenuItem(context, popUpMenuOptions[i], popUpMenuOptions[i])
      ],
    );
  }
}
