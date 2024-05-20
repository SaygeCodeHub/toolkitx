import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../data/models/trips/fetch_trip_details_model.dart';

class TripDetailsTabTwo extends StatelessWidget {
  const TripDetailsTabTwo({
    super.key,
    required this.tripData,
  });

  final TripData tripData;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: tripData.documents.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: Text(tripData.documents[index].name,
                  style: Theme.of(context).textTheme.xSmall.copyWith(
                      color: AppColor.black, fontWeight: FontWeight.bold)),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: xxTinierSpacing),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tripData.documents[index].type,
                        style: Theme.of(context).textTheme.xSmall.copyWith(
                            color: AppColor.grey, fontWeight: FontWeight.w400)),
                    const SizedBox(height: xxTinierSpacing),
                    Text(tripData.documents[index].files,
                        style: Theme.of(context).textTheme.xxSmall.copyWith(
                            color: AppColor.deepBlue,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
              ));
        },
        separatorBuilder: (context, index) {
          return const Divider(color: AppColor.black);
        });
  }
}
