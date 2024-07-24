import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

Widget basicDetailsTabSwitchCase(context, type, data) {
  switch (type) {
    case '2':
    case '3':
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(StringConstants.kRFIdNumber,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.rfidnumber),
        const SizedBox(height: xxxSmallestSpacing),
        Text(StringConstants.kTruckNo,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.licenseplate),
        const SizedBox(height: xxxSmallestSpacing),
        Text(StringConstants.kTankerName,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.tankername),
        const SizedBox(height: xxxSmallestSpacing),
        Text(StringConstants.kMaxCapacity,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.tankermaxcapacity),
        const SizedBox(height: xxxSmallestSpacing),
        Text(StringConstants.kSealNumber,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(
            '${StringConstants.kTop} : ${data.sealnotop} / ${StringConstants.kBottom} : ${data.sealnobottom}'),
        const SizedBox(height: xxxSmallestSpacing),
        Text(StringConstants.kDriverEIDName,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.drivername),
        const SizedBox(height: xxxSmallestSpacing),
        Text(StringConstants.kCarrierCompany,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.carriercompany),
        const SizedBox(height: xxxSmallestSpacing),
        Text(StringConstants.kNoOfCompartment,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.noofcompartments),
        const SizedBox(height: xxxSmallestSpacing),
        Text(StringConstants.kFlowMeterQuantityCBMPerCompartment,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.volumn),
        const SizedBox(height: xxxSmallestSpacing),
        Text(StringConstants.kTruckLoadingPosition,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.truckposition),
        const SizedBox(height: xxxSmallestSpacing),
        Text(StringConstants.kDriverPhone,
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
        Text(StringConstants.kShipName,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.shipname),
        const SizedBox(height: xxxSmallestSpacing),
        Text(StringConstants.kBerth,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.berth),
        const SizedBox(height: xxxSmallestSpacing),
        Text(StringConstants.kAgent,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.agentname),
        const SizedBox(height: xxxSmallestSpacing),
        Text(StringConstants.kCaptainCarrierPerson,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.captainCarrierperson),
        const SizedBox(height: xxxSmallestSpacing),
        Text(StringConstants.kLoadPart,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.loadport),
        const SizedBox(height: xxxSmallestSpacing),
        Text(StringConstants.kContract,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.contractname),
        const SizedBox(height: xxxSmallestSpacing),
        Text(StringConstants.kDisport,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.disport),
        const SizedBox(height: xxxSmallestSpacing),
        Text(StringConstants.kCountryOfOrigin,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.countryoforigin),
        const SizedBox(height: xxxSmallestSpacing),
        Text(StringConstants.kCountryOfProduction,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.countryofproduction),
      ]);
    case '1':
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(StringConstants.kDestinationTank,
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
