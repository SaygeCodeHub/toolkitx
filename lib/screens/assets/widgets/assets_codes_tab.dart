import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/assets/assets_details_model.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../../configs/app_color.dart';

class AssetsCodesTab extends StatelessWidget {
  const AssetsCodesTab({super.key, required this.data});

  final Data data;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(StringConstants.kCodes,
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(fontWeight: FontWeight.bold, color: AppColor.grey)),
      const SizedBox(height: xxxSmallestSpacing),
      Text(DatabaseUtil.getText("CostCente"),
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
      const SizedBox(height: tiniestSpacing),
      Text(data.costcenter, style: Theme.of(context).textTheme.smallTextGrey),
      const SizedBox(height: xxxSmallestSpacing),
      Text(StringConstants.kLatitude,
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
      const SizedBox(height: tiniestSpacing),
      Text(data.latitude, style: Theme.of(context).textTheme.smallTextGrey),
      const SizedBox(height: xxxSmallestSpacing),
      Text(StringConstants.kAccount,
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
      const SizedBox(height: tiniestSpacing),
      Text(data.account, style: Theme.of(context).textTheme.smallTextGrey),
      const SizedBox(height: xxxSmallestSpacing),
      Text(StringConstants.kDepartment,
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
      const SizedBox(height: tiniestSpacing),
      Text(data.department, style: Theme.of(context).textTheme.smallTextGrey),
      const SizedBox(height: xxxSmallestSpacing),
      Text(StringConstants.kLongitude,
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
      const SizedBox(height: tiniestSpacing),
      Text(data.longitude, style: Theme.of(context).textTheme.smallTextGrey),
    ]);
  }
}
