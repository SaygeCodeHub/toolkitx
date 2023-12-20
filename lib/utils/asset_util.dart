import 'package:flutter/material.dart';

import '../configs/app_color.dart';

class AssetUtil {
  final List leadingAvatarList = [
    'assets/icons/human_avatar_four.png',
    'assets/icons/human_avatar_one.png',
    'assets/icons/human_avatar_two.png',
    'assets/icons/human_avatar_three.png'
  ];
  final List<Tab> tabBarViewIcons = [
    const Tab(
        icon: Icon(
      Icons.file_present,
      color: AppColor.grey,
    )),
    const Tab(
        icon: Icon(
      Icons.warning_amber_rounded,
      color: AppColor.grey,
    )),
    const Tab(
        icon: Icon(
      Icons.computer,
      color: AppColor.grey,
    )),
    const Tab(
        icon: Icon(
      Icons.code,
      color: AppColor.grey,
    )),
    const Tab(
        icon: Icon(
      Icons.attach_money,
      color: AppColor.grey,
    )),
    const Tab(
        icon: Icon(
      Icons.description,
      color: AppColor.grey,
    ))
  ];
}
