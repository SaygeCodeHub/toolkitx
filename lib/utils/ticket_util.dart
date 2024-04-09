import 'package:flutter/material.dart';

import '../configs/app_color.dart';

class TicketsUtil {
  final List<Tab> tabBarViewIcons = [
    const Tab(icon: Icon(Icons.shelves, color: AppColor.grey)),
    const Tab(icon: Icon(Icons.comment, color: AppColor.grey)),
    const Tab(icon: Icon(Icons.file_copy_outlined, color: AppColor.grey)),
    const Tab(icon: Icon(Icons.timeline, color: AppColor.grey)),
  ];
}
