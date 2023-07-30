import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/incident/incident_details_model.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/generic_alphanumeric_generator_util.dart';
import '../../../utils/incident_view_image_util.dart';

class IncidentCommentViewNetworkImage extends StatelessWidget {
  final Commentslist commentsList;
  final String clientId;

  const IncidentCommentViewNetworkImage(
      {Key? key, required this.commentsList, required this.clientId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: tinierSpacing,
            mainAxisSpacing: tinierSpacing),
        itemCount:
            IncidentViewImageUtil.viewImageList(commentsList.files.toString())
                .length,
        itemBuilder: (context, index) {
          return InkWell(
              splashColor: AppColor.transparent,
              highlightColor: AppColor.transparent,
              onTap: () {
                launchUrlString(
                    '${ApiConstants.viewDocBaseUrl}${IncidentViewImageUtil.viewImageList(commentsList.files.toString())[index]}&code=${RandomValueGeneratorUtil.generateRandomValue(clientId)}',
                    mode: LaunchMode.inAppWebView);
              },
              child: CachedNetworkImage(
                  height: kCachedNetworkImageHeight,
                  imageUrl:
                      '${ApiConstants.viewDocBaseUrl}${IncidentViewImageUtil.viewImageList(commentsList.files.toString())[index]}&code=${RandomValueGeneratorUtil.generateRandomValue(clientId)}',
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
