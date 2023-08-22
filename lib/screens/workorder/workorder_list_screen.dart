import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workorder_bloc.dart';
import 'package:toolkit/blocs/workorder/workorder_events.dart';
import 'package:toolkit/blocs/workorder/workorder_states.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_icon_button_row.dart';
import '../../widgets/generic_app_bar.dart';
import 'widgets/workorder_list_card.dart';
import 'workorder_filter_screen.dart';

class WorkOrderListScreen extends StatelessWidget {
  static const routeName = 'WorkOrderListScreen';

  const WorkOrderListScreen({Key? key}) : super(key: key);
  static int pageNo = 1;

  @override
  Widget build(BuildContext context) {
    context.read<WorkOrderBloc>().data.clear();
    context.read<WorkOrderBloc>().hasReachedMax = false;
    context.read<WorkOrderBloc>().add(FetchWorkOrders(pageNo: pageNo));
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('WorkOrder')),
        floatingActionButton: FloatingActionButton(
            onPressed: () {}, child: const Icon(Icons.add)),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing),
            child: Column(children: [
              BlocBuilder<WorkOrderBloc, WorkOrderStates>(
                  builder: (context, state) {
                if (state is WorkOrdersFetched) {
                  return CustomIconButtonRow(
                      secondaryOnPress: () {},
                      primaryOnPress: () {
                        Navigator.pushNamed(
                            context, WorkOrderFilterScreen.routeName);
                      },
                      secondaryVisible: false,
                      isEnabled: true,
                      clearVisible: false,
                      clearOnPress: () {});
                } else {
                  return const SizedBox();
                }
              }),
              const SizedBox(height: xxTinierSpacing),
              BlocConsumer<WorkOrderBloc, WorkOrderStates>(
                  buildWhen: (previousState, currentState) =>
                      ((currentState is WorkOrdersFetched) ||
                          (currentState is FetchingWorkOrders && pageNo == 1)),
                  listener: (context, state) {
                    if (state is WorkOrdersFetched) {
                      if (state.fetchWorkOrdersModel.status == 204) {
                        showCustomSnackBar(
                            context, StringConstants.kAllDataLoaded, '');
                        context.read<WorkOrderBloc>().hasReachedMax = true;
                      }
                    }
                  },
                  builder: (context, state) {
                    if (state is FetchingWorkOrders) {
                      return Center(
                          child: Padding(
                              padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height / 3.5),
                              child: const CircularProgressIndicator()));
                    } else if (state is WorkOrdersFetched) {
                      return Expanded(
                          child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.hasReachedMax
                                  ? state.data.length
                                  : state.data.length + 1,
                              itemBuilder: (context, index) {
                                if (index < state.data.length) {
                                  return WorkOrderListCard(
                                      data: state.data[index]);
                                } else if (!state.hasReachedMax) {
                                  pageNo++;
                                  context
                                      .read<WorkOrderBloc>()
                                      .add(FetchWorkOrders(pageNo: pageNo));
                                  return const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(
                                          kCircularProgressIndicatorPadding),
                                      child: SizedBox(
                                          width:
                                              kCircularProgressIndicatorWidth,
                                          child: CircularProgressIndicator()),
                                    ),
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: xxTinySpacing);
                              }));
                    } else {
                      return const SizedBox();
                    }
                  }),
            ])));
  }
}
