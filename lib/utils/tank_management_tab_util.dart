import 'package:flutter/material.dart';

import '../configs/app_color.dart';

class TankManagementTabsUtil {
  final List<Tab> tabBarViewIcons = [
    const Tab(icon: Icon(Icons.dns_rounded, color: AppColor.grey)),
    const Tab(icon: Icon(Icons.checklist, color: AppColor.grey)),
    const Tab(icon: Icon(Icons.list, color: AppColor.grey))
  ];
}
