import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_card.dart';

class LeavesDetailsCard extends StatelessWidget {
  final dynamic detailsData;

  const LeavesDetailsCard({super.key, this.detailsData});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        child: Padding(
            padding: const EdgeInsets.only(top: tinierSpacing),
            child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(detailsData.leavetype,
                        style: Theme.of(context).textTheme.small.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColor.black)),
                    Text(detailsData.statustext,
                        style: Theme.of(context).textTheme.xSmall.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColor.deepBlue))
                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: tinierSpacing),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('${DatabaseUtil.getText('TotalDays')}:'),
                          const SizedBox(width: tiniestSpacing),
                          Text(detailsData.totaldays.toString()),
                        ],
                      ),
                      const SizedBox(height: tinierSpacing),
                      Row(
                        children: [
                          Text('${DatabaseUtil.getText('AppliedOn')}:'),
                          const SizedBox(width: tiniestSpacing),
                          Text(detailsData.applydate),
                        ],
                      ),
                      const SizedBox(height: tinierSpacing),
                      Row(
                        children: [
                          Image.asset('assets/icons/calendar.png',
                              height: kImageHeight, width: kImageWidth),
                          const SizedBox(width: tiniestSpacing),
                          Text(detailsData.schedule),
                        ],
                      ),
                      const SizedBox(height: tinierSpacing),
                    ],
                  ),
                ))));
  }
}
