import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/workorder/fetch_assign_parts_model.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/generic_text_field.dart';

class WorkOrderAddPartsCard extends StatelessWidget {
  const WorkOrderAddPartsCard({super.key, required this.addPartsDatum});
  final AddPartsDatum addPartsDatum;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        child: Padding(
            padding: const EdgeInsets.only(
                left: xxxTinierSpacing,
                right: xxxTinierSpacing,
                top: xxTinierSpacing,
                bottom: tinierSpacing),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(addPartsDatum.item,
                  style: Theme.of(context).textTheme.xSmall.copyWith(
                      fontWeight: FontWeight.w500, color: AppColor.black)),
              const SizedBox(height: tiniestSpacing),
              Text("${addPartsDatum.type} - ${addPartsDatum.code}",
                  style: Theme.of(context).textTheme.xSmall.copyWith(
                      fontWeight: FontWeight.w500, color: AppColor.grey)),
              const SizedBox(height: tinierSpacing),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                SizedBox(
                    width: xSizedBoxWidth,
                    child: TextFieldWidget(
                        onTextFieldChanged: (textField) {},
                        hintText: StringConstants.kPlannedQuantity)),
                const CustomCard(
                    color: AppColor.blueGrey,
                    shape: CircleBorder(),
                    elevation: kElevation,
                    child: Padding(
                        padding: EdgeInsets.all(xxxTinierSpacing),
                        child: Icon(Icons.add)))
              ])
            ])));
  }
}
