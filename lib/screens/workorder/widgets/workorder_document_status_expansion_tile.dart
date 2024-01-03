import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/enums/workorder_document_status_enum.dart';
import '../workorder_assign_document_screen.dart';

class WorkOrderDocumentStatusExpansionTile extends StatelessWidget {
  const WorkOrderDocumentStatusExpansionTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<WorkOrderTabDetailsBloc>().add(
        SelectWorkOrderDocumentStatusOption(
            statusId:
                WorkOrderAssignDocumentScreen.documentFilterMap['status'] ?? '',
            statusOption: WorkOrderAssignDocumentScreen
                        .documentFilterMap['status'] !=
                    null
                ? WorkOrderAssignDocumentScreen
                    .documentFilterMap['statusOption']
                : ''));
    return BlocBuilder<WorkOrderTabDetailsBloc, WorkOrderTabDetailsStates>(
        buildWhen: (previousState, currentState) =>
            currentState is WorkOrderDocumentStatusSelected,
        builder: (context, state) {
          if (state is WorkOrderDocumentStatusSelected) {
            WorkOrderAssignDocumentScreen.documentFilterMap['statusOption'] =
                state.statusOption;
            return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: AppColor.transparent),
                child: ExpansionTile(
                    collapsedShape: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: AppColor.grey,
                      width: kExpansionBorderWidth,
                    )),
                    collapsedBackgroundColor: AppColor.white,
                    backgroundColor: AppColor.white,
                    shape: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: AppColor.grey,
                      width: kExpansionBorderWidth,
                    )),
                    key: GlobalKey(),
                    title: Text(
                        state.statusOption.isEmpty
                            ? StringConstants.kSelect
                            : state.statusOption,
                        style: Theme.of(context).textTheme.xSmall),
                    children: [
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: WorkOrderStatusEnum.values.length,
                          itemBuilder: (BuildContext context, int index) {
                            return RadioListTile(
                                contentPadding: EdgeInsets.zero,
                                activeColor: AppColor.deepBlue,
                                value: WorkOrderStatusEnum.values
                                    .elementAt(index)
                                    .value,
                                groupValue: state.statusId,
                                title: Text(WorkOrderStatusEnum.values
                                    .elementAt(index)
                                    .status),
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                onChanged: (val) {
                                  WorkOrderAssignDocumentScreen
                                          .documentFilterMap['status'] =
                                      WorkOrderStatusEnum.values
                                          .elementAt(index)
                                          .value;
                                  context.read<WorkOrderTabDetailsBloc>().add(
                                      SelectWorkOrderDocumentStatusOption(
                                          statusId: WorkOrderStatusEnum.values
                                              .elementAt(index)
                                              .value,
                                          statusOption: WorkOrderStatusEnum
                                              .values
                                              .elementAt(index)
                                              .status));
                                });
                          })
                    ]));
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
