import 'package:flutter/material.dart';

import '../configs/app_color.dart';

class ExpenseTabsUtil {
  final List<Tab> tabBarViewIcons = [
    const Tab(icon: Icon(Icons.shelves, color: AppColor.grey)),
    const Tab(icon: Icon(Icons.timeline, color: AppColor.grey)),
  ];
}
