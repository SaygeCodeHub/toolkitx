import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/custom_card.dart';

import '../../../data/models/trips/fetch_trip_details_model.dart';

class TripDetailsTabThree extends StatelessWidget {
  const TripDetailsTabThree({
    super.key,
    required this.tripData,
  });

  final TripData tripData;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: tripData.specialrequests.length,
        itemBuilder: (context, index) {
          return CustomCard(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(tripData.specialrequests[index].specialrequest,
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        color: AppColor.black, fontWeight: FontWeight.bold)),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: xxTinierSpacing),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          tripData
                              .specialrequests[index].specialrequesttypename,
                          style: Theme.of(context).textTheme.xSmall.copyWith(
                              color: AppColor.black,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: tiniestSpacing),
                      Text(
                          tripData.specialrequests[index].constructionFullName),
                      const SizedBox(height: tiniestSpacing),
                      Text(tripData.specialrequests[index].processedStatus),
                    ],
                  ),
                ),
                trailing: Text(tripData.specialrequests[index].processedDate,
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        color: AppColor.black, fontWeight: FontWeight.w600)),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        });
  }
}
