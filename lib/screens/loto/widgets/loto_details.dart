import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/loto/loto_details_model.dart';
import '../../../utils/database_utils.dart';

class LotoDetails extends StatelessWidget {
  const LotoDetails(
      {super.key,
      required this.fetchLotoDetailsModel,
      required this.lotoTabIndex});
  final FetchLotoDetailsModel fetchLotoDetailsModel;
  final int lotoTabIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: leftRightMargin,
        right: leftRightMargin,
        top: xxTinierSpacing,
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(DatabaseUtil.getText('Date'),
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(fetchLotoDetailsModel.data.lotodate),
          const SizedBox(height: xxxSmallestSpacing),
          Text(DatabaseUtil.getText('Status'),
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(fetchLotoDetailsModel.data.statustext),
          const SizedBox(height: xxxSmallestSpacing),
          Text(DatabaseUtil.getText('Location'),
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(fetchLotoDetailsModel.data.locname),
          const SizedBox(height: xxxSmallestSpacing),
          Text(DatabaseUtil.getText("confirm_location_with_QR"),
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          const Text(StringConstants.kNo),
          const SizedBox(height: xxxSmallestSpacing),
          Text(DatabaseUtil.getText('Assets'),
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kConfirmAssetWithQR,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          const Text(StringConstants.kNo),
          const SizedBox(height: xxxSmallestSpacing),
          Text(DatabaseUtil.getText("DistributionList"),
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(fetchLotoDetailsModel.data.distributionlist),
          const SizedBox(height: xxxSmallestSpacing),
          Text(DatabaseUtil.getText("Purpose"),
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(fetchLotoDetailsModel.data.purposenames),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kLocationDocuments,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          const Text("Report"),
          const SizedBox(height: xxxSmallestSpacing),
          Text(DatabaseUtil.getText("safelock_number"),
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(fetchLotoDetailsModel.data.safelockno),
          const SizedBox(height: xxxSmallestSpacing),
          Text(DatabaseUtil.getText("contractor"),
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: xxxSmallestSpacing),
          Text(DatabaseUtil.getText("additional_info"),
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(fetchLotoDetailsModel.data.additionalinfo),
          const SizedBox(height: tiniestSpacing),
        ]),
      ),
    );
  }
}
