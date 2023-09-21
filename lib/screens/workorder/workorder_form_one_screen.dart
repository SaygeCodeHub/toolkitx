import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workorder_bloc.dart';
import 'package:toolkit/blocs/workorder/workorder_events.dart';
import 'package:toolkit/blocs/workorder/workorder_states.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/error_section.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'widgets/workorder_form_one_body.dart';
import 'widgets/workorder_form_one_screen_button.dart';

class WorkOrderFormScreenOne extends StatelessWidget {
  static const routeName = 'CreateSimilarWorkOrderScreen';
  final Map workOrderDetailsMap;
  static bool isSimilarWorkOrder = false;

  const WorkOrderFormScreenOne({Key? key, required this.workOrderDetailsMap})
      : super(key: key);
  static List workOrderMasterData = [];

  @override
  Widget build(BuildContext context) {
    isSimilarWorkOrder == false
        ? workOrderDetailsMap.clear()
        : workOrderDetailsMap;
    context.read<WorkOrderBloc>().add(FetchWorkOrderMaster());
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('NewWorkOrder')),
        bottomNavigationBar:
            WorkOrderFormOneButton(workOrderDetailsMap: workOrderDetailsMap),
        body: BlocBuilder<WorkOrderBloc, WorkOrderStates>(
          builder: (context, state) {
            if (state is FetchingWorkOrderMaster) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WorkOrderMasterFetched) {
              workOrderMasterData = state.fetchWorkOrdersMasterModel.data;
              return WorkOrderFormOneBody(
                  data: state.fetchWorkOrdersMasterModel.data,
                  workOrderDetailsMap: workOrderDetailsMap);
            } else if (state is WorkOrderMasterNotFetched) {
              return GenericReloadButton(
                  onPressed: () {
                    context.read<WorkOrderBloc>().add(FetchWorkOrderMaster());
                  },
                  textValue: StringConstants.kReload);
            } else {
              return const SizedBox.shrink();
            }
          },
        ));
  }
}
