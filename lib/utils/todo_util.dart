import 'package:flutter/material.dart';

import '../configs/app_color.dart';

class ToDoUtil {
  final List<Tab> tabBarViewIcons = [
    const Tab(
        icon: Icon(
      Icons.info,
      color: AppColor.grey,
    )),
    const Tab(
        icon: Icon(
      Icons.library_books_outlined,
      color: AppColor.grey,
    )),
  ];
}
