import 'package:flutter/material.dart';

import '../configs/app_color.dart';
import '../configs/app_spacing.dart';
import '../utils/database_utils.dart';

class CustomEditDeletePopUpMenuOption extends StatelessWidget {
  final Function(String) onSelected;

  const CustomEditDeletePopUpMenuOption({Key? key, required this.onSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: xxTinierSpacing),
      child: Theme(
        data: Theme.of(context).copyWith(
          highlightColor: AppColor.transparent,
          splashColor: AppColor.transparent,
        ),
        child: PopupMenuButton(
          onSelected: onSelected,
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                value: DatabaseUtil.getText('Edit'),
                child: Text(DatabaseUtil.getText('Edit')),
              ),
              PopupMenuItem(
                value: DatabaseUtil.getText('Delete'),
                child: Text(DatabaseUtil.getText('Delete')),
              )
            ];
          },
        ),
      ),
    );
  }
}
