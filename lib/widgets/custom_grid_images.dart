import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../configs/app_color.dart';
import '../configs/app_dimensions.dart';
import '../configs/app_spacing.dart';
import '../utils/constants/api_constants.dart';
import '../utils/generic_alphanumeric_generator_util.dart';
import '../utils/incident_view_image_util.dart';

class CustomGridImages extends StatelessWidget {
  final String files;
  final String clientId;
  final String baseUrl;

  const CustomGridImages(
      {super.key,
      required this.files,
      required this.clientId,
      required this.baseUrl});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 200 / 350,
            crossAxisCount: 5,
            crossAxisSpacing: tinierSpacing,
            mainAxisSpacing: tinierSpacing),
        itemCount: ViewImageUtil.viewImageList(files).length,
        itemBuilder: (context, gridIndex) {
          return InkWell(
              splashColor: AppColor.transparent,
              highlightColor: AppColor.transparent,
              onTap: () {
                launchUrlString(
                    '${ApiConstants.viewDocBaseUrl}${ViewImageUtil.viewImageList(files)[gridIndex]}&code=${RandomValueGeneratorUtil.generateRandomValue(clientId)}',
                    mode: LaunchMode.inAppWebView);
              },
              child: CachedNetworkImage(
                  height: kCachedNetworkImageHeight,
                  imageUrl:
                      '$baseUrl${ViewImageUtil.viewImageList(files)[gridIndex]}&code=${RandomValueGeneratorUtil.generateRandomValue(clientId)}',
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
                      const Icon(Icons.error_outline_sharp, size: kIconSize)));
        });
  }
}
