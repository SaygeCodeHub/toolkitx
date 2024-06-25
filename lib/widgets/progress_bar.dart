import 'package:flutter/material.dart';

import '../configs/app_color.dart';
import '../configs/app_dimensions.dart';

class ProgressBar {
  static void show(BuildContext context) {
    showDialog(
        context: context,
        barrierColor: AppColor.transparent,
        barrierDismissible: false,
        builder: (context) {
          return const Center(
              child: SizedBox(
                  height: kProgressBarSize,
                  width: kProgressBarSize,
                  child: CircularProgressIndicator()));
        });
  }

  static Widget showLoadingWidget(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColor.blueGrey)));
  }

  static void dismiss(BuildContext context) {
    Navigator.of(context).pop();
  }
}
