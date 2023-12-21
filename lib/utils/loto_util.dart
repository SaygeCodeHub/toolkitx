import 'package:flutter/material.dart';

import '../configs/app_color.dart';

class LotoUtil {
  final List leadingAvatarList = [
    'assets/icons/human_avatar_four.png',
    'assets/icons/human_avatar_one.png',
    'assets/icons/human_avatar_two.png',
    'assets/icons/human_avatar_three.png'
  ];
  final List<Tab> tabBarViewIcons = [
    const Tab(
        icon: Icon(
      Icons.shelves,
      color: AppColor.grey,
    )),
    const Tab(
        icon: Icon(
      Icons.file_copy_outlined,
      color: AppColor.grey,
    )),
    const Tab(
        icon: Icon(
      Icons.checklist,
      color: AppColor.grey,
    )),
    const Tab(
        icon: Icon(
      Icons.list,
      color: AppColor.grey,
    )),
    const Tab(
        icon: Icon(
      Icons.dns_rounded,
      color: AppColor.grey,
    )),
    const Tab(
        icon: Icon(
      Icons.people_alt_outlined,
      color: AppColor.grey,
    ))
  ];
}
