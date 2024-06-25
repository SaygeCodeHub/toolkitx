import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../configs/app_color.dart';
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
    return Padding(
      padding: const EdgeInsets.only(left: xxTinierSpacing),
      child: ListView.builder(
          itemCount: data.attachments.length,
          itemBuilder: (context, index) {
            return InkWell(
                splashColor: AppColor.transparent,
                highlightColor: AppColor.transparent,
                onTap: () {
                  launchUrlString(
                      '${ApiConstants.viewDocBaseUrl}${data.attachments[index].attachmentUrl}&code=${RandomValueGeneratorUtil.generateRandomValue(clientId)}',
                      mode: LaunchMode.inAppWebView);
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: xxxTinierSpacing),
                  child: Text(data.attachments[index].attachmentUrl,
                      style: const TextStyle(color: AppColor.deepBlue)),
                ));
          }),
    );
  }
}
