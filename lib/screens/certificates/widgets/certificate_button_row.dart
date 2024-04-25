import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../configs/app_color.dart';
import '../../../data/models/certificates/certificate_list_model.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/text_button.dart';
import '../feedback_certificate_screen.dart';
import '../get_certificate_details_screen.dart';
import '../get_course_certificate_screen.dart';
import '../upload_certificate_screen.dart';

class CertificateButtonRow extends StatelessWidget {
  const CertificateButtonRow({
    super.key,
    required this.data,
  });

  final CertificateListDatum data;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Expanded(
          child: CustomTextButton(
            onPressed: () {
              Map certificateMap = {"title": data.name, "id": data.id};
              if (data.status == 1) {
                Navigator.pushNamed(
                    context, GetCertificateDetailsScreen.routeName,
                    arguments: certificateMap);
              } else {
                Navigator.pushNamed(
                    context, UploadCertificateScreen.routeName,
                    arguments: certificateMap);
              }
            },
            textValue: StringConstants.kUpload,
            textColor:
            data.status != "1" ? AppColor.deepBlue : AppColor.grey,
          )),
      Expanded(
          child: CustomTextButton(
            onPressed: data.actualCertificate.isNotEmpty
                ? () {
              launchUrlString(
                  '${ApiConstants.baseUrl}${data.actualCertificate}',
                  mode: LaunchMode.inAppBrowserView);
            }
                : null,
            textValue: StringConstants.kDownload,
            textColor: data.actualCertificate.isNotEmpty
                ? AppColor.deepBlue
                : AppColor.grey,
          )),
      Expanded(
          child: CustomTextButton(
            onPressed: data.accesscertificate == "1"
                ? () {
              String certificateId = data.id;
              Navigator.pushNamed(
                  context, GetCourseCertificateScreen.routeName,
                  arguments: certificateId);
            }
                : null,
            textValue: StringConstants.kStartCourse,
            textColor: data.accesscertificate == "1"
                ? AppColor.deepBlue
                : AppColor.grey,
          )),
      Expanded(
          child: CustomTextButton(
            onPressed: data.accessfeedback == "1"
                ? () {
              Map certificateMap = {
                "title": data.name,
                "id": data.id
              };
              Navigator.pushNamed(
                  context, FeedbackCertificateScreen.routeName,
                  arguments: certificateMap);
            }
                : null,
            textValue: StringConstants.kFeedback,
            textColor: data.accessfeedback == "1"
                ? AppColor.deepBlue
                : AppColor.grey,
          ))
    ]);
  }
}