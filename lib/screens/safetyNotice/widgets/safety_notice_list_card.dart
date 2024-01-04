import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../blocs/safetyNotice/safety_notice_bloc.dart';
import '../../../blocs/safetyNotice/safety_notice_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/status_tag_model.dart';
import '../../../data/safetyNotice/fetch_safety_notices_model.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/status_tag.dart';
import '../safety_notice_details_screen.dart';

class SafetyNoticeListCard extends StatelessWidget {
  final Notice noticesDatum;

  const SafetyNoticeListCard({Key? key, required this.noticesDatum})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: ListTile(
        onTap: () {
          SafetyNoticeDetailsScreen.safetyNoticeId = noticesDatum.id;
          Navigator.pushNamed(context, SafetyNoticeDetailsScreen.routeName)
              .then((value) => context.read<SafetyNoticeBloc>().add(
              FetchSafetyNotices(pageNo: 1, isFromHomeScreen: false)));
        },
        contentPadding: const EdgeInsets.all(xxTinierSpacing),
        title: Padding(
            padding: const EdgeInsets.only(bottom: xxTinierSpacing),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(noticesDatum.refno,
                      style: Theme.of(context).textTheme.small.copyWith(
                          color: AppColor.black, fontWeight: FontWeight.w600)),
                  const SizedBox(width: tinierSpacing),
                  Text(noticesDatum.status,
                      style: Theme.of(context)
                          .textTheme
                          .xxSmall
                          .copyWith(color: AppColor.deepBlue))
                ])),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(noticesDatum.notice,
                style: Theme.of(context).textTheme.xSmall),
            const SizedBox(height: tinierSpacing),
            StatusTag(tags: [
              StatusTagModel(
                  title: noticesDatum.isexpired == '1'
                      ? DatabaseUtil.getText('Expired')
                      : noticesDatum.status == 'Issued' ? DatabaseUtil.getText('Issued') : DatabaseUtil.getText('Created'),
                  bgColor: noticesDatum.isexpired == '0'
                      ? AppColor.deepBlue
                      : AppColor.errorRed)
            ])
          ],
        ),
      ),
    );
  }
}
