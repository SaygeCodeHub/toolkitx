import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';
import '../../utils/workorder_custom_fields_util.dart';
import '../../widgets/generic_app_bar.dart';
import 'create_similar_work_order_screen_one.dart';
import 'widgets/workorder_save_button.dart';

class CreateSimilarWorkOrderScreenFour extends StatelessWidget {
  static const routeName = 'CreateSimilarWorkOrderScreenFour';
  final Map workOrderDetailsMap;

  const CreateSimilarWorkOrderScreenFour(
      {Key? key, required this.workOrderDetailsMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('NewWorkOrder')),
        bottomNavigationBar:
            WorkOrderSaveButton(workOrderDetailsMap: workOrderDetailsMap),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinySpacing),
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount:
                    CreateSimilarWorkOrderScreen.workOrderMasterData[10].length,
                itemBuilder: (context, index) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            CreateSimilarWorkOrderScreen
                                .workOrderMasterData[10][index].title,
                            style: Theme.of(context)
                                .textTheme
                                .xSmall
                                .copyWith(fontWeight: FontWeight.w600)),
                        const SizedBox(height: xxxTinierSpacing),
                        WorkOrderCustomFieldsUtil().customFieldWidget(
                            index,
                            CreateSimilarWorkOrderScreen.workOrderMasterData,
                            workOrderDetailsMap)
                      ]);
                })));
  }
}
