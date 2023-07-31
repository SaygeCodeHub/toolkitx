import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/qualityManagement/fetch_qm_details_model.dart';

class QualityManagementMapLinksList extends StatelessWidget {
  final QMDetailsData data;

  const QualityManagementMapLinksList({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: data.maplinks.length,
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return const SizedBox(height: xxTinierSpacing);
        },
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                launchUrlString(data.maplinks[index].link,
                    mode: LaunchMode.inAppWebView);
              },
              child: RichText(
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
                textDirection: TextDirection.rtl,
                softWrap: true,
                maxLines: 2,
                textScaleFactor: 1,
                text: TextSpan(
                  text: "${data.maplinks[index].name} : ",
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                        text: data.maplinks[index].link,
                        style: Theme.of(context).textTheme.xSmall.copyWith(
                              color: AppColor.deepBlue,
                            )),
                  ],
                ),
              ));
        });
  }
}
