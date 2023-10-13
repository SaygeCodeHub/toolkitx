import 'package:flutter/material.dart';

import '../configs/app_color.dart';
import '../data/models/documents/documents_details_models.dart';

class DocumentsUtil {
  final List leadingAvatarList = [
    'assets/icons/human_avatar_four.png',
    'assets/icons/human_avatar_one.png',
    'assets/icons/human_avatar_two.png',
    'assets/icons/human_avatar_three.png'
  ];
  final List<Tab> tabBarViewIcons = [
    const Tab(icon: Icon(Icons.shelves, color: AppColor.grey)),
    const Tab(icon: Icon(Icons.file_copy_outlined, color: AppColor.grey)),
    const Tab(icon: Icon(Icons.info, color: AppColor.grey)),
    const Tab(icon: Icon(Icons.timeline, color: AppColor.grey)),
    const Tab(icon: Icon(Icons.comment, color: AppColor.grey)),
    const Tab(icon: Icon(Icons.link, color: AppColor.grey))
  ];

  static List<String> fileMenuOptions(FileList fileListData) {
    List<String> fileMenuOptionsList = ['View'];
    if (fileListData.canuploadnewversion == '1') {
      fileMenuOptionsList.add('Upload New Version');
    }
    if (fileListData.candelete == '1') {
      fileMenuOptionsList.add('Delete');
    }
    if (fileListData.canaddcomments == '1') {
      fileMenuOptionsList.add('Add Comment');
    }
    return fileMenuOptionsList;
  }
}