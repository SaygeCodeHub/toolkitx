import 'dart:math';

import 'package:flutter/material.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/permit/permit_details_model.dart';
import '../../../data/models/status_tag_model.dart';
import '../../../utils/permit_util.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/status_tag.dart';

class PermitGroup extends StatelessWidget {
  final PermitDetailsModel permitDetailsModel;

  const PermitGroup({super.key, required this.permitDetailsModel});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: permitDetailsModel.data.tab3.length,
        itemBuilder: (context, index) {
          final random = Random();
          final leadingAvatarIcon = PermitUtil().leadingAvatarList[
              random.nextInt(PermitUtil().leadingAvatarList.length)];
          return CustomCard(
              child: Padding(
                  padding: const EdgeInsets.only(top: xxTinierSpacing),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ListTile(
                            trailing: Image.asset(leadingAvatarIcon),
                            title:
                                Text(permitDetailsModel.data.tab3[index].name),
                            subtitle: Padding(
                                padding:
                                    const EdgeInsets.only(top: xxTinierSpacing),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(permitDetailsModel
                                          .data.tab3[index].jobTitle),
                                      const SizedBox(height: xxTinierSpacing),
                                      Text(permitDetailsModel
                                          .data.tab3[index].company),
                                      const SizedBox(height: xxTinierSpacing),
                                      StatusTag(tags: [
                                        StatusTagModel(
                                            title: (permitDetailsModel
                                                        .data
                                                        .tab3[index]
                                                        .certificatecode ==
                                                    '0')
                                                ? 'Not Ok'
                                                : 'Valid',
                                            bgColor: (permitDetailsModel
                                                        .data
                                                        .tab3[index]
                                                        .certificatecode ==
                                                    '0')
                                                ? AppColor.errorRed
                                                : (permitDetailsModel
                                                            .data
                                                            .tab3[index]
                                                            .certificatecode ==
                                                        '1')
                                                    ? AppColor.orange
                                                    : AppColor.green),
                                        StatusTagModel(
                                            title: (permitDetailsModel
                                                        .data.tab3[index].id ==
                                                    permitDetailsModel
                                                        .data.tab3[index].npiId)
                                                ? 'NPI'
                                                : (permitDetailsModel.data
                                                            .tab3[index].id ==
                                                        permitDetailsModel.data
                                                            .tab3[index].npwId)
                                                    ? 'NPW'
                                                    : '',
                                            bgColor: AppColor.lightGrey)
                                      ])
                                    ])))
                      ])));
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: xxTinierSpacing);
        });
  }
}
