import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/assets/assets_details_model.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../configs/app_color.dart';

class AssetsITInfoTab extends StatelessWidget {
  const AssetsITInfoTab({super.key, required this.data});

  final Data data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(StringConstants.kITInfo,
              style: Theme.of(context)
                  .textTheme
                  .medium
                  .copyWith(fontWeight: FontWeight.bold, color: AppColor.grey)),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kITType,
              style: Theme.of(context).textTheme.smallTextBlack),
          const SizedBox(height: tiniestSpacing),
          Text(data.ittype, style: Theme.of(context).textTheme.smallTextGrey),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kITFlag,
              style: Theme.of(context).textTheme.smallTextBlack),
          const SizedBox(height: tiniestSpacing),
          Text(data.itflag, style: Theme.of(context).textTheme.smallTextGrey),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kIP,
              style: Theme.of(context).textTheme.smallTextBlack),
          const SizedBox(height: tiniestSpacing),
          Text(data.ip, style: Theme.of(context).textTheme.smallTextGrey),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kOtherIp,
              style: Theme.of(context).textTheme.smallTextBlack),
          const SizedBox(height: tiniestSpacing),
          Text(data.otherip, style: Theme.of(context).textTheme.smallTextGrey),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kMACAddress,
              style: Theme.of(context).textTheme.smallTextBlack),
          const SizedBox(height: tiniestSpacing),
          Text(data.macaddress,
              style: Theme.of(context).textTheme.smallTextGrey),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kSubType,
              style: Theme.of(context).textTheme.smallTextBlack),
          const SizedBox(height: tiniestSpacing),
          Text(data.subtype, style: Theme.of(context).textTheme.smallTextGrey),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kOSName,
              style: Theme.of(context).textTheme.smallTextBlack),
          const SizedBox(height: tiniestSpacing),
          Text(data.osname, style: Theme.of(context).textTheme.smallTextGrey),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kSystemID,
              style: Theme.of(context).textTheme.smallTextBlack),
          const SizedBox(height: tiniestSpacing),
          Text(data.systemid, style: Theme.of(context).textTheme.smallTextGrey),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kLinkedTo,
              style: Theme.of(context).textTheme.smallTextBlack),
          const SizedBox(height: tiniestSpacing),
          Text(data.linkedto, style: Theme.of(context).textTheme.smallTextGrey),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kExtId,
              style: Theme.of(context).textTheme.smallTextBlack),
          const SizedBox(height: tiniestSpacing),
          Text(data.extid, style: Theme.of(context).textTheme.smallTextGrey),
        ]));
  }
}
