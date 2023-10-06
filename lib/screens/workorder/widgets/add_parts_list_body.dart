import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import 'package:toolkit/screens/workorder/widgets/workorder_add_parts_card.dart';
import 'package:toolkit/screens/workorder/widgets/workorder_add_parts_screen.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_states.dart';
import '../../../blocs/workorder/workorder_bloc.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/generic_no_records_text.dart';

class AddPartsListBody extends StatelessWidget {
  static bool isFirst = true;

  const AddPartsListBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkOrderTabDetailsBloc, WorkOrderTabDetailsStates>(
        buildWhen: (previousState, currentState) =>
            (currentState is FetchingAssignParts &&
                WorkOrderAddPartsScreen.pageNo == 1 &&
                context
                    .read<WorkOrderTabDetailsBloc>()
                    .addPartsDatum
                    .isEmpty) ||
            currentState is AssignPartsFetched ||
            currentState is AssignPartsNotFetched ||
            currentState is WorkOrderAddPartsListSearched,
        listener: (context, state) {
          if (state is AssignPartsFetched) {
            if (state.fetchAssignPartsModel.status == 204 &&
                context
                    .read<WorkOrderTabDetailsBloc>()
                    .addPartsDatum
                    .isNotEmpty) {
              showCustomSnackBar(context, StringConstants.kAllDataLoaded, '');
            }
          }
        },
        builder: (context, state) {
          if (state is FetchingAssignParts) {
            return const Expanded(
                child: Center(child: CircularProgressIndicator()));
          } else if (state is AssignPartsFetched) {
            isFirst = false;
            if (context
                .read<WorkOrderTabDetailsBloc>()
                .addPartsDatum
                .isNotEmpty) {
              return Expanded(
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: context
                                  .read<WorkOrderTabDetailsBloc>()
                                  .docListReachedMax ==
                              true
                          ? context
                              .read<WorkOrderTabDetailsBloc>()
                              .addPartsDatum
                              .length
                          : context
                                  .read<WorkOrderTabDetailsBloc>()
                                  .addPartsDatum
                                  .length +
                              1,
                      itemBuilder: (context, index) {
                        if (index <
                            context
                                .read<WorkOrderTabDetailsBloc>()
                                .addPartsDatum
                                .length) {
                          return WorkOrderAddPartsCard(
                            addPartsDatum: context
                                .read<WorkOrderTabDetailsBloc>()
                                .addPartsDatum[index],
                          );
                        } else if (!context
                            .read<WorkOrderTabDetailsBloc>()
                            .docListReachedMax) {
                          WorkOrderAddPartsScreen.pageNo++;
                          context.read<WorkOrderTabDetailsBloc>().add(
                              FetchAssignPartsList(
                                  pageNo: WorkOrderAddPartsScreen.pageNo,
                                  partName: '',
                                  workOrderId: context
                                      .read<WorkOrderBloc>()
                                      .workOrderId));
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
                        return const SizedBox(height: tinierSpacing);
                      }));
            } else if ((state.fetchAssignPartsModel.status == 204 &&
                context
                    .read<WorkOrderTabDetailsBloc>()
                    .addPartsDatum
                    .isEmpty)) {
              return NoRecordsText(
                  text: DatabaseUtil.getText('no_records_found'));
            } else {
              return const SizedBox.shrink();
            }
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
