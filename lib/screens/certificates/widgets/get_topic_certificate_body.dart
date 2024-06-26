import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/certificates/get_notes_certificate_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/certificates/get_topic_certificate_model.dart';
import 'certificate_topic_quiz_card.dart';

class GetTopicCertificateBody extends StatelessWidget {
  const GetTopicCertificateBody({
    super.key,
    required this.data,
    required this.certificateId,
  });

  final GetTopicData data;
  final String certificateId;

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
        const SizedBox(height: tinierSpacing),
        ListView.separated(
            itemCount: data.topiclist.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Card(
                  child: ListTile(
                      onTap: () {
                        Map getNotesMap = {
                          "coursename": data.coursename,
                          "certificatename": data.certificatename,
                          "name": data.topiclist[index].name,
                          "id": data.topiclist[index].id
                        };
                        Navigator.pushNamed(
                            context, GetNotesCertificateScreen.routeName,
                            arguments: getNotesMap);
                      },
                      contentPadding: const EdgeInsets.all(kCardPadding),
                      leading: Container(
                          width: kModuleIconSize,
                          height: kModuleIconSize,
                          decoration: const BoxDecoration(
                              color: AppColor.blueGrey,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(kSmallBorderRadius))),
                          child: Center(child: Text('${index + 1}'))),
                      title: Text(data.topiclist[index].name,
                          style: Theme.of(context).textTheme.small.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColor.mediumBlack)),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: xxxTinierSpacing),
                            Text(
                                "${data.topiclist[index].notescount} ${StringConstants.kPagesInside}",
                                style: Theme.of(context)
                                    .textTheme
                                    .xSmall
                                    .copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.grey))
                          ]),
                      trailing: Container(
                          width: kDotContianerSize,
                          height: kDotContianerSize,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(kImageHeight)),
                              color: data.topiclist[index].completedcount ==
                                      data.topiclist[index].notescount
                                  ? AppColor.green
                                  : data.topiclist[index].completedcount == 0
                                      ? null
                                      : AppColor.orange))));
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: xxTinierSpacing);
            }),
        const SizedBox(height: tinierSpacing),
        CertificateTopicQuizCard(data: data, certificateId: certificateId)
      ],
    );
  }
}
