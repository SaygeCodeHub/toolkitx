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
  const WorkOrderDocumentTypeList({Key? key}) : super(key: key);

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
                        itemCount:
                            WorkOrderAddDocumentScreen.documentDataList.length,
                        itemBuilder: (context, index) {
                          return RadioListTile(
                              contentPadding: EdgeInsets.zero,
                              activeColor: AppColor.deepBlue,
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Text(WorkOrderAddDocumentScreen
                                  .documentDataList[index].doctypename),
                              value: WorkOrderAddDocumentScreen
                                  .documentDataList[index].docid,
                              groupValue: context
                                  .read<WorkOrderTabDetailsBloc>()
                                  .docTypeId,
                              onChanged: (value) {
                                WorkOrderAddDocumentScreen
                                        .documentFilterMap['type'] =
                                    WorkOrderAddDocumentScreen
                                        .documentDataList[index].docid;
                                WorkOrderAddDocumentScreen
                                        .documentFilterMap['typeName'] =
                                    WorkOrderAddDocumentScreen
                                        .documentDataList[index].doctypename;
                                context.read<WorkOrderTabDetailsBloc>().add(
                                    SelectWorkOrderDocumentType(
                                        docTypeId: WorkOrderAddDocumentScreen
                                            .documentDataList[index].docid,
                                        docTypeName: WorkOrderAddDocumentScreen
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
