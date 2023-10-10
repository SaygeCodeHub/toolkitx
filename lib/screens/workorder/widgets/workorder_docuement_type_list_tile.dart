import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';
import '../workorder_assign_document_screen.dart';
import 'workorder_document_type_list.dart';

class WorkOrderDocumentTypeListTile extends StatelessWidget {
  const WorkOrderDocumentTypeListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<WorkOrderTabDetailsBloc>().add(SelectWorkOrderDocumentType(
        docTypeId:
            WorkOrderAssignDocumentScreen.documentFilterMap['type'] ?? '',
        docTypeName:
            WorkOrderAssignDocumentScreen.documentFilterMap['type'] != null
                ? WorkOrderAssignDocumentScreen.documentFilterMap['typeName']
                : ''));
    return BlocBuilder<WorkOrderTabDetailsBloc, WorkOrderTabDetailsStates>(
        buildWhen: (previousState, currentState) =>
            currentState is WorkOrderDocumentTypeSelected,
        builder: (context, state) {
          if (state is WorkOrderDocumentTypeSelected) {
            WorkOrderAssignDocumentScreen.documentFilterMap['typeName'] =
                state.docTypeName;
            return ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const WorkOrderDocumentTypeList()));
                },
                title: Text(DatabaseUtil.getText('type'),
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(fontWeight: FontWeight.w600)),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: xxxTinierSpacing),
                  child: Text(state.docTypeName,
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(color: AppColor.black)),
                ),
                trailing:
                    const Icon(Icons.navigate_next_rounded, size: kIconSize));
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
