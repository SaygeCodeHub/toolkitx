import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/assets/assets_details_model.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../../configs/app_color.dart';

class AssetsDetailsTab extends StatelessWidget {
  const AssetsDetailsTab({super.key, required this.data});
  final Data data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(StringConstants.kAssetName,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(data.name, style: Theme.of(context).textTheme.smallTextGrey),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kAssetTag,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(data.po, style: Theme.of(context).textTheme.smallTextGrey),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kServiceSite,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(data.servicesite,
              style: Theme.of(context).textTheme.smallTextGrey),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kAssetGroup,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(data.assetgroupname,
              style: Theme.of(context).textTheme.smallTextGrey),
          const SizedBox(height: xxxSmallestSpacing),
          Text(DatabaseUtil.getText("Category"),
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(data.subcategory,
              style: Theme.of(context).textTheme.smallTextGrey),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kCritically,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(data.criticality,
              style: Theme.of(context).textTheme.smallTextGrey),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kParentAsset,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(data.parentasset,
              style: Theme.of(context).textTheme.smallTextGrey),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kPosition,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(data.position, style: Theme.of(context).textTheme.smallTextGrey),
          const SizedBox(height: xxxSmallestSpacing),
          Text(DatabaseUtil.getText("Location"),
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(data.location, style: Theme.of(context).textTheme.smallTextGrey),
          const SizedBox(height: xxxSmallestSpacing),
          Text(DatabaseUtil.getText("Priority"),
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(data.priority, style: Theme.of(context).textTheme.smallTextGrey),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kState,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(data.status, style: Theme.of(context).textTheme.smallTextGrey),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kAssetSpecialist,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(data.owners, style: Theme.of(context).textTheme.smallTextGrey),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kBarcode,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(data.barcode, style: Theme.of(context).textTheme.smallTextGrey),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kSerial,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(data.serial, style: Theme.of(context).textTheme.smallTextGrey),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kModel,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(data.model, style: Theme.of(context).textTheme.smallTextGrey)
        ]));
  }
}
