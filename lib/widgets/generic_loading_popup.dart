import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../configs/app_dimensions.dart';

class GenericLoadingPopUp {
  static void show(BuildContext context, String loadingText) {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
              child: Container(
                  height: kLoadingPopUpHeight,
                  width: kLoadingPopUpWidth,
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(kCardRadius)),
                  child: Center(
                      child: Text(
                    loadingText,
                    style: Theme.of(context).textTheme.medium,
                  ))));
        });
  }

  static void dismiss(BuildContext context) {
    Navigator.of(context).pop();
  }
}
