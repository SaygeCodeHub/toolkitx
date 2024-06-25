import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../configs/app_color.dart';

class IosPopUp extends StatelessWidget {
  final String titleValue;
  final String contentValue;
  final void Function()? onPressed;

  const IosPopUp(
      {Key? key,
      required this.titleValue,
      required this.contentValue,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
        title: Text(titleValue),
        content: Text(contentValue),
        actions: [
          CupertinoDialogAction(
            textStyle: Theme.of(context).textTheme.xSmall.copyWith(
                color: AppColor.deepBlue, fontWeight: FontWeight.w500),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(DatabaseUtil.getText('No')),
          ),
          CupertinoDialogAction(
              textStyle: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.deepBlue, fontWeight: FontWeight.w500),
              onPressed: onPressed,
              child: Text(DatabaseUtil.getText('Yes')))
        ]);
  }
}
