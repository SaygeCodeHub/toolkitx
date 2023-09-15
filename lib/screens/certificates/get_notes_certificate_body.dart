import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/data/models/certificates/get_notes_certificate_model.dart';
import 'package:toolkit/utils/generic_alphanumeric_generator_util.dart';
import 'package:video_player/video_player.dart';

import '../../configs/app_dimensions.dart';
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
                "${ApiConstants.viewDocBaseUrl}${widget.data.link}&code=${RandomValueGeneratorUtil.generateRandomValue(CacheKeys.clientId)}")),
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
    log("message====>${ApiConstants.viewDocBaseUrl}${widget.data.link}&code=${RandomValueGeneratorUtil.generateRandomValue(CacheKeys.clientId)}");
    var link =
        '${ApiConstants.viewDocBaseUrl}${widget.data.link}&code=${RandomValueGeneratorUtil.generateRandomValue(CacheKeys.clientId)}';
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
                height: kContainerHeight,
                width: kContainerWidth,
                child: Html(shrinkWrap: true, data: text))),
        Visibility(
            visible: widget.pageNo == 2 ? visible : !visible,
            child: Container(
              height: kContainerHeight,
              width: kContainerWidth,
              color: AppColor.blueGrey,
              child: CachedNetworkImage(
                  height: kContainerHeight,
                  imageUrl: link,
                  placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: AppColor.paleGrey,
                      highlightColor: AppColor.white,
                      child: Container(
                          height: kNetworkImageContainerTogether,
                          width: kNetworkImageContainerTogether,
                          decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius:
                                  BorderRadius.circular(kCardRadius)))),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error_outline_sharp, size: kIconSize)),
            )),
        Visibility(
            visible: widget.pageNo == 1 ? visible : !visible,
            child: Container(
                height: kContainerHeight,
                width: kContainerWidth,
                color: AppColor.blueGrey,
                child: const Text(''))),
        Visibility(
            visible: widget.pageNo == 4 ? visible : !visible,
            child: Container(
                height: kLoadingPopUpWidth,
                width: kContainerWidth,
                color: AppColor.blueGrey,
                child: Center(child: Chewie(controller: _chewieController))))
      ],
    );
  }
}
