import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_states.dart';
import 'package:toolkit/widgets/error_section.dart';

import '../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/generic_app_bar.dart';
import 'widgets/workorder_add_and_edit_down_time_body.dart';
import 'widgets/workorder_downtime_save_button.dart';

class WorkOrderAddAndEditDownTimeScreen extends StatelessWidget {
  static const routeName = 'WorkOrderAddAndEditDownTimeScreen';
  static Map addAndEditDownTimeMap = {};

  const WorkOrderAddAndEditDownTimeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<WorkOrderTabDetailsBloc>().add(FetchWorkOrderSingleDownTime(
        downTimeId: addAndEditDownTimeMap['downTimeId']));
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('ScheduleDowntime')),
        bottomNavigationBar: const WorkOrderDownTimeSaveButton(),
        body: BlocBuilder<WorkOrderTabDetailsBloc, WorkOrderTabDetailsStates>(
            buildWhen: (previousState, currentState) =>
                currentState is FetchingWorkOrderSingleDownTime ||
                currentState is WorkOrderSingleDownTimeFetched ||
                currentState is WorkOrderSingleDownTimeNotFetched,
            builder: (context, state) {
              if (state is FetchingWorkOrderSingleDownTime) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is WorkOrderSingleDownTimeFetched) {
                return const WorkOrderAddAndEditDownTimeBody();
              } else if (state is WorkOrderSingleDownTimeNotFetched) {
                return GenericReloadButton(
                    onPressed: () {
                      context
                          .read<WorkOrderTabDetailsBloc>()
                          .add(FetchWorkOrderSingleDownTime(downTimeId: ''));
                    },
                    textValue: StringConstants.kReload);
              } else {
                return const SizedBox.shrink();
              }
            }));
  }
}
