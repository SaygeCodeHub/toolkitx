import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/chat/widgets/chat_video_player_eidget.dart';

class AttachementVideoWidget extends StatelessWidget {
  final String videoPath;
  final String fileName;

  const AttachementVideoWidget(
      {super.key, required this.videoPath, required this.fileName});

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: tiniestSpacing),
                    const Icon(Icons.video_collection),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text(fileName,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.tinySmall),
                          ),
                          const SizedBox(width: tiniestSpacing),
                          const Icon(Icons.timer, size: 10, color: AppColor.greyBlack),
                        ],
                      ),
                    )
                  ],
                )),
          )),
    );
  }
}
