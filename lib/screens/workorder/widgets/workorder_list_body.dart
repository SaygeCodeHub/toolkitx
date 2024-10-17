import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/workorder/widgets/workorder_list_card.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../../blocs/workorder/workorder_bloc.dart';
import '../../../blocs/workorder/workorder_events.dart';
import '../../../blocs/workorder/workorder_states.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/generic_no_records_text.dart';
import '../workorder_list_screen.dart';

class WorkOrderListBody extends StatelessWidget {
  const WorkOrderListBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkOrderBloc, WorkOrderStates>(
        buildWhen: (previousState, currentState) =>
            ((currentState is WorkOrdersFetched) ||
                (currentState is FetchingWorkOrders &&
                    WorkOrderListScreen.pageNo == 1)),
        listener: (context, state) {
          if (state is WorkOrdersFetched) {
            if (state.fetchWorkOrdersModel.status == 204) {
              WorkOrderListScreen.pageNo = 1;
              showCustomSnackBar(context, StringConstants.kAllDataLoaded, '');
            }
          }
        },
        builder: (context, state) {
          if (state is FetchingWorkOrders) {
            return Center(
                child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3.5),
                    child: const CircularProgressIndicator()));
          } else if (state is WorkOrdersFetched) {
            if (context.read<WorkOrderBloc>().data.isNotEmpty) {
              return Expanded(
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                          context.read<WorkOrderBloc>().hasReachedMax == true
                              ? context.read<WorkOrderBloc>().data.length
                              : context.read<WorkOrderBloc>().data.length + 1,
                      itemBuilder: (context, index) {
                        if (index < context.read<WorkOrderBloc>().data.length) {
                          return WorkOrderListCard(
                              data: context.read<WorkOrderBloc>().data[index]);
                        } else if (!context
                            .read<WorkOrderBloc>()
                            .hasReachedMax) {
                          WorkOrderListScreen.pageNo++;
                          context.read<WorkOrderBloc>().add(FetchWorkOrders(
                              pageNo: WorkOrderListScreen.pageNo,
                              isFromHome: false));
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(
                                  kCircularProgressIndicatorPadding),
                              child: SizedBox(
                                  width: kCircularProgressIndicatorWidth,
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
            } else if (state.fetchWorkOrdersModel.status == 204 &&
                context.read<WorkOrderBloc>().data.isEmpty) {
              if (state.filterMap.isNotEmpty) {
                return const NoRecordsText(
                    text: StringConstants.kNoRecordsFilter);
              } else {
                return NoRecordsText(
                    text: DatabaseUtil.getText('no_records_found'));
              }
            }
          }
          return const SizedBox.shrink();
        });
  }
}
