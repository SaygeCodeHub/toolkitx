import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workorder_bloc.dart';
import 'package:toolkit/blocs/workorder/workorder_events.dart';
import 'package:toolkit/blocs/workorder/workorder_states.dart';
import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_icon_button_row.dart';
import '../../widgets/generic_app_bar.dart';
import 'widgets/workorder_list_body.dart';
import 'workorder_filter_screen.dart';
import 'workorder_form_one_screen.dart';

class WorkOrderListScreen extends StatelessWidget {
  static const routeName = 'WorkOrderListScreen';
  final bool isFromHome;

  WorkOrderListScreen({super.key, this.isFromHome = false});
  static int pageNo = 1;
  final addWorkOrderMap = {};

  @override
  Widget build(BuildContext context) {
    pageNo = 1;
    context.read<WorkOrderBloc>().hasReachedMax = false;
    context.read<WorkOrderBloc>().data.clear();
    context
        .read<WorkOrderBloc>()
        .add(FetchWorkOrders(pageNo: 1, isFromHome: isFromHome));
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('WorkOrder')),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              WorkOrderFormScreenOne.isSimilarWorkOrder = false;
              WorkOrderFormScreenOne.isFromEdit = false;
              Navigator.pushReplacementNamed(
                  context, WorkOrderFormScreenOne.routeName,
                  arguments: addWorkOrderMap);
            },
            child: const Icon(Icons.add)),
        body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxTinierSpacing),
          child: Column(
            children: [
              BlocBuilder<WorkOrderBloc, WorkOrderStates>(
                  buildWhen: (previousState, currentState) {
                if (currentState is FetchingWorkOrders && isFromHome == true) {
                  return true;
                } else if (currentState is WorkOrdersFetched) {
                  return true;
                }
                return false;
              }, builder: (context, state) {
                if (state is WorkOrdersFetched) {
                  return CustomIconButtonRow(
                      secondaryOnPress: () {},
                      primaryOnPress: () {
                        Navigator.pushNamed(
                            context, WorkOrderFilterScreen.routeName);
                      },
                      secondaryVisible: false,
                      isEnabled: true,
                      clearVisible: state.filterMap.isNotEmpty,
                      clearOnPress: () {
                        WorkOrderListScreen.pageNo = 1;
                        context.read<WorkOrderBloc>().data.clear();
                        context.read<WorkOrderBloc>().hasReachedMax = false;
                        WorkOrderFilterScreen.workOrderFilterMap.clear();
                        context
                            .read<WorkOrderBloc>()
                            .add(WorkOrderClearFilter());
                        context.read<WorkOrderBloc>().add(
                            FetchWorkOrders(pageNo: 1, isFromHome: isFromHome));
                      });
                } else {
                  return const SizedBox();
                }
              }),
              const SizedBox(height: xxTinierSpacing),
              const WorkOrderListBody()
            ],
          ),
        ));
  }
}
