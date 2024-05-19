import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/permit/permit_details_model.dart';
import '../../../utils/database_utils.dart';

class PermitDetails extends StatelessWidget {
  final PermitDetailsModel permitDetailsModel;

  const PermitDetails({Key? key, required this.permitDetailsModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: tinySpacing),
          Text(DatabaseUtil.getText('Schedule'),
              style: Theme.of(context).textTheme.medium.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: xxTinierSpacing),
          Text(permitDetailsModel.data.tab1.schedule,
              style: Theme.of(context).textTheme.small),
          const SizedBox(height: tinySpacing),
          Text(DatabaseUtil.getText('NPI'),
              style: Theme.of(context).textTheme.medium.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: xxTinierSpacing),
          Text(permitDetailsModel.data.tab1.pnameNpi,
              style: Theme.of(context).textTheme.small),
          const SizedBox(height: tinySpacing),
          Text(DatabaseUtil.getText('NPW'),
              style: Theme.of(context).textTheme.medium.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: xxTinierSpacing),
          Text(permitDetailsModel.data.tab1.pname,
              style: Theme.of(context).textTheme.small),
          const SizedBox(height: tinySpacing),
          Text(DatabaseUtil.getText('Description'),
              style: Theme.of(context).textTheme.medium.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: xxTinierSpacing),
          Text(permitDetailsModel.data.tab1.details,
              style: Theme.of(context).textTheme.small),
          const SizedBox(height: tinySpacing),
          Text(DatabaseUtil.getText('Location'),
              style: Theme.of(context).textTheme.medium.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: xxTinierSpacing),
          Text(permitDetailsModel.data.tab1.location,
              style: Theme.of(context).textTheme.small),
          const SizedBox(height: xxTinierSpacing),
          ListView.separated(
              itemCount: permitDetailsModel.data.tab1.maplinks.length,
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return const SizedBox(height: xxTinierSpacing);
              },
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      launchUrlString(
                          permitDetailsModel.data.tab1.maplinks[index].link,
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
                                "${permitDetailsModel.data.tab1.maplinks[index].name} : ",
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                  text: permitDetailsModel
                                      .data.tab1.maplinks[index].link,
                                  style: Theme.of(context)
                                      .textTheme
                                      .xSmall
                                      .copyWith(
                                        color: AppColor.deepBlue,
                                      ))
                            ]),
                        textScaler: const TextScaler.linear(1)));
              }),
          const SizedBox(height: tinySpacing),
          Text(DatabaseUtil.getText('Company'),
              style: Theme.of(context).textTheme.medium.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: xxTinierSpacing),
          Text(permitDetailsModel.data.tab1.pcompany,
              style: Theme.of(context).textTheme.small)
        ]));
  }
}
