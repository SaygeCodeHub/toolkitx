import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../configs/app_color.dart';
import '../configs/app_dimensions.dart';
import '../data/cache/cache_keys.dart';
import 'constants/api_constants.dart';
import 'generic_alphanumeric_generator_util.dart';

class CertificateNotesTypeUtil {

  Widget fetchSwitchCaseWidget(type, data, htmlText,link,customVideoPlayerController) {
    switch (type) {
      case '0':
        return Html(shrinkWrap: true, data: htmlText);
      case '1':
        return Container(
          height: kContainerHeight,
          width: kContainerWidth,
          color: AppColor.blueGrey,
          child: InkWell(
            splashColor: AppColor.transparent,
            highlightColor: AppColor.transparent,
            onTap: () {
              launchUrlString(
                  '${ApiConstants.viewDocBaseUrl}${data.link}&code=${RandomValueGeneratorUtil.generateRandomValue(CacheKeys.clientId)}',
                  mode: LaunchMode.inAppWebView);
            },
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
          ),
        );
      case '2':
        return Column(
          children: [
            CustomVideoPlayer(customVideoPlayerController: customVideoPlayerController),
          ],
        );
      case '3':
        return Container(
            height: kContainerHeight,
            width: kContainerWidth,
            color: AppColor.blueGrey,
            child: const Text(''));
      default:
        return Container();
    }
  }
}
