import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';

class OutGoingListTileSubtitle extends StatelessWidget {
  final Map<String, String> data;

  const OutGoingListTileSubtitle({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Image.asset("assets/icons/calendar.png",
            height: kIconSize, width: kIconSize),
        const SizedBox(width: tiniestSpacing),
        Text(data['date'] ?? '',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.grey))
      ]),
      const SizedBox(height: tinierSpacing),
      Text(data['amount'] ?? '',
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(color: AppColor.grey)),
      const SizedBox(height: tinierSpacing),
    ]);
  }
}
