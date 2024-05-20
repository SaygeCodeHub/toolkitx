import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../data/models/trips/fetch_trip_details_model.dart';

class TripDetailsTab extends StatelessWidget {
  const TripDetailsTab({
    super.key,
    required this.tripData,
  });

  final TripData tripData;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(StringConstants.kPurposeText,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(tripData.purposetext),
        const SizedBox(height: xxxSmallestSpacing),
        Text(StringConstants.kVessel,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(tripData.vesselname),
        const SizedBox(height: xxxSmallestSpacing),
        Text(StringConstants.kStatus,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(tripData.statustext),
        const SizedBox(height: xxxSmallestSpacing),
        Text(StringConstants.kDepartureDate,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(tripData.departuredatetime),
        const SizedBox(height: xxxSmallestSpacing),
        Text(StringConstants.kActualDepartureDate,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(tripData.actualdeparturedatetime),
        const SizedBox(height: xxxSmallestSpacing),
        Text(StringConstants.kArrivalDate,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(tripData.arrivaldatetime),
        const SizedBox(height: xxxSmallestSpacing),
        Text(StringConstants.kActualArrivalDate,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(tripData.actualarrivaldatetime),
        const SizedBox(height: xxxSmallestSpacing),
        Text(StringConstants.kDepartureDate,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(tripData.deplocname),
        const SizedBox(height: xxxSmallestSpacing),
        Text(StringConstants.kArrivalPort,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(tripData.arrlocname),
        const SizedBox(height: xxxSmallestSpacing),
        Text(StringConstants.kNotes,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(tripData.remarks),
      ]),
    );
  }
}
