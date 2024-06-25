import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../configs/app_spacing.dart';
import '../../../data/models/location/fetch_location_details_model.dart';
import '../../../utils/database_utils.dart';

class LocationDetailsTabOne extends StatelessWidget {
  final LocationDetailsData data;
  final int selectedTabIndex;

  const LocationDetailsTabOne(
      {Key? key, required this.data, required this.selectedTabIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: tiniestSpacing),
            Text(DatabaseUtil.getText('Name'),
                style: Theme.of(context).textTheme.medium),
            const SizedBox(height: xxTinierSpacing),
            Text(data.name, style: Theme.of(context).textTheme.small),
            const SizedBox(height: tinySpacing),
            Text(StringConstants.kParentLocation,
                style: Theme.of(context).textTheme.medium),
            const SizedBox(height: xxTinierSpacing),
            Text(data.parent, style: Theme.of(context).textTheme.small),
            const SizedBox(height: tinySpacing),
            Text(DatabaseUtil.getText('Category'),
                style: Theme.of(context).textTheme.medium),
            const SizedBox(height: xxTinierSpacing),
            Text(data.categoryname, style: Theme.of(context).textTheme.small),
            const SizedBox(height: tinySpacing),
            Text(StringConstants.kPowerStatus,
                style: Theme.of(context).textTheme.medium),
            const SizedBox(height: xxTinierSpacing),
            Text(data.powerstatus, style: Theme.of(context).textTheme.small),
            const SizedBox(height: tinySpacing),
            Text(StringConstants.kSelectType,
                style: Theme.of(context).textTheme.medium),
            const SizedBox(height: xxTinierSpacing),
            Text(data.type, style: Theme.of(context).textTheme.small),
            const SizedBox(height: tinySpacing),
            Text(StringConstants.kOperationalStatus,
                style: Theme.of(context).textTheme.medium),
            const SizedBox(height: xxTinierSpacing),
            Text(data.operationstatus,
                style: Theme.of(context).textTheme.small),
            const SizedBox(height: tinySpacing),
            Text(StringConstants.kRestrictionStatus,
                style: Theme.of(context).textTheme.medium),
            const SizedBox(height: xxTinierSpacing),
            Text(data.restrictionstatus,
                style: Theme.of(context).textTheme.small),
            const SizedBox(height: tinySpacing),
            Text(StringConstants.kRDSPPCode,
                style: Theme.of(context).textTheme.medium),
            const SizedBox(height: xxTinierSpacing),
            Text(data.rdspp, style: Theme.of(context).textTheme.small),
            const SizedBox(height: tinySpacing)
          ],
        ));
  }
}
