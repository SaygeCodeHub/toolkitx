import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../../configs/app_color.dart';
import '../../../data/models/workorder/fetch_workorder_documents_model.dart';
import '../workorder_assign_document_screen.dart';

class WorkOrderAssignDocumentBody extends StatelessWidget {
  final FetchWorkOrderDocumentsModel fetchWorkOrderDocumentsModel;

  const WorkOrderAssignDocumentBody(
      {super.key, required this.fetchWorkOrderDocumentsModel});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: WorkOrderAssignDocumentScreen.documentDataList.length,
          itemBuilder: (BuildContext context, int index) {
            return CheckboxListTile(
                checkColor: AppColor.white,
                activeColor: AppColor.deepBlue,
                contentPadding: EdgeInsets.zero,
                value: context
                    .read<WorkOrderTabDetailsBloc>()
                    .documentList
                    .contains(WorkOrderAssignDocumentScreen
                        .documentDataList[index].docid),
                title: Text(
                    WorkOrderAssignDocumentScreen
                        .documentDataList[index].docname,
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(fontWeight: FontWeight.w600)),
                subtitle: Text(WorkOrderAssignDocumentScreen
                    .documentDataList[index].doctypename),
                controlAffinity: ListTileControlAffinity.trailing,
                onChanged: (isChecked) {
                  context.read<WorkOrderTabDetailsBloc>().add(
                      SelectWorkOrderDocument(
                          fetchWorkOrderDocumentsModel:
                              fetchWorkOrderDocumentsModel,
                          docId: WorkOrderAssignDocumentScreen
                              .documentDataList[index].docid,
                          documentList: context
                              .read<WorkOrderTabDetailsBloc>()
                              .documentList));
                });
          }),
    );
  }
}
