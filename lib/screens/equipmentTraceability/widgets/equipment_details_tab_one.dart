import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/equipmentTraceability/fetch_search_equipment_details_model.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';

class EquipmentDetailsTabOne extends StatelessWidget {
  final int tabIndex;
  final SearchEquipmentDetailsData data;

  const EquipmentDetailsTabOne(
      {super.key, required this.tabIndex, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: leftRightMargin, right: leftRightMargin, top: xxTinierSpacing),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(StringConstants.kEquipmentName,
                style: Theme.of(context).textTheme.xSmall.copyWith(
                    color: AppColor.black, fontWeight: FontWeight.bold)),
            const SizedBox(height: tiniestSpacing),
            Text(data.equipmentname,
                style: Theme.of(context).textTheme.smallTextGrey),
            const SizedBox(height: xxxSmallestSpacing),
            Text(StringConstants.kEquipmentNo,
                style: Theme.of(context).textTheme.xSmall.copyWith(
                    color: AppColor.black, fontWeight: FontWeight.bold)),
            const SizedBox(height: tiniestSpacing),
            Text(data.equipmentno,
                style: Theme.of(context).textTheme.smallTextGrey),
            const SizedBox(height: xxxSmallestSpacing),
            Text(StringConstants.kArticleNo,
                style: Theme.of(context).textTheme.xSmall.copyWith(
                    color: AppColor.black, fontWeight: FontWeight.bold)),
            const SizedBox(height: tiniestSpacing),
            Text(data.articleno,
                style: Theme.of(context).textTheme.smallTextGrey),
            const SizedBox(height: xxxSmallestSpacing),
            Text(StringConstants.kEmailAddress,
                style: Theme.of(context).textTheme.xSmall.copyWith(
                    color: AppColor.black, fontWeight: FontWeight.bold)),
            const SizedBox(height: tiniestSpacing),
            Text(data.emailAddress,
                style: Theme.of(context).textTheme.smallTextGrey),
            const SizedBox(height: xxxSmallestSpacing),
            Text(StringConstants.kEquipmentCode,
                style: Theme.of(context).textTheme.xSmall.copyWith(
                    color: AppColor.black, fontWeight: FontWeight.bold)),
            const SizedBox(height: tiniestSpacing),
            Text(data.barcode,
                style: Theme.of(context).textTheme.smallTextGrey),
            const SizedBox(height: xxxSmallestSpacing),
            Text(StringConstants.kPosition,
                style: Theme.of(context).textTheme.xSmall.copyWith(
                    color: AppColor.black, fontWeight: FontWeight.bold)),
            const SizedBox(height: tiniestSpacing),
            Text('${data.positionname} ${data.warehousename}',
                style: Theme.of(context).textTheme.smallTextGrey),
            const SizedBox(height: xxxSmallestSpacing),
            Text(StringConstants.kTechnicalPositionNo,
                style: Theme.of(context).textTheme.xSmall.copyWith(
                    color: AppColor.black, fontWeight: FontWeight.bold)),
            const SizedBox(height: tiniestSpacing),
            Text(data.techPositionno,
                style: Theme.of(context).textTheme.smallTextGrey),
            const SizedBox(height: xxxSmallestSpacing),
            Text(StringConstants.kTechnicalPositionName,
                style: Theme.of(context).textTheme.xSmall.copyWith(
                    color: AppColor.black, fontWeight: FontWeight.bold)),
            const SizedBox(height: tiniestSpacing),
            Text(data.techPositionname,
                style: Theme.of(context).textTheme.smallTextGrey),
            const SizedBox(height: xxxSmallestSpacing),
            Text(StringConstants.kEquipmentRole,
                style: Theme.of(context).textTheme.xSmall.copyWith(
                    color: AppColor.black, fontWeight: FontWeight.bold)),
            const SizedBox(height: tiniestSpacing),
            Text(data.rolename,
                style: Theme.of(context).textTheme.smallTextGrey),
            const SizedBox(height: xxxSmallestSpacing),
            Text(StringConstants.kEquipmentType,
                style: Theme.of(context).textTheme.xSmall.copyWith(
                    color: AppColor.black, fontWeight: FontWeight.bold)),
            const SizedBox(height: tiniestSpacing),
            Text(data.machinetype,
                style: Theme.of(context).textTheme.smallTextGrey),
            const SizedBox(height: xxxSmallestSpacing),
            Text(StringConstants.kEquipmentSubType,
                style: Theme.of(context).textTheme.xSmall.copyWith(
                    color: AppColor.black, fontWeight: FontWeight.bold)),
            const SizedBox(height: tiniestSpacing),
            Text(data.subtypetext,
                style: Theme.of(context).textTheme.smallTextGrey),
            const SizedBox(height: xxxSmallestSpacing),
            Text(StringConstants.kDescription,
                style: Theme.of(context).textTheme.xSmall.copyWith(
                    color: AppColor.black, fontWeight: FontWeight.bold)),
            const SizedBox(height: tiniestSpacing),
            Text(data.description,
                style: Theme.of(context).textTheme.smallTextGrey),
            const SizedBox(height: xxxSmallestSpacing),
          ],
        ),
      ),
    );
  }
}
