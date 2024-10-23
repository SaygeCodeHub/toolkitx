import 'package:flutter/material.dart';
import 'package:toolkit/utils/global.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/generic_alphanumeric_generator_util.dart';
import '../../../utils/incident_view_image_util.dart';
import '../../chat/file_viewer.dart';
import 'offline/view_document_file.dart';

class WorkOrderViewDocument extends StatelessWidget {
  final String documents;
  final String clientId;
  final FileViewer fileViewer = FileViewer();

  WorkOrderViewDocument(
      {super.key, required this.documents, required this.clientId});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: ViewImageUtil.viewImageList(documents).length,
        itemBuilder: (context, index) {
          return InkWell(
              splashColor: AppColor.transparent,
              highlightColor: AppColor.transparent,
              onTap: () async {
                if (isNetworkEstablished) {
                  launchUrlString(
                      '${ApiConstants.viewDocBaseUrl}${ViewImageUtil.viewImageList(documents)[index]}&code=${RandomValueGeneratorUtil.generateRandomValue(clientId)}',
                      mode: LaunchMode.externalApplication);
                } else {
                  String filename =
                      ViewImageUtil.viewImageList(documents)[index];
                  await onFileTapped(context, filename, fileViewer);
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: xxxTinierSpacing),
                child: Text(ViewImageUtil.viewImageList(documents)[index],
                    style: const TextStyle(color: AppColor.deepBlue)),
              ));
        });
  }
}
