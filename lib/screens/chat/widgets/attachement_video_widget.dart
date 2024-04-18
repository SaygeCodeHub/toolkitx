import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';

class AttachementVideoWidget extends StatelessWidget {
  final String videoPath;

  const AttachementVideoWidget({super.key, required this.videoPath});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: Container(
            color: AppColor.lightGrey,
            height: 100,
            width: 100,
            child: const Icon(Icons.video_collection)));
  }
}
