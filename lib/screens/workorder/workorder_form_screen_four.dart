import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';
import '../../utils/workorder_custom_fields_util.dart';
import '../../widgets/generic_app_bar.dart';
import 'workorder_form_one_screen.dart';
import 'widgets/workorder_save_button.dart';

class WorkOrderFormScreenFour extends StatelessWidget {
  static const routeName = 'CreateSimilarWorkOrderScreenFour';
  final Map workOrderDetailsMap;

  const WorkOrderFormScreenFour({super.key, required this.workOrderDetailsMap});
  static List customFieldList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GenericAppBar(
            title: (WorkOrderFormScreenOne.isFromEdit == true)
                ? DatabaseUtil.getText('EditWorkOrder')
                : DatabaseUtil.getText('NewWorkOrder')),
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
                    WorkOrderFormScreenOne.workOrderMasterData[10].length,
                itemBuilder: (context, index) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            WorkOrderFormScreenOne
                                .workOrderMasterData[10][index].title,
                            style: Theme.of(context)
                                .textTheme
                                .xSmall
                                .copyWith(fontWeight: FontWeight.w600)),
                        const SizedBox(height: xxxTinierSpacing),
                        WorkOrderCustomFieldsUtil().customFieldWidget(
                            index,
                            customFieldList,
                            WorkOrderFormScreenOne.workOrderMasterData,
                            workOrderDetailsMap)
                      ]);
                })));
  }
}
