import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/qualityManagement/fetch_qm_details_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_card.dart';

class QualityManagementCustomFields extends StatelessWidget {
  final QMDetailsData data;
  final int initialIndex;

  const QualityManagementCustomFields(
      {Key? key, required this.data, required this.initialIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (data.customfields.isEmpty)
        ? Center(
            child: Text(StringConstants.kNoCustomFields,
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w700, color: AppColor.mediumBlack)))
        : ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: data.customfields.length,
            itemBuilder: (context, index) {
              return CustomCard(
                child: ListTile(
                    contentPadding: const EdgeInsets.only(
                        left: tinierSpacing,
                        right: tinierSpacing,
                        top: tiniestSpacing,
                        bottom: tiniestSpacing),
                    title: Text(data.customfields[index].title,
                        style: Theme.of(context).textTheme.small.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColor.mediumBlack)),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: xxTinierSpacing),
                      child: Text(
                          (data.customfields[index].fieldvalue.toString() ==
                                  "null")
                              ? ''
                              : data.customfields[index].fieldvalue,
                          style: Theme.of(context).textTheme.xSmall),
                    )),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: xxTinierSpacing);
            });
  }
}
