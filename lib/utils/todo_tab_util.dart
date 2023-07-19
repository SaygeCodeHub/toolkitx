import 'package:flutter/material.dart';
import '../configs/app_color.dart';

class TodoTabUtil {
  final List<Tab> tabBarViewIcons = [
    const Tab(
      icon: Icon(
        Icons.assignment,
        color: AppColor.grey,
      ),
      child: Text('Assigned to me', style: TextStyle(color: AppColor.black)),
    ),
    const Tab(
      icon: Icon(
        Icons.assignment,
        color: AppColor.grey,
      ),
      child: Text('Assigned by me', style: TextStyle(color: AppColor.black)),
    )
  ];
}
