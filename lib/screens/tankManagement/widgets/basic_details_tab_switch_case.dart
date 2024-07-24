import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';

Widget basicDetailsTabSwitchCase(context, type, data) {
  switch (type) {
    case '2':
    case '3':
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('RFId Number',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.rfidnumber),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Truck No',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.licenseplate),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Tanker Name',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.tankername),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Max Capacity',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.tankermaxcapacity),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Seal Number(s)',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text('Top : ${data.sealnotop} / Bottom : ${data.sealnobottom}'),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Driver EID/Name',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.drivername),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Tank',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.tank),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Carrier Company',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.carriercompany),
        const SizedBox(height: xxxSmallestSpacing),
        Text('No of Compartments',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.noofcompartments),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Flowmeter Quantity (cbm) per Compartment',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.volumn),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Truck Loading Position',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.truckposition),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Driver Phone',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.driverphone),
      ]);
    case '4':
    case '5':
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Ship Name',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.shipname),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Berth',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.berth),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Agent',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.agentname),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Captain / Carrier Person',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.captainCarrierperson),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Load port',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.loadport),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Contract',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.contractname),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Disport',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.disport),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Country of origin',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.countryoforigin),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Country of Production',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.countryofproduction),
      ]);
    case '1':
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Destination Tank',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.destinationtankname),
      ]);

    default:
      return Container();
  }
}
