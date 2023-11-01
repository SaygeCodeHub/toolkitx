import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/workorder/widgets/workorder_assign_workforce_card.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_states.dart';
import '../../../blocs/workorder/workorder_bloc.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/error_section.dart';
import '../../../widgets/generic_no_records_text.dart';
import '../assign_workforce_screen.dart';

class AssignWorkForceBody extends StatelessWidget {
  const AssignWorkForceBody({Key? key}) : super(key: key);
  static Map assignWorkForceMap = {};

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkOrderTabDetailsBloc, WorkOrderTabDetailsStates>(
        buildWhen: (previousState, currentState) =>
            (currentState is FetchingAssignWorkOrder &&
                AssignWorkForceScreen.pageNo == 1 &&
                context
                    .read<WorkOrderTabDetailsBloc>()
                    .assignWorkForceDatum
                    .isEmpty) ||
            currentState is AssignWorkOrderFetched ||
            currentState is AssignWorkOrderNotFetched ||
            currentState is WorkOrderAssignWorkforceSearched,
        listener: (context, state) {
          if (state is AssignWorkOrderFetched) {
            if (state.fetchAssignWorkForceModel.status == 204 &&
                context
                    .read<WorkOrderTabDetailsBloc>()
                    .assignWorkForceDatum
                    .isNotEmpty) {
              showCustomSnackBar(context, StringConstants.kAllDataLoaded, '');
            }
          }
        },
        builder: (context, state) {
          if (state is FetchingAssignWorkOrder) {
            return const Expanded(
                child: Center(child: CircularProgressIndicator()));
          } else if (state is AssignWorkOrderFetched) {
            if (context
                .read<WorkOrderTabDetailsBloc>()
                .assignWorkForceDatum
                .isNotEmpty) {
              return Expanded(
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: context
                                  .read<WorkOrderTabDetailsBloc>()
                                  .assignWorkForceListReachedMax ==
                              true
                          ? context
                              .read<WorkOrderTabDetailsBloc>()
                              .assignWorkForceDatum
                              .length
                          : context
                                  .read<WorkOrderTabDetailsBloc>()
                                  .assignWorkForceDatum
                                  .length +
                              1,
                      itemBuilder: (context, index) {
                        if (index <
                            context
                                .read<WorkOrderTabDetailsBloc>()
                                .assignWorkForceDatum
                                .length) {
                          return WorkOrderAssignWorkforceCard(
                              index: index,
                              assignWorkForceDatum: context
                                  .read<WorkOrderTabDetailsBloc>()
                                  .assignWorkForceDatum[index]);
                        } else if (!context
                            .read<WorkOrderTabDetailsBloc>()
                            .assignWorkForceListReachedMax) {
                          AssignWorkForceScreen.pageNo++;
                          context.read<WorkOrderTabDetailsBloc>().add(
                              (FetchAssignWorkForceList(
                                  pageNo: AssignWorkForceScreen.pageNo,
                                  workOrderWorkforceName: '',
                                  workOrderId: context
                                      .read<WorkOrderBloc>()
                                      .workOrderId)));
                          return const Center(
                              child: Padding(
                                  padding: EdgeInsets.all(
                                      kCircularProgressIndicatorPadding),
                                  child: SizedBox(
                                      width: kCircularProgressIndicatorWidth,
                                      child: CircularProgressIndicator())));
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: xxTinierSpacing);
                      }));
            } else if (state.fetchAssignWorkForceModel.status == 204 &&
                context
                    .read<WorkOrderTabDetailsBloc>()
                    .assignWorkForceDatum
                    .isEmpty) {
              return NoRecordsText(
                  text: DatabaseUtil.getText('no_records_found'));
            } else {
              return const SizedBox.shrink();
            }
          } else if (state is AssignWorkOrderNotFetched) {
            return GenericReloadButton(
                onPressed: () {
                  context.read<WorkOrderTabDetailsBloc>().add(
                      FetchAssignWorkForceList(
                          pageNo: AssignWorkForceScreen.pageNo,
                          workOrderWorkforceName: '',
                          workOrderId:
                              context.read<WorkOrderBloc>().workOrderId));
                },
                textValue: StringConstants.kReload);
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
