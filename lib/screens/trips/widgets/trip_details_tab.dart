import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../../data/models/tickets/fetch_ticket_details_model.dart';
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
        Text("Purpose Text",
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(tripData.purposetext),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Vessel',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(tripData.vesselname),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Status',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(tripData.statustext),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Departure Date',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(tripData.departuredatetime),
        const SizedBox(height: xxxSmallestSpacing),
        Text("Actual Departure Date",
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(tripData.actualdeparturedatetime),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Arrival Date',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(tripData.arrivaldatetime),
        const SizedBox(height: xxxSmallestSpacing),
        Text('Actual Arrival Date',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(tripData.actualarrivaldatetime),
        const SizedBox(height: xxxSmallestSpacing),
        Text("Departure Port",
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(tripData.deplocname),
        const SizedBox(height: xxxSmallestSpacing),
        Text("Arrival Port",
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(tripData.arrlocname),
        const SizedBox(height: xxxSmallestSpacing),
        Text("Notes",
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
