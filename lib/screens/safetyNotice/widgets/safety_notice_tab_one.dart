import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_spacing.dart';
import '../../../data/safetyNotice/fetch_safety_notice_details_model.dart';
import '../../../utils/database_utils.dart';
import 'safety_notice_details_view_files.dart';

class SafetyNoticeTabOne extends StatelessWidget {
  final int tabIndex;
  final SafetyNoticeData safetyNoticeData;
  final String clientId;

  const SafetyNoticeTabOne(
      {Key? key,
      required this.tabIndex,
      required this.safetyNoticeData,
      required this.clientId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: tiniestSpacing),
            Text(DatabaseUtil.getText('Notice'),
                style: Theme.of(context).textTheme.medium),
            const SizedBox(height: xxTinierSpacing),
            Text(safetyNoticeData.notice),
            const SizedBox(height: xxTinySpacing),
            Text(DatabaseUtil.getText('Image'),
                style: Theme.of(context).textTheme.medium),
            const SizedBox(height: xxTinierSpacing),
            Visibility(
                visible: safetyNoticeData.files.isNotEmpty,
                child: SafetyNoticeDetailsViewFiles(
                    clientId: clientId, files: safetyNoticeData.files)),
          ],
        ));
  }
}
