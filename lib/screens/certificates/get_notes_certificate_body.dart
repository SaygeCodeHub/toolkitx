import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/data/models/certificates/get_notes_certificate_model.dart';
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
  VideoPlayerController? _videoPlayerController;
  late ChewieController _chewieController;
  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
        videoPlayerController: VideoPlayerController.networkUrl(Uri(
            path:
                "${ApiConstants.viewDocBaseUrl}${widget.data.link}${RandomValueGeneratorUtil.generateRandomValue(CacheKeys.clientId)}")),
        aspectRatio: 3 / 2,
        autoInitialize: true);
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var unescape = HtmlUnescape();
    var text = unescape.convert(widget.data.description);
    bool visible = true;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
            visible: widget.pageNo == 3 ? visible : !visible,
            child: SizedBox(
                height: 500,
                width: 380,
                child: Html(shrinkWrap: true, data: text))),
        Visibility(
            visible: widget.pageNo == 2 ? visible : !visible,
            child: Container(
                height: 300,
                width: 380,
                color: AppColor.blueGrey,
                child: Image.network(
                    "${ApiConstants.viewDocBaseUrl}${widget.data.link}${RandomValueGeneratorUtil.generateRandomValue(CacheKeys.clientId)}"))),
        Visibility(
            visible: widget.pageNo == 1 ? visible : !visible,
            child: Container(
                height: 300,
                width: 380,
                color: AppColor.blueGrey,
                child: const Text(''))),
        Visibility(
            visible: widget.pageNo == 4 ? visible : !visible,
            child: Container(
                height: 250,
                width: 380,
                color: AppColor.blueGrey,
                child: Center(child: Chewie(controller: _chewieController))))
      ],
    );
  }
}
