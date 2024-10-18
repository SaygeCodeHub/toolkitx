import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../data/models/trips/fetch_trip_details_model.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/generic_alphanumeric_generator_util.dart';
import '../../../utils/incident_view_image_util.dart';

class TripDetailsTabTwo extends StatelessWidget {
  const TripDetailsTabTwo({
    super.key,
    required this.tripData,
    required this.clientId,
  });

  final TripData tripData;
  final String clientId;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: tripData.documents.length,
        itemBuilder: (context, index) {
          String files = tripData.documents[index].files;
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
                    ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: ViewImageUtil.viewImageList(files).length,
                        itemBuilder: (context, index) {
                          return InkWell(
                              splashColor: AppColor.transparent,
                              highlightColor: AppColor.transparent,
                              onTap: () {
                                launchUrlString(
                                    '${ApiConstants.viewDocBaseUrl}${ViewImageUtil.viewImageList(files)[index]}&code=${RandomValueGeneratorUtil.generateRandomValue(clientId)}',
                                    mode: LaunchMode.externalApplication);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: xxxTinierSpacing),
                                child: Text(
                                    ViewImageUtil.viewImageList(files)[index],
                                    style: const TextStyle(
                                        color: AppColor.deepBlue)),
                              ));
                        }),
                  ],
                ),
              ));
        },
        separatorBuilder: (context, index) {
          return const Divider(color: AppColor.black);
        });
  }
}
