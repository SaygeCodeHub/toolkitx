import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import 'package:toolkit/screens/workorder/workorder_list_screen.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_states.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';

class WorkOrderRoleScreen extends StatelessWidget {
  static const routeName = 'WorkOrderRoleScreen';

  const WorkOrderRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<WorkOrderTabDetailsBloc>().add(FetchWorkOrderRoles());
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('ChangeRole')),
        body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxTinierSpacing,
              bottom: xxTinierSpacing),
          child:
              BlocConsumer<WorkOrderTabDetailsBloc, WorkOrderTabDetailsStates>(
            buildWhen: (previousState, currentState) =>
                currentState is WorkOrderRolesFetching ||
                currentState is WorkOrderRolesFetched,
            listener: (context, state) {
              if (state is WorkOrderRoleSelected) {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(
                    context, WorkOrderListScreen.routeName,
                    arguments: false);
              }
            },
            builder: (context, state) {
              if (state is WorkOrderRolesFetching) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is WorkOrderRolesFetched) {
                return ListView.builder(
                    itemCount: state.fetchWorkOrderRolesModel.data.length,
                    itemBuilder: (context, index) {
                      return RadioListTile(
                          dense: true,
                          activeColor: AppColor.deepBlue,
                          controlAffinity: ListTileControlAffinity.trailing,
                          title: Text(state
                              .fetchWorkOrderRolesModel.data[index].groupName),
                          value: state
                              .fetchWorkOrderRolesModel.data[index].groupId,
                          groupValue: state.role,
                          onChanged: (value) {
                            context
                                .read<WorkOrderTabDetailsBloc>()
                                .add(SelectWorkOrderRole(roleId: value!));
                          });
                    });
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ));
  }
}
