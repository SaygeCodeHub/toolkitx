import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/loto/loto_details_model.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/generic_alphanumeric_generator_util.dart';

class LotoDetailsLocationDocuments extends StatelessWidget {
  const LotoDetailsLocationDocuments({
    super.key,
    required this.data,
    required this.clientId,
  });

  final LotoData data;
  final String clientId;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: data.locdocs.isNotEmpty,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kLocationDocuments,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.locdocs.length,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 200 / 300,
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
                              '${ApiConstants.viewDocBaseUrl}${data.locdocs[index].filename}&code=${RandomValueGeneratorUtil.generateRandomValue(clientId)}',
                              mode: LaunchMode.inAppWebView);
                        },
                        child: CachedNetworkImage(
                            height: kCachedNetworkImageHeight,
                            imageUrl:
                            '${ApiConstants.viewDocBaseUrl}${data.locdocs[index].filename}&code=${RandomValueGeneratorUtil.generateRandomValue(clientId)}',
                            placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: AppColor.paleGrey,
                                highlightColor: AppColor.white,
                                child: Container(
                                    height: kNetworkImageContainerTogether,
                                    width: kNetworkImageContainerTogether,
                                    decoration: BoxDecoration(
                                        color: AppColor.white,
                                        borderRadius: BorderRadius.circular(
                                            kCardRadius)))),
                            errorWidget: (context, url, error) => const Icon(
                                Icons.error_outline_sharp,
                                size: kIconSize))));
              }),
        ],
      ),
    );
  }
}