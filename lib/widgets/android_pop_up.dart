import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';

class AndroidPopUp extends StatelessWidget {
  final String titleValue;
  final String contentValue;
  final void Function()? onPressed;
  final EdgeInsetsGeometry? contentPadding;

  const AndroidPopUp(
      {Key? key,
      required this.titleValue,
      required this.contentValue,
      this.onPressed,
      this.contentPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        titlePadding:
            const EdgeInsets.only(left: xxTinySpacing, top: xxTinySpacing),
        buttonPadding: const EdgeInsets.all(xxTiniestSpacing),
        contentPadding: (contentValue == '')
            ? contentPadding
            : const EdgeInsets.all(xxTinySpacing),
        actionsPadding: const EdgeInsets.only(right: xxTinySpacing),
        title: Text(titleValue),
        content: Text(contentValue),
        titleTextStyle: Theme.of(context)
            .textTheme
            .medium
            .copyWith(fontWeight: FontWeight.w500),
        actions: [
          TextButton(
              child: Text(DatabaseUtil.getText('No')),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          TextButton(
              onPressed: onPressed, child: Text(DatabaseUtil.getText('Yes')))
        ]);
  }
}
