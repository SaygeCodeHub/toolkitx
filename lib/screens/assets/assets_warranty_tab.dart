import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/assets/assets_details_model.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../configs/app_color.dart';

class AssetsWarrantyTab extends StatelessWidget {
  const AssetsWarrantyTab({super.key, required this.data});

  final Data data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(StringConstants.kWarranty,
              style: Theme.of(context)
                  .textTheme
                  .medium
                  .copyWith(fontWeight: FontWeight.w500, color: AppColor.grey)),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kWarrantyStart,
              style: Theme.of(context).textTheme.smallTextBlack),
          const SizedBox(height: tiniestSpacing),
          Text(data.warrantystart,
              style: Theme.of(context).textTheme.smallTextGrey),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kWarrantyEnd,
              style: Theme.of(context).textTheme.smallTextBlack),
          const SizedBox(height: tiniestSpacing),
          Text(data.warrantyend,
              style: Theme.of(context).textTheme.smallTextGrey),
        ]));
  }
}
