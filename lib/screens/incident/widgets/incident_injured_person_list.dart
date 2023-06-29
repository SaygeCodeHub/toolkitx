import 'dart:math';

import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/incident/incident_details_model.dart';
import 'package:toolkit/utils/incident_util.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_card.dart';

class IncidentInjuredPersonList extends StatelessWidget {
  final IncidentDetailsModel incidentDetailsModel;

  const IncidentInjuredPersonList(
      {Key? key, required this.incidentDetailsModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (incidentDetailsModel.data!.injuredpersonlist!.isEmpty)
        ? Center(
            child: Text(StringConstants.kNoInjuredPerson,
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w700, color: AppColor.mediumBlack)))
        : ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: incidentDetailsModel.data!.injuredpersonlist!.length,
            itemBuilder: (context, index) {
              final random = Random();
              final leadingAvatarIcon = IncidentUtil().leadingAvatarList[
                  random.nextInt(IncidentUtil().leadingAvatarList.length)];
              return CustomCard(
                child: ListTile(
                  contentPadding: const EdgeInsets.only(
                      left: tinier,
                      right: tinier,
                      top: tiniest,
                      bottom: tiniest),
                  trailing: Image.asset(
                    leadingAvatarIcon,
                  ),
                  title: Text(
                      incidentDetailsModel.data!.injuredpersonlist![index].name,
                      style: Theme.of(context).textTheme.small.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColor.mediumBlack)),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: xxTinierSpacing);
            },
          );
  }
}
