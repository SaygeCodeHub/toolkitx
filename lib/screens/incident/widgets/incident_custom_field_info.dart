import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/custom_card.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/incident/incident_details_model.dart';
import '../../../utils/constants/string_constants.dart';

class IncidentCustomFieldInfo extends StatelessWidget {
  final IncidentDetailsModel incidentDetailsModel;
  final int initialIndex;

  const IncidentCustomFieldInfo(
      {Key? key,
      required this.incidentDetailsModel,
      required this.initialIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (incidentDetailsModel.data!.customfields!.isEmpty)
        ? Center(
            child: Text(StringConstants.kNoCustomFields,
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w700, color: AppColor.mediumBlack)))
        : ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: incidentDetailsModel.data!.customfields!.length,
            itemBuilder: (context, index) {
              return CustomCard(
                child: ListTile(
                    contentPadding: const EdgeInsets.only(
                        left: tinierSpacing,
                        right: tinierSpacing,
                        top: tiniestSpacing,
                        bottom: tiniestSpacing),
                    title: Text(
                        incidentDetailsModel.data!.customfields![index].title,
                        style: Theme.of(context).textTheme.small.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColor.mediumBlack)),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: xxTinierSpacing),
                      child: Text(
                          (incidentDetailsModel
                                      .data!.customfields![index].fieldvalue
                                      .toString() ==
                                  "null")
                              ? ''
                              : incidentDetailsModel
                                  .data!.customfields![index].fieldvalue!,
                          style: Theme.of(context).textTheme.xSmall),
                    )),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: xxTinierSpacing);
            });
  }
}
