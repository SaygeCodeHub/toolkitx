import 'package:flutter/material.dart';

import '../configs/app_color.dart';

class WorkOrderTabsUtil {
  final List<Tab> tabBarViewIcons = [
    const Tab(icon: Icon(Icons.shelves, color: AppColor.grey)),
    const Tab(icon: Icon(Icons.people, color: AppColor.grey)),
    const Tab(icon: Icon(Icons.settings_suggest, color: AppColor.grey)),
    const Tab(icon: Icon(Icons.timeline, color: AppColor.grey)),
    const Tab(icon: Icon(Icons.comment, color: AppColor.grey)),
  ];
}
