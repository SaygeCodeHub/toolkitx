import 'package:flutter/material.dart';

import '../configs/app_color.dart';

class LocationTabsUtil {
  final List<Tab> tabBarViewIcons = [
    const Tab(icon: Icon(Icons.shelves, color: AppColor.grey)),
    const Tab(icon: Icon(Icons.edit_document, color: AppColor.grey)),
    const Tab(icon: Icon(Icons.timeline, color: AppColor.grey)),
    const Tab(icon: Icon(Icons.settings, color: AppColor.grey)),
    const Tab(icon: Icon(Icons.lock_clock, color: AppColor.grey)),
    const Tab(icon: Icon(Icons.handyman, color: AppColor.grey)),
    const Tab(icon: Icon(Icons.note, color: AppColor.grey)),
    const Tab(icon: Icon(Icons.miscellaneous_services, color: AppColor.grey))
  ];
}
