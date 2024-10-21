import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/generic_app_bar.dart';
import '../workorder_assign_document_screen.dart';

class WorkOrderDocumentTypeList extends StatelessWidget {
  const WorkOrderDocumentTypeList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kSelectType),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.only(
                  left: leftRightMargin, right: leftRightMargin),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: WorkOrderAssignDocumentScreen
                            .documentDataList.length,
                        itemBuilder: (context, index) {
                          return RadioListTile(
                              contentPadding: EdgeInsets.zero,
                              activeColor: AppColor.deepBlue,
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Text(WorkOrderAssignDocumentScreen
                                  .documentDataList[index].doctypename),
                              value: WorkOrderAssignDocumentScreen
                                  .documentDataList[index].docid,
                              groupValue: context
                                  .read<WorkOrderTabDetailsBloc>()
                                  .docTypeId,
                              onChanged: (value) {
                                WorkOrderAssignDocumentScreen
                                        .documentFilterMap['type'] =
                                    WorkOrderAssignDocumentScreen
                                        .documentDataList[index].docid;
                                WorkOrderAssignDocumentScreen
                                        .documentFilterMap['typeName'] =
                                    WorkOrderAssignDocumentScreen
                                        .documentDataList[index].doctypename;
                                context.read<WorkOrderTabDetailsBloc>().add(
                                    SelectWorkOrderDocumentType(
                                        docTypeId: WorkOrderAssignDocumentScreen
                                            .documentDataList[index].docid,
                                        docTypeName:
                                            WorkOrderAssignDocumentScreen
                                                .documentDataList[index]
                                                .doctypename));
                                Navigator.pop(context);
                              });
                        }),
                    const SizedBox(height: xxxSmallerSpacing)
                  ])),
        ));
  }
}
