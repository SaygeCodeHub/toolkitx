import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workorder_bloc.dart';
import 'package:toolkit/blocs/workorder/workorder_states.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/error_section.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../blocs/workorder/workorder_events.dart';
import 'widgets/workorder_filter_body.dart';

class WorkOrderFilterScreen extends StatelessWidget {
  static const routeName = 'WorkOrderFilterScreen';

  const WorkOrderFilterScreen({Key? key}) : super(key: key);
  static Map workOrderFilterMap = {};
  static bool isFromLocation = false;
  static String expenseId = '';

  @override
  Widget build(BuildContext context) {
    context.read<WorkOrderBloc>().add(FetchWorkOrderMaster());
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('Filters')),
        body: BlocBuilder<WorkOrderBloc, WorkOrderStates>(
            buildWhen: (previousState, currentState) =>
                currentState is FetchingWorkOrderMaster ||
                currentState is WorkOrderMasterFetched ||
                currentState is WorkOrderMasterNotFetched,
            builder: (context, state) {
              if (state is FetchingWorkOrderMaster) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is WorkOrderMasterFetched) {
                workOrderFilterMap = state.filtersMap;
                return WorkOrderFilterBody(
                    workOrderFilterMap: workOrderFilterMap,
                    workOderDatum: state.fetchWorkOrdersMasterModel.data);
              } else if (state is WorkOrderMasterNotFetched) {
                return GenericReloadButton(
                    onPressed: () {
                      context.read<WorkOrderBloc>().add(FetchWorkOrderMaster());
                    },
                    textValue: StringConstants.kReload);
              } else {
                return const SizedBox.shrink();
              }
            }));
  }
}
