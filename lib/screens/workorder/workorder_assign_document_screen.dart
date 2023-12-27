import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_states.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/error_section.dart';

import '../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_icon_button_row.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/generic_no_records_text.dart';
import 'widgets/workorder_assign_document_body.dart';
import 'widgets/workorder_assign_documents_bottom_app_bar.dart';
import 'workorder_document_filter_screen.dart';

class WorkOrderAssignDocumentScreen extends StatelessWidget {
  static const routeName = 'WorkOrderAddDocumentScreen';
  static Map documentFilterMap = {};
  static List documentDataList = [];
  static Map workOrderDocumentMap = {};

  const WorkOrderAssignDocumentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<WorkOrderTabDetailsBloc>().add(FetchWorkOrderDocuments());
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('AssignDocuments')),
      bottomNavigationBar: const WorkOrderAssignDocumentsBottomAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin, right: leftRightMargin),
        child: Column(
          children: [
            BlocBuilder<WorkOrderTabDetailsBloc, WorkOrderTabDetailsStates>(
                buildWhen: (previousState, currentState) =>
                    currentState is WorkOrderDocumentsFetched,
                builder: (context, state) {
                  if (state is WorkOrderDocumentsFetched) {
                    return CustomIconButtonRow(
                        secondaryVisible: false,
                        clearVisible: WorkOrderAssignDocumentScreen
                            .documentFilterMap.isNotEmpty,
                        primaryOnPress: () {
                          Navigator.pushNamed(
                              context, WorkOrderDocumentFilterScreen.routeName);
                        },
                        secondaryOnPress: () {},
                        clearOnPress: () {
                          context
                              .read<WorkOrderTabDetailsBloc>()
                              .add(ClearWorkOrderDocumentFilter());
                          context
                              .read<WorkOrderTabDetailsBloc>()
                              .add(FetchWorkOrderDocuments());
                        });
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
            BlocBuilder<WorkOrderTabDetailsBloc, WorkOrderTabDetailsStates>(
                buildWhen: (previousState, currentState) =>
                    currentState is FetchingWorkOrderDocuments ||
                    currentState is WorkOrderDocumentsFetched,
                builder: (context, state) {
                  if (state is FetchingWorkOrderDocuments) {
                    return Center(
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 3.5),
                          child: const CircularProgressIndicator()),
                    );
                  } else if (state is WorkOrderDocumentsFetched) {
                    if (state.fetchWorkOrderDocumentsModel.data.isNotEmpty) {
                      documentDataList
                          .addAll(state.fetchWorkOrderDocumentsModel.data);
                      documentFilterMap.addAll(state.filterMap);
                      workOrderDocumentMap['documents'] = state.documentList
                          .toString()
                          .replaceAll("[", "")
                          .replaceAll("]", "");
                      return WorkOrderAssignDocumentBody(
                          fetchWorkOrderDocumentsModel:
                              state.fetchWorkOrderDocumentsModel);
                    } else {
                      if (state.fetchWorkOrderDocumentsModel.status == 204) {
                        if (state.filterMap.isEmpty) {
                          return const NoRecordsText(
                              text: StringConstants.kNoRecordsFilter);
                        } else {
                          return NoRecordsText(
                              text: DatabaseUtil.getText('no_records_found'));
                        }
                      } else {
                        return const SizedBox();
                      }
                    }
                  } else if (state is WorkOrderDocumentsNotFetched) {
                    return GenericReloadButton(
                        onPressed: () {
                          context
                              .read<WorkOrderTabDetailsBloc>()
                              .add(FetchWorkOrderDocuments());
                        },
                        textValue: StringConstants.kReload);
                  } else {
                    return const SizedBox.shrink();
                  }
                })
          ],
        ),
      ),
    );
  }
}
