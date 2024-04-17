import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/utils/constants/api_constants.dart';
import 'package:toolkit/utils/generic_alphanumeric_generator_util.dart';
import 'package:toolkit/utils/incident_view_image_util.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DocumentViewImageWidget extends StatelessWidget {
  final String fileName;
  final String clientId;

  const DocumentViewImageWidget(
      {super.key, required this.fileName, required this.clientId});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: tinierSpacing,
            mainAxisSpacing: tinierSpacing),
        itemCount: ViewImageUtil.viewImageList(fileName).length,
        itemBuilder: (context, index) {
          return InkWell(
              splashColor: AppColor.transparent,
              highlightColor: AppColor.transparent,
              onTap: () {
                launchUrlString(
                    '${ApiConstants.viewDocBaseUrl}$fileName&code=${RandomValueGeneratorUtil.generateRandomValue(clientId)}',
                    mode: LaunchMode.externalApplication);
              },
              child: CachedNetworkImage(
                  height: kCachedNetworkImageHeight,
                  imageUrl:
                      '${ApiConstants.viewDocBaseUrl}${ViewImageUtil.viewImageList(fileName)[index]}&code=${RandomValueGeneratorUtil.generateRandomValue(clientId)}',
                  placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade100,
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
