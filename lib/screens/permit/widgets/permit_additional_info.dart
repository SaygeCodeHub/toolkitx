import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/permit/permit_details_model.dart';
import '../../../utils/database_utils.dart';

class PermitAdditionalInfo extends StatelessWidget {
  final PermitDetailsModel permitDetailsModel;

  const PermitAdditionalInfo({Key? key, required this.permitDetailsModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: tinySpacing),
          Text(DatabaseUtil.getText('AdditionalInformation'),
              style: Theme.of(context).textTheme.medium.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: xxTinierSpacing),
          const SizedBox(height: tinySpacing),
          Text(DatabaseUtil.getText('MethodStatement'),
              style: Theme.of(context).textTheme.medium.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          Text(permitDetailsModel.data.tab2.methodStatement,
              style: Theme.of(context).textTheme.small),
          const SizedBox(height: xxTinierSpacing),
          Text(DatabaseUtil.getText('RelevantInfo'),
              style: Theme.of(context).textTheme.medium.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          Text(permitDetailsModel.data.tab2.generalMessage,
              style: Theme.of(context).textTheme.small),
          const SizedBox(height: xxTinierSpacing),
          Text(DatabaseUtil.getText('SpecialWork'),
              style: Theme.of(context).textTheme.medium.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          Text(permitDetailsModel.data.tab2.specialWork,
              style: Theme.of(context).textTheme.small),
          const SizedBox(height: xxTinierSpacing),
          Text(DatabaseUtil.getText('SpecificPPE'),
              style: Theme.of(context).textTheme.medium.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          Text(permitDetailsModel.data.tab2.specialppe,
              style: Theme.of(context).textTheme.small),
          const SizedBox(height: xxTinierSpacing),
          Text(DatabaseUtil.getText('Protectivemeasures'),
              style: Theme.of(context).textTheme.medium.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          Text(permitDetailsModel.data.tab2.protectivemeasures,
              style: Theme.of(context).textTheme.small),
          const SizedBox(height: xxTinierSpacing),
          Text(DatabaseUtil.getText('Layout'),
              style: Theme.of(context).textTheme.medium.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          InkWell(
              onTap: () {
                launchUrlString(permitDetailsModel.data.tab2.layoutLink,
                    mode: LaunchMode.inAppWebView);
              },
              child: Text(permitDetailsModel.data.tab2.layout,
                  style: Theme.of(context)
                      .textTheme
                      .small
                      .copyWith(color: AppColor.deepBlue))),
          const SizedBox(height: xxTinierSpacing),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: permitDetailsModel.data.tab2.customfields.length,
            itemBuilder: (context, index) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(permitDetailsModel.data.tab2.customfields[index].title,
                        style: Theme.of(context).textTheme.medium),
                    Text(
                        permitDetailsModel
                            .data.tab2.customfields[index].fieldvalue,
                        style: Theme.of(context).textTheme.small)
                  ]);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: xxTinierSpacing);
            },
          )
        ]));
  }
}
