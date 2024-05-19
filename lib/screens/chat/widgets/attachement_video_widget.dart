import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/screens/chat/widgets/chat_video_player_eidget.dart';

class AttachementVideoWidget extends StatelessWidget {
  final String videoPath;

  const AttachementVideoWidget({super.key, required this.videoPath});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Click to view video',
      child: Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ChatVideoPlayerWidget(videoPath: videoPath)));
            },
            child: Container(
                color: AppColor.lightGrey,
                height: 100,
                width: 100,
                child: const Icon(Icons.video_collection)),
          )),
    );
  }
}
