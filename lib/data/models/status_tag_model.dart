import 'package:flutter/material.dart';

import '../../configs/app_color.dart';

class StatusTagModel {
  final String? title;
  final Color? bgColor;

  StatusTagModel({this.title, this.bgColor = AppColor.grey});
}
