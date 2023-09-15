import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/certificates/get_notes_certificate_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/certificates/get_topic_certificate_model.dart';

class GetTopicCertificateBody extends StatelessWidget {
  const GetTopicCertificateBody({
    super.key,
    required this.data,
  });
  final GetTopicData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(StringConstants.kGettingStarted,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(fontWeight: FontWeight.w600, color: AppColor.black)),
        const SizedBox(
          height: tinierSpacing,
        ),
        Card(
          child: ListTile(
            onTap: () {
              Map getNotesMap = {
                "coursename": data.coursename,
                "certificatename": data.certificatename,
                "name": data.topiclist[0].name,
                "id": data.topiclist[0].id
              };
              Navigator.pushNamed(context, GetNotesCertificateScreen.routeName,
                  arguments: getNotesMap);
            },
            contentPadding: const EdgeInsets.all(kCardPadding),
            leading: Container(
                width: kModuleIconSize,
                height: kModuleIconSize,
                decoration: const BoxDecoration(
                    color: AppColor.blueGrey,
                    borderRadius:
                        BorderRadius.all(Radius.circular(kSmallBorderRadius))),
                child: const Center(child: Text(StringConstants.k1))),
            title: Text(data.topiclist[0].name,
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w600, color: AppColor.mediumBlack)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: xxxTinierSpacing,
                ),
                Text(
                    "${data.topiclist[0].notescount} ${StringConstants.kPagesInside}",
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        fontWeight: FontWeight.w400, color: AppColor.grey)),
              ],
            ),
            trailing: Container(
              width: kDotContianerSize,
              height: kDotContianerSize,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(kImageHeight)),
                  color: AppColor.green),
            ),
          ),
        ),
        const SizedBox(
          height: tinierSpacing,
        ),
        Card(
          child: ListTile(
            contentPadding: const EdgeInsets.all(kCardPadding),
            leading: Container(
                width: kModuleIconSize,
                height: kModuleIconSize,
                decoration: const BoxDecoration(
                    color: AppColor.blueGrey,
                    borderRadius:
                        BorderRadius.all(Radius.circular(kCardRadius))),
                child: const Center(child: Text(StringConstants.kQ))),
            title: Text(data.quizlist[0].name,
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w600, color: AppColor.mediumBlack)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: xxxTinierSpacing,
                ),
                Text(
                    "${data.quizlist[0].questionscount} ${StringConstants.kQuestionsInside}",
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        fontWeight: FontWeight.w400, color: AppColor.grey)),
              ],
            ),
            trailing: Container(
              width: kDotContianerSize,
              height: kDotContianerSize,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(kImageHeight)),
                  color: AppColor.orange),
            ),
          ),
        ),
      ],
    );
  }
}
