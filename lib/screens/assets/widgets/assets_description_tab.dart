import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/assets/assets_details_model.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../configs/app_color.dart';

class AssetsDescriptionTab extends StatelessWidget {
  const AssetsDescriptionTab({super.key, required this.data});
  final Data data;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(StringConstants.kDescriptionTitle,
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(fontWeight: FontWeight.bold, color: AppColor.grey)),
      const SizedBox(height: xxxSmallestSpacing),
      Text(StringConstants.kScAsset,
          style: Theme.of(context).textTheme.smallTextBlack),
      const SizedBox(height: tiniestSpacing),
      Text(data.scasset, style: Theme.of(context).textTheme.smallTextGrey),
      const SizedBox(height: xxxSmallestSpacing),
      Text(StringConstants.kChildPattern,
          style: Theme.of(context).textTheme.smallTextBlack),
      const SizedBox(height: tiniestSpacing),
      Text(data.childpattern, style: Theme.of(context).textTheme.smallTextGrey),
      const SizedBox(height: xxxSmallestSpacing),
      Text(StringConstants.kDescription,
          style: Theme.of(context).textTheme.smallTextBlack),
      const SizedBox(height: tiniestSpacing),
      Text(data.description, style: Theme.of(context).textTheme.smallTextGrey),
    ]);
  }
}
