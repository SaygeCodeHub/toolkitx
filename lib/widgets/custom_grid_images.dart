import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../configs/app_color.dart';
import '../configs/app_spacing.dart';
import '../utils/constants/api_constants.dart';
import '../utils/generic_alphanumeric_generator_util.dart';
import '../utils/incident_view_image_util.dart';

class CustomGridImages extends StatelessWidget {
  final String files;
  final String clientId;

  const CustomGridImages(
      {super.key, required this.files, required this.clientId});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: ViewImageUtil.viewImageList(files).length,
        itemBuilder: (context, gridIndex) {
          return InkWell(
              splashColor: AppColor.transparent,
              highlightColor: AppColor.transparent,
              onTap: () {
                launchUrlString(
                    '${ApiConstants.viewDocBaseUrl}${ViewImageUtil.viewImageList(files)[gridIndex]}&code=${RandomValueGeneratorUtil.generateRandomValue(clientId)}',
                    mode: LaunchMode.externalApplication);
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: xxxTinierSpacing),
                child: Text(ViewImageUtil.viewImageList(files)[gridIndex],
                    style: const TextStyle(color: AppColor.deepBlue)),
              ));
        });
  }
}
