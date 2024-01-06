
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/workorder/fetch_assign_parts_model.dart';
import 'package:toolkit/widgets/android_pop_up.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/generic_text_field.dart';

class WorkOrderAddPartsCard extends StatelessWidget {
  const WorkOrderAddPartsCard({super.key, required this.addPartsDatum});

  final AddPartsDatum addPartsDatum;
  static Map assignPartMap = {};

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
                        textInputType: TextInputType.number,
                        onTextFieldChanged: (textField) {
                          assignPartMap['quan'] = textField;
                        },
                        hintText: StringConstants.kPlannedQuantity)),
                InkWell(
                  onTap: () {
                    assignPartMap['itemid'] = addPartsDatum.id;
                    if (assignPartMap['quan'] != null) {
                      context.read<WorkOrderTabDetailsBloc>().add(
                          AssignWorkOrderParts(assignPartMap: assignPartMap));
                      assignPartMap['quan'] = null;
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) => AndroidPopUp(
                              titleValue: StringConstants.kAlert,
                              contentValue: StringConstants.kPleaseInsertValidQuantity,
                              onPrimaryButton: () => Navigator.pop(context),isNoVisible:false,textValue: StringConstants.kOk,));
                    }
                  },
                  child: const CustomCard(
                      color: AppColor.blueGrey,
                      shape: CircleBorder(),
                      elevation: kElevation,
                      child: Padding(
                          padding: EdgeInsets.all(xxxTinierSpacing),
                          child: Icon(Icons.add))),
                )
              ])
            ])));
  }
}
