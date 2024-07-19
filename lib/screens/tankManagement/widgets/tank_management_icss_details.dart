import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/tankManagement/fetch_tank_management_details_model.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';

class TankManagementICSSDetails extends StatelessWidget {
  const TankManagementICSSDetails(
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
        child: icssDetailsTabSwitchCase(context, data.type, data),
      ),
    );
  }

  Widget icssDetailsTabSwitchCase(context, type, data) {
    switch (type) {
      case '1':
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Tank',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          // Text(data.purposetext),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Product',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          // Text(data.vesselname),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Density (kg/m3)',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          // Text(data.statustext),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Temperature (°C)',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          // Text(data.departuredatetime),
          const SizedBox(height: xxxSmallestSpacing),
          // Text(data.purposetext),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Truck No',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          // Text(data.actualdeparturedatetime),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Entry DateTime',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          // Text(data.arrivaldatetime),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Entry Weight (kg)',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          // Text(data.actualarrivaldatetime),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Exit DateTime',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          // Text(data.deplocname),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Exit Weight (kg)',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          // Text(data.arrlocname),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Tank Initial Weight (kg) ',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          // Text(data.remarks),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Tank Initial Level (mm)',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          // Text(data.remarks),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Tank Final Weight (kg)',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          // Text(data.remarks),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Tank Final Level (mm)',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          // Text(data.remarks),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Flowmeter Quantity (kg) per Compartment',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          // Text(data.remarks),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Reporting Time',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          // Text(data.remarks),
          const SizedBox(height: xxxSmallestSpacing),
          Text('THA In Time',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          // Text(data.remarks),
          const SizedBox(height: xxxSmallestSpacing),
          Text('THA Out Time',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          // Text(data.remarks),
          const SizedBox(height: xxxSmallestSpacing),
          Text('THA Opereation Completed',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          // Text(data.remarks),
        ]);
      case '2':
      case '3':
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Tank',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          // Text(data.purposetext),
          const SizedBox(height: xxxSmallestSpacing),
          Text('PitA - Tank-1Product',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          // Text(data.purposetext),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Product 3',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          // Text(data.purposetext),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Density (kg/m3)',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          // Text(data.purposetext),
          const SizedBox(height: xxxSmallestSpacing),
          Text('Start DateTime',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          // Text(data.actualdeparturedatetime),
          const SizedBox(height: xxxSmallestSpacing),
          Text('End DateTime',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          // Text(data.arrivaldatetime),
          const SizedBox(height: xxxSmallestSpacing),
          Text('We need to display table here - Check snapshot',
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          // Text(data.actualarrivaldatetime),
        ]);

      default:
        return Container();
    }
  }
}
