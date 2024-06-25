import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
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
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: ViewImageUtil.viewImageList(fileName).length,
        itemBuilder: (context, index) {
          return InkWell(
              splashColor: AppColor.transparent,
              highlightColor: AppColor.transparent,
              onTap: () {
                launchUrlString(
                    '${ApiConstants.viewDocBaseUrl}${ViewImageUtil.viewImageList(fileName)[index]}&code=${RandomValueGeneratorUtil.generateRandomValue(clientId)}',
                    mode: LaunchMode.externalApplication);
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: xxxTinierSpacing),
                child: Text(ViewImageUtil.viewImageList(fileName)[index],
                    style: const TextStyle(color: AppColor.deepBlue)),
              ));
        });
  }
}
