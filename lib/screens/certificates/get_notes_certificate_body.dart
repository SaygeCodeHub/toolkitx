import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/data/models/certificates/get_notes_certificate_model.dart';
import 'package:toolkit/utils/certificate_notes_type_util.dart';
import 'package:toolkit/utils/generic_alphanumeric_generator_util.dart';
import 'package:video_player/video_player.dart';

import '../../utils/constants/api_constants.dart';

class GetNotesCertificateBody extends StatefulWidget {
  const GetNotesCertificateBody(
      {super.key, required this.data, required this.pageNo});

  final GetNotesData data;
  final int pageNo;

  @override
  State<GetNotesCertificateBody> createState() =>
      _GetNotesCertificateBodyState();
}

class _GetNotesCertificateBodyState extends State<GetNotesCertificateBody> {
  final
  Uri videoUrl = Uri.parse("http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4");

  @override
  void initState() {
    super.initState();
    initializeVideoPlayer();
    // _chewieController = ChewieController(
    //     videoPlayerController: VideoPlayerController.networkUrl(Uri.parse("http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")),
    //     aspectRatio: 3 / 2,
    //     autoInitialize: true);
    // _videoPlayerController = VideoPlayerController.networkUrl(Uri(path:"http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"));
    // _videoPlayerController?.play();
    // _videoPlayerController?.initialize();
  }

  void initializeVideoPlayer() {
    // VideoPlayerController videoPlayerController;
    // videoPlayerController = VideoPlayerController.networkUrl(videoUrl)
    //   ..initialize().then((value) {
    //     // setState(() {});
    //   });
    // customVideoPlayerController = CustomVideoPlayerController(context: context, videoPlayerController: videoPlayerController);
  }

  @override
  void dispose() {
    // customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("${ApiConstants.baseDocUrl}${widget.data.link}&code=${RandomValueGeneratorUtil.generateRandomValue(CacheKeys.clientId)}");
    var link =
        '${ApiConstants.viewDocBaseUrl}${widget.data.link}&code=${RandomValueGeneratorUtil.generateRandomValue(CacheKeys.clientId)}';
    log("link=======>${ApiConstants.baseDocUrl}${widget.data.link}&code=${RandomValueGeneratorUtil.generateRandomValue(CacheKeys.clientId)}");
    var unescape = HtmlUnescape();
    var htmlText = unescape.convert(widget.data.description);
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CertificateNotesTypeUtil().fetchSwitchCaseWidget(widget.data.type,
              widget.data, htmlText, link)
          // CustomVideoPlayer(customVideoPlayerController: customVideoPlayerController),
        ],
      ),
    );
  }
}
