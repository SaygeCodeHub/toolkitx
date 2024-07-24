import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/tankManagement/fetch_tank_management_details_model.dart';
import 'package:toolkit/screens/tankManagement/widgets/basic_details_tab_switch_case.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';

class TankManagementBasicDetails extends StatelessWidget {
  const TankManagementBasicDetails(
      {super.key, required this.fetchTankManagementDetailsModel});

  final FetchTankManagementDetailsModel fetchTankManagementDetailsModel;

  @override
  Widget build(BuildContext context) {
    var data = fetchTankManagementDetailsModel.data;
    return Padding(
      padding: const EdgeInsets.only(
        left: leftRightMargin,
        right: leftRightMargin,
        top: xxTinierSpacing,
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(StringConstants.kNo,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(data.nominationo),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kStatus,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(data.status),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Title',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(data.announcetext),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Scheduled Date',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(data.announcedetails),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Customer',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(data.customername),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Contract',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(data.contractname),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Tank',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(data.tank),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Product',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(data.productname),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Quantity (cbm)',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(data.metriccbm),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Quantity (kg)',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(data.metrictons),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Surveyour',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(data.surveyourname),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Custom Status',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(data.customstatus),
          const SizedBox(height: xxxSmallestSpacing),
          basicDetailsTabSwitchCase(context, data.type, data)
        ]),
      ),
    );
  }
}
