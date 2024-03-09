import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/incident/incident_details_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';

class IncidentMapLinksList extends StatelessWidget {
  final IncidentDetailsModel incidentDetailsModel;

  const IncidentMapLinksList({Key? key, required this.incidentDetailsModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: incidentDetailsModel.data!.maplinks!.length,
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return const SizedBox(height: xxTinierSpacing);
        },
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                launchUrlString(
                    incidentDetailsModel.data!.maplinks![index].link,
                    mode: LaunchMode.inAppWebView);
              },
              child: RichText(
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
                textDirection: TextDirection.rtl,
                softWrap: true,
                maxLines: 2,
                text: TextSpan(
                  text:
                      "${incidentDetailsModel.data!.maplinks![index].name} : ",
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                        text: incidentDetailsModel.data!.maplinks![index].link,
                        style: Theme.of(context).textTheme.xSmall.copyWith(
                              color: AppColor.deepBlue,
                            )),
                  ],
                ),
                textScaler: const TextScaler.linear(1),
              ));
        });
  }
}
