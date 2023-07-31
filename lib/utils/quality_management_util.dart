import 'package:flutter/material.dart';

import '../configs/app_color.dart';

class QualityManagementUtil {
  final List<Tab> tabBarViewIcons = [
    const Tab(
        icon: Icon(
      Icons.shelves,
      color: AppColor.grey,
    )),
    const Tab(
        icon: Icon(
      Icons.info,
      color: AppColor.grey,
    )),
    const Tab(
        icon: Icon(
      Icons.comment,
      color: AppColor.grey,
    )),
    const Tab(
        icon: Icon(
      Icons.timeline,
      color: AppColor.grey,
    ))
  ];
}
