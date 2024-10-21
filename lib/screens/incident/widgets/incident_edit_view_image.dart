import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../utils/generic_alphanumeric_generator_util.dart';
import '../../../utils/incident_view_image_util.dart';
import '../category_screen.dart';

class IncidentEditViewImage extends StatelessWidget {
  final Map addAndEditIncidentMap;
  final String clientId;

  const IncidentEditViewImage(
      {super.key, required this.addAndEditIncidentMap, required this.clientId});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: CategoryScreen.isFromEdit == true &&
          addAndEditIncidentMap['files'] != '',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(DatabaseUtil.getText('viewimage'),
              style: Theme.of(context)
                  .textTheme
                  .xSmall
                  .copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: xxxTinierSpacing),
          GridView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 200 / 350,
                  crossAxisCount: 4,
                  crossAxisSpacing: tinierSpacing,
                  mainAxisSpacing: tinierSpacing),
              itemCount: ViewImageUtil.viewImageList(
                      addAndEditIncidentMap['files'] ?? '')
                  .length,
              itemBuilder: (context, index) {
                return InkWell(
                    splashColor: AppColor.transparent,
                    highlightColor: AppColor.transparent,
                    onTap: () {
                      launchUrlString(
                          '${ApiConstants.viewDocBaseUrl}${ViewImageUtil.viewImageList(addAndEditIncidentMap['files'] ?? '')[index]}&code=${RandomValueGeneratorUtil.generateRandomValue(clientId)}',
                          mode: LaunchMode.inAppWebView);
                    },
                    child: CachedNetworkImage(
                        height: kCachedNetworkImageHeight,
                        imageUrl:
                            '${ApiConstants.viewDocBaseUrl}${ViewImageUtil.viewImageList(addAndEditIncidentMap['files'] ?? '')[index]}&code=${RandomValueGeneratorUtil.generateRandomValue(clientId)}',
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
                            size: kIconSize)));
              }),
        ],
      ),
    );
  }
}
