import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_states.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/error_section.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../widgets/custom_snackbar.dart';
import 'widgets/assign_workforce_body.dart';

class AssignWorkForceScreen extends StatelessWidget {
  static const routeName = 'AssignWorkForceScreen';
  static int pageNo = 1;

  const AssignWorkForceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    pageNo = 1;
    context
        .read<WorkOrderTabDetailsBloc>()
        .add(FetchAssignWorkForceList(pageNo: pageNo));
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('assign_workforce')),
        body: BlocConsumer<WorkOrderTabDetailsBloc, WorkOrderTabDetailsStates>(
            buildWhen: (previousState, currentState) =>
                ((currentState is AssignWorkOrderFetched) ||
                    (currentState is FetchingAssignWorkOrder && pageNo == 1)) ||
                currentState is AssignWorkOrderNotFetched,
            listener: (context, state) {
              if (state is AssignWorkOrderFetched) {
                if (state.fetchAssignWorkForceModel.status == 204) {
                  showCustomSnackBar(
                      context, StringConstants.kAllDataLoaded, '');
                }
              }
            },
            builder: (context, state) {
              if (state is FetchingAssignWorkOrder) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AssignWorkOrderFetched) {
                if (context
                    .read<WorkOrderTabDetailsBloc>()
                    .assignWorkForceDatum
                    .isNotEmpty) {
                  return AssignWorkForceBody(
                      data: context
                          .read<WorkOrderTabDetailsBloc>()
                          .assignWorkForceDatum);
                } else if (state.fetchAssignWorkForceModel.status == 204 &&
                    context
                        .read<WorkOrderTabDetailsBloc>()
                        .assignWorkForceDatum
                        .isEmpty) {
                  return const Text('All data loaded');
                } else {
                  return const SizedBox.shrink();
                }
              } else if (state is AssignWorkOrderNotFetched) {
                return GenericReloadButton(
                    onPressed: () {
                      context
                          .read<WorkOrderTabDetailsBloc>()
                          .add(FetchAssignWorkForceList(pageNo: pageNo));
                    },
                    textValue: StringConstants.kReload);
              } else {
                return const SizedBox.shrink();
              }
            }));
  }
}
