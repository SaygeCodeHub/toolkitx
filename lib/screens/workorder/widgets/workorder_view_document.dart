import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/workorder/fetch_workorder_details_model.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/generic_alphanumeric_generator_util.dart';
import '../../../utils/incident_view_image_util.dart';

class WorkOrderViewDocument extends StatelessWidget {
  final Document documents;
  final String clientId;

  const WorkOrderViewDocument(
      {Key? key, required this.documents, required this.clientId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: ViewImageUtil.viewImageList(documents.files).length,
        itemBuilder: (context, index) {
          return InkWell(
              splashColor: AppColor.transparent,
              highlightColor: AppColor.transparent,
              onTap: () {
                launchUrlString(
                    '${ApiConstants.viewDocBaseUrl}${ViewImageUtil.viewImageList(documents.files)[index]}&code=${RandomValueGeneratorUtil.generateRandomValue(clientId)}',
                    mode: LaunchMode.externalApplication);
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: xxxTinierSpacing),
                child: Text(ViewImageUtil.viewImageList(documents.files)[index],
                    style: const TextStyle(color: AppColor.deepBlue)),
              ));
        });
  }
}
