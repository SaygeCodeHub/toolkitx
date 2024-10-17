import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/assets/assets_details_model.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../configs/app_color.dart';
import '../../../utils/asset_depreciation_util.dart';

class AssetsCostAndDepreciationTab extends StatelessWidget {
  const AssetsCostAndDepreciationTab(
      {super.key, required this.data, required this.fetchAssetsDetailsModel});
  final Data data;
  final FetchAssetsDetailsModel fetchAssetsDetailsModel;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(StringConstants.kCostAndDepreciation,
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(fontWeight: FontWeight.bold, color: AppColor.grey)),
      const SizedBox(height: xxxSmallestSpacing),
      Text(StringConstants.kDepreciationMethod,
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
      const SizedBox(height: tiniestSpacing),
      Text(
          AssetsDepreciationUtil()
              .assetsDepreciationWidget(fetchAssetsDetailsModel),
          style: Theme.of(context).textTheme.smallTextGrey),
      const SizedBox(height: xxxSmallestSpacing),
      Text(StringConstants.kPurchaseDate,
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
      const SizedBox(height: tiniestSpacing),
      Text(data.purchasedate, style: Theme.of(context).textTheme.smallTextGrey),
      const SizedBox(height: xxxSmallestSpacing),
      Text(StringConstants.kSalvageValue,
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
      const SizedBox(height: tiniestSpacing),
      Text(data.salvagevalue, style: Theme.of(context).textTheme.smallTextGrey),
      const SizedBox(height: xxxSmallestSpacing),
      Text(StringConstants.kAssetCost,
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
      const SizedBox(height: tiniestSpacing),
      Text(data.assetcost, style: Theme.of(context).textTheme.smallTextGrey),
      const SizedBox(height: xxxSmallestSpacing),
      Text(StringConstants.kLifespanYears,
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
      const SizedBox(height: tiniestSpacing),
      Text(data.depyears, style: Theme.of(context).textTheme.smallTextGrey),
      const SizedBox(height: xxxSmallestSpacing),
      Text(StringConstants.kDepreciationFactor,
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
      const SizedBox(height: tiniestSpacing),
      Text(data.depfactor, style: Theme.of(context).textTheme.smallTextGrey),
    ]);
  }
}
