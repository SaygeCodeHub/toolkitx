import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/loto/loto_details_model.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/generic_alphanumeric_generator_util.dart';
import '../../../utils/incident_view_image_util.dart';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kLocationDocuments,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.locdocs.length,
              shrinkWrap: true,

              itemBuilder: (context, index) {
                String files = data.locdocs[index].filename;
                return InkWell(
                    splashColor: AppColor.transparent,
                    highlightColor: AppColor.transparent,
                    onTap: () {
                      launchUrlString(
                          '${ApiConstants.viewDocBaseUrl}${ViewImageUtil.viewImageList(files)[index]}&code=${RandomValueGeneratorUtil.generateRandomValue(clientId)}',
                          mode: LaunchMode.inAppWebView);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: xxxTinierSpacing),
                      child: Text(
                          ViewImageUtil.viewImageList(files)[index],
                          style: const TextStyle(
                              color: AppColor.deepBlue)),
                    ));
              }),
        ],
      ),
    );
  }
}
