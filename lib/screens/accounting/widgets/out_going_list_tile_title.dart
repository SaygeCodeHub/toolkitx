import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';

class OutGoingListTileTitle extends StatelessWidget {
  final Map<String, String> data;

  const OutGoingListTileTitle({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: xxTinierSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data['entity'] ?? '',
              style: Theme.of(context).textTheme.small.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.w600)),
          const SizedBox(height: tinierSpacing),
          Text('Client: ${data['client']}',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
