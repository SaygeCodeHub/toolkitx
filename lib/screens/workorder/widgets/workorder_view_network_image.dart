import 'package:flutter/material.dart';
import 'package:toolkit/data/models/workorder/fetch_workorder_details_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/generic_alphanumeric_generator_util.dart';
import '../../../utils/incident_view_image_util.dart';

class WorkOrderViewNetworkImage extends StatelessWidget {
  final Comment comment;
  final String clientId;

  const WorkOrderViewNetworkImage(
      {super.key, required this.clientId, required this.comment});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: ViewImageUtil.viewImageList(comment.files.toString()).length,
        itemBuilder: (context, index) {
          return InkWell(
              splashColor: AppColor.transparent,
              highlightColor: AppColor.transparent,
              onTap: () {
                launchUrlString(
                    '${ApiConstants.viewDocBaseUrl}${ViewImageUtil.viewImageList(comment.files.toString())[index]}&code=${RandomValueGeneratorUtil.generateRandomValue(clientId)}',
                    mode: LaunchMode.inAppWebView);
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: xxxTinierSpacing),
                child: Text(
                    ViewImageUtil.viewImageList(
                        comment.files.toString())[index],
                    style: const TextStyle(color: AppColor.deepBlue)),
              ));
        });
  }
}
