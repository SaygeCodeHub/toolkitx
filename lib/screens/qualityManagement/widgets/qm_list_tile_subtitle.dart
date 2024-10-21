import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/qualityManagement/fetch_qm_list_model.dart';

class QualityManagementListTileSubtitle extends StatelessWidget {
  final QMListDatum data;

  const QualityManagementListTileSubtitle({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      RichText(
          text: TextSpan(
              text: '[${data.categoryname}] ',
              style: Theme.of(context)
                  .textTheme
                  .xSmall
                  .copyWith(color: AppColor.black, fontWeight: FontWeight.w500),
              children: [
            TextSpan(
                text: data.description,
                style: Theme.of(context).textTheme.xSmall)
          ])),
      const SizedBox(height: tinierSpacing),
      Text(data.location,
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(color: AppColor.grey)),
      const SizedBox(height: tinierSpacing),
      Row(children: [
        Image.asset("assets/icons/calendar.png",
            height: kIconSize, width: kIconSize),
        const SizedBox(width: tiniestSpacing),
        Text(data.eventdatetime,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.grey))
      ]),
      const SizedBox(height: tinierSpacing)
    ]);
  }
}
