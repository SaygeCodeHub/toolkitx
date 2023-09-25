import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/error_section.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';

import '../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../configs/app_spacing.dart';
import 'widgets/assign_workforce_status_tags.dart';

class AssignWorkForceScreen extends StatelessWidget {
  static const routeName = 'AssignWorkForceScreen';

  const AssignWorkForceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<WorkOrderTabDetailsBloc>().add(FetchAssignWorkForceList());
    return Scaffold(
      appBar: GenericAppBar(
        title: DatabaseUtil.getText('assign_workforce'),
      ),
      body: BlocBuilder<WorkOrderTabDetailsBloc, WorkOrderTabDetailsStates>(
          buildWhen: (previousState, currentState) =>
              currentState is FetchingAssignWorkOrder ||
              currentState is AssignWorkOrderFetched ||
              currentState is AssignWorkOrderNotFetched,
          builder: (context, state) {
            if (state is FetchingAssignWorkOrder) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AssignWorkOrderFetched) {
              return Padding(
                padding: const EdgeInsets.only(
                    left: leftRightMargin,
                    right: leftRightMargin,
                    top: xxTinierSpacing),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.fetchAssignWorkForceModel.data.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              contentPadding:
                                  const EdgeInsets.all(tiniestSpacing),
                              title: Text(
                                state
                                    .fetchAssignWorkForceModel.data[index].name,
                                style: Theme.of(context)
                                    .textTheme
                                    .xSmall
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: xxTinierSpacing),
                                  Text(state.fetchAssignWorkForceModel
                                      .data[index].jobTitle),
                                  const SizedBox(height: xxTinierSpacing),
                                  TextFieldWidget(
                                      hintText: DatabaseUtil.getText(
                                          'PlannedWorkingHours'),
                                      onTextFieldChanged:
                                          (String textField) {}),
                                  const SizedBox(height: xxTinierSpacing),
                                  AssignWorkForceStatusTags(
                                      assignWorkForceDatum: state
                                          .fetchAssignWorkForceModel
                                          .data[index])
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: xxTinierSpacing);
                        },
                      )
                    ],
                  ),
                ),
              );
            } else if (state is AssignWorkOrderNotFetched) {
              return GenericReloadButton(
                  onPressed: () {
                    context
                        .read<WorkOrderTabDetailsBloc>()
                        .add(FetchAssignWorkForceList());
                  },
                  textValue: StringConstants.kReload);
            } else {
              return const SizedBox.shrink();
            }
          }),
    );
  }
}
