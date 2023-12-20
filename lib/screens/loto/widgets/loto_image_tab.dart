import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/loto/loto_details_model.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/generic_alphanumeric_generator_util.dart';

class LotoImageTab extends StatelessWidget {
  const LotoImageTab({
    super.key,
    required this.data,
    required this.clientId,
  });

  final LotoData data;
  final String clientId;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: data.attachments.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 200 / 350,
            crossAxisCount: 4,
            crossAxisSpacing: tinierSpacing,
            mainAxisSpacing: tinierSpacing),
        itemBuilder: (context, index) {
          return Card(
              child: InkWell(
                  splashColor: AppColor.transparent,
                  highlightColor: AppColor.transparent,
                  onTap: () {
                    launchUrlString(
                        '${ApiConstants.viewDocBaseUrl}${data.attachments[index].attachmentUrl}&code=${RandomValueGeneratorUtil.generateRandomValue(clientId)}',
                        mode: LaunchMode.inAppWebView);
                  },
                  child: CachedNetworkImage(
                      height: kCachedNetworkImageHeight,
                      imageUrl:
                          '${ApiConstants.viewDocBaseUrl}${data.attachments[index].attachmentUrl}&code=${RandomValueGeneratorUtil.generateRandomValue(clientId)}',
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
                      errorWidget: (context, url, error) => const Icon(
                          Icons.error_outline_sharp,
                          size: kIconSize))));
        });
  }
}
