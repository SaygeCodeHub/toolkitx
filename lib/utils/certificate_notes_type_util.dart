import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pod_player/pod_player.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../configs/app_color.dart';
import '../configs/app_dimensions.dart';
import 'constants/api_constants.dart';

class CertificateNotesTypeUtil {
  Widget fetchSwitchCaseWidget(
      type, data, htmlText, pictureLink, podPlayerController, clientId) {
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
              launchUrlString('${ApiConstants.baseDocUrl}$pictureLink',
                  mode: LaunchMode.inAppWebView);
            },
            child: CachedNetworkImage(
                height: kContainerHeight,
                imageUrl: '${ApiConstants.baseDocUrl}$pictureLink',
                placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: AppColor.paleGrey,
                    highlightColor: AppColor.white,
                    child: Container(
                        height: kNetworkImageContainerTogether,
                        width: kNetworkImageContainerTogether,
                        decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(kCardRadius)))),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error_outline_sharp, size: kIconSize)),
          ),
        );
      case '2':
        return PodVideoPlayer(controller: podPlayerController);
      case '3':
        // return PowerFileViewWidget(
        //   downloadUrl: pictureLink,
        //   filePath: pictureLink,
        // );
      default:
        return Container();
    }
  }
}
