import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/custom_card.dart';

import '../../../../data/models/trips/fetch_trip_details_model.dart';
import '../edit_special_request_screen.dart';

class TripDetailsTabThree extends StatelessWidget {
  const TripDetailsTabThree({
    super.key,
    required this.tripData,
  });

  final TripData tripData;

  @override
  Widget build(BuildContext context) {
    List popUpMenuItems = ["Edit", "Delete"];
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
                trailing: Column(
                  children: [
                    Text(tripData.specialrequests[index].processedDate,
                        style: Theme.of(context).textTheme.xSmall.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.w600)),
                    SizedBox(
                        width: 100,
                        height: 30,
                        child: PopupMenuButton(
                            onSelected: (value) {
                              if (value == "Edit") {
                                Navigator.pushNamed(
                                    context, EditSpecialRequestScreen.routeName,
                                    arguments: [
                                      tripData.id,
                                      tripData.specialrequests[index].id
                                    ]);
                              }
                            },
                            position: PopupMenuPosition.under,
                            itemBuilder: (BuildContext context) => [
                                  for (int i = 0;
                                      i < popUpMenuItems.length;
                                      i++)
                                    _buildPopupMenuItem(context,
                                        popUpMenuItems[i], popUpMenuItems[i])
                                ])),
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        });
  }

  PopupMenuItem _buildPopupMenuItem(context, String title, String position) {
    return PopupMenuItem(
        value: position,
        child: Text(title, style: Theme.of(context).textTheme.xSmall));
  }
}
