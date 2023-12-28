import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../blocs/certificates/cerficatesList/certificate_list_bloc.dart';
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
                title: Text(data.name,
                    style: Theme.of(context).textTheme.small.copyWith(
                        fontWeight: FontWeight.w500, color: AppColor.black)),
                subtitle: const Text(StringConstants.kNotAvailable),
                trailing: Image.asset('assets/icons/certificate.png',
                    height: kImageHeight, width: kImageWidth),
              ),
              const Divider(
                color: AppColor.lightestGrey
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Expanded(
                    child: CustomTextButton(
                        onPressed: () {
                          Map certificateMap = {
                            "title": data.name,
                            "id": data.id
                          };

                          if (context
                                  .read<CertificateListBloc>()
                                  .fetchCertificateDetailsModel
                                  .data
                                  ?.status ==
                              "1") {
                            Navigator.pushNamed(
                                context, GetCertificateDetailsScreen.routeName,
                                arguments: certificateMap);
                          } else {
                            Navigator.pushNamed(
                                context, UploadCertificateScreen.routeName,
                                arguments: certificateMap);
                          }
                        },
                        textValue: StringConstants.kUpload)),
                Expanded(
                    child: CustomTextButton(
                        onPressed:data
                            .expired ==
                            "1" ? () {} : null,
                        textValue: StringConstants.kDownload)),
                Expanded(
                    child: CustomTextButton(
                        onPressed:
                            data
                            .accesscertificate !=
                            "1" ? () {
                          String certificateId = data.id;
                          Navigator.pushNamed(
                              context, GetCourseCertificateScreen.routeName,
                              arguments: certificateId);
                        } : null,
                        textValue: StringConstants.kStartCourse)),
                Expanded(
                    child: CustomTextButton(
                        onPressed: data.accessfeedback ==
                            "1" ? () {
                          Map certificateMap = {
                            "title": data.name,
                            "id": data.id
                          };
                          Navigator.pushNamed(
                              context, FeedbackCertificateScreen.routeName,
                              arguments: certificateMap);
                        } : null,
                        textValue: StringConstants.kFeedback))
              ])
            ])));
  }
}
