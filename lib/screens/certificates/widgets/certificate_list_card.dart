import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/certificates/certificate_list_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/text_button.dart';
import '../feedback_certificate_screen.dart';
import '../get_certificate_details_screen.dart';
import '../get_course_certificate_screen.dart';
import '../upload_certificate_screen.dart';

class CertificateListCard extends StatelessWidget {
  const CertificateListCard({super.key, required this.data});

  final CertificateListDatum data;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        elevation: 2,
        child: Padding(
            padding: const EdgeInsets.only(top: tinierSpacing),
            child: Column(children: [
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(data.name,
                      style: Theme.of(context).textTheme.small.copyWith(
                          fontWeight: FontWeight.w500, color: AppColor.black)),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(StringConstants.kNotAvailable),
                    const SizedBox(height: xxxTinierSpacing),
                    Visibility(
                      visible: data.status == 1,
                      child: Card(
                          color: AppColor.lightGrey,
                          child: Padding(
                            padding: const EdgeInsets.all(tiniestSpacing),
                            child: Text(StringConstants.kApprovalPending,
                                style: Theme.of(context)
                                    .textTheme
                                    .xxSmall
                                    .copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.black)),
                          )),
                    )
                  ],
                ),
                trailing: Image.asset('assets/icons/certificate.png',
                    height: kImageHeight, width: kImageWidth),
              ),
              const Divider(color: AppColor.lightestGrey),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
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
                  onPressed: data.expired == "1" ? () {} : null,
                  textValue: StringConstants.kDownload,
                  textColor:
                      data.expired == "1" ? AppColor.deepBlue : AppColor.grey,
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
              ])
            ])));
  }
}
