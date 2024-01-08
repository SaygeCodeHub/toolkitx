import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/equipmentTraceability/fetch_search_equipment_details_model.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/generic_alphanumeric_generator_util.dart';

class EquipmentDetailsTabTwo extends StatelessWidget {
  final int tabIndex;
  final Map detailsMap;

  const EquipmentDetailsTabTwo(
      {super.key,
      required this.tabIndex,
      required this.searchEquipmentDetailsData,
      required this.detailsMap});

  final SearchEquipmentDetailsData searchEquipmentDetailsData;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: searchEquipmentDetailsData.imagelist.length,
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
                        '${ApiConstants.viewDocBaseUrl}${searchEquipmentDetailsData.imagelist[index].attachmentUrl}&code=${RandomValueGeneratorUtil.generateRandomValue(detailsMap["clientId"])}',
                        mode: LaunchMode.inAppWebView);
                  },
                  child: CachedNetworkImage(
                      height: kCachedNetworkImageHeight,
                      imageUrl:
                          '${ApiConstants.viewDocBaseUrl}${searchEquipmentDetailsData.imagelist[index].attachmentUrl}&code=${RandomValueGeneratorUtil.generateRandomValue(detailsMap["clientId"])}',
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
