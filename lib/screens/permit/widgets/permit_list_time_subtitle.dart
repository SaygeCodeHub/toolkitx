import 'package:flutter/material.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/permit/all_permits_model.dart';
import '../../../data/models/status_tag_model.dart';
import '../../../widgets/icon_and_text_row.dart';
import '../../../widgets/status_tag.dart';
import 'date_time.dart';

class PermitListTimeSubtitle extends StatelessWidget {
  final AllPermitDatum allPermitDatum;

  const PermitListTimeSubtitle({super.key, required this.allPermitDatum});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: tinierSpacing),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(allPermitDatum.description!, maxLines: 3),
              const SizedBox(height: tinierSpacing),
              Row(children: [
                Image.asset('assets/icons/location.png',
                    height: kImageHeight, width: kImageWidth),
                const SizedBox(width: tiniestSpacing),
                Flexible(child: Text(allPermitDatum.location!, maxLines: 3))
              ]),
              const SizedBox(height: tinierSpacing),
              IconAndTextRow(
                  title: allPermitDatum.pname!, icon: 'human_avatar_three'),
              const SizedBox(height: tinierSpacing),
              IconAndTextRow(title: allPermitDatum.pcompany!, icon: 'office'),
              const SizedBox(height: tinierSpacing),
              DateTimeRow(allPermitDatum: allPermitDatum),
              const SizedBox(height: tinierSpacing),
              StatusTag(tags: [
                StatusTagModel(
                    title: (allPermitDatum.expired == '2')
                        ? DatabaseUtil.getText('Expired')
                        : '',
                    bgColor: AppColor.errorRed),
                StatusTagModel(
                    title: (allPermitDatum.npiStatus == '1')
                        ? DatabaseUtil.getText('NPI')
                        : '',
                    bgColor: AppColor.yellow),
                StatusTagModel(
                    title: (allPermitDatum.npwStatus == '1')
                        ? DatabaseUtil.getText('NPW')
                        : '',
                    bgColor: AppColor.yellow)
              ])
            ]));
  }
}
