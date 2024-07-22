import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';

Widget basicDetailsTabSwitchCase(context, type, data) {
  switch (type) {
    case '1':
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('RFId Number',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        // Text(data.purposetext),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Truck No',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        // Text(data.purposetext),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Tanker Name',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        // Text(data.purposetext),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Max Capacity',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        // Text(data.purposetext),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Seal Number(s)',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        // Text(data.actualdeparturedatetime),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Driver EID/Name',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        // Text(data.arrivaldatetime),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Tank',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        // Text(data.actualarrivaldatetime),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Carrier Company',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        // Text(data.deplocname),
        const SizedBox(height: xxxSmallestSpacing),
        Text('No of Compartments',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        // Text(data.arrlocname),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Flowmeter Quantity (cbm) per Compartment',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        // Text(data.remarks),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Truck Loading Position',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        // Text(data.remarks),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Driver Phone',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        // Text(data.remarks),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Nominated Quantity / Loading Certificate Weight',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        // Text(data.remarks),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Weight bridge net reading (kg)',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        // Text(data.remarks),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Loaded Quantity',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        // Text(data.remarks),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Gain / Loss',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        // Text(data.remarks),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Difference Between Nominated & Loaded Quantity (%)',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        // Text(data.remarks),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Overtime',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        // Text(data.remarks),
      ]);
    case '2':
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Ship Name',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        // Text(data.purposetext),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Berth',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        // Text(data.purposetext),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Agent',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        // Text(data.purposetext),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Captain / Carrier Person',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        // Text(data.purposetext),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Load port',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        // Text(data.actualdeparturedatetime),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Contract',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        // Text(data.arrivaldatetime),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Disport',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        // Text(data.actualarrivaldatetime),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Country of origin',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        // Text(data.deplocname),
        const SizedBox(height: xxxSmallestSpacing),
        Text('QCountry of Production',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        // Text(data.arrlocname),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Bill of Lading',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        // Text(data.remarks),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Weight of ship measurement at load port',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        // Text(data.remarks),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Weight of ship measurement at port arrival',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        // Text(data.remarks),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Ship Declared Quantity',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        // Text(data.remarks),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Received weight in tanks shore',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        // Text(data.remarks),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Line Quantity',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        // Text(data.remarks),
      ]);
    case '3':
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Destination Tank',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        // Text(data.purposetext),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Source tank deliverded quantity',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        // Text(data.purposetext),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Destination tank received quantity',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        // Text(data.purposetext),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Source tank Outurn Quantity',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        // Text(data.purposetext),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Destination tank Outurn Quantity',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        // Text(data.actualdeparturedatetime),
      ]);

    default:
      return Container();
  }
}
