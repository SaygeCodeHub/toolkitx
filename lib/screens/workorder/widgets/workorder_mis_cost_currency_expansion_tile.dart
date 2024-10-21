import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/expansion_tile_border.dart';
import '../workorder_add_mis_cost_screen.dart';

class WorkOrderMiscCostCurrencyExpansionTile extends StatelessWidget {
  const WorkOrderMiscCostCurrencyExpansionTile({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<WorkOrderTabDetailsBloc>().add(WorkOrderSelectCurrencyOption(
        currencyName:
            (context.read<WorkOrderTabDetailsBloc>().currencyName.isNotEmpty)
                ? context.read<WorkOrderTabDetailsBloc>().currencyName
                : ''));

    return BlocBuilder<WorkOrderTabDetailsBloc, WorkOrderTabDetailsStates>(
        buildWhen: (previousState, currentState) =>
            currentState is WorkOrderCurrencyOptionSelected,
        builder: (context, state) {
          if (state is WorkOrderCurrencyOptionSelected) {
            return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: AppColor.transparent),
                child: ExpansionTile(
                    collapsedShape:
                        ExpansionTileBorder().buildOutlineInputBorder(),
                    collapsedBackgroundColor: AppColor.white,
                    backgroundColor: AppColor.white,
                    shape: ExpansionTileBorder().buildOutlineInputBorder(),
                    maintainState: true,
                    key: GlobalKey(),
                    title: Text(
                        (context
                                .read<WorkOrderTabDetailsBloc>()
                                .currencyName
                                .isEmpty)
                            ? StringConstants.kSelectCurrency
                            : context
                                .read<WorkOrderTabDetailsBloc>()
                                .currencyName,
                        style: Theme.of(context).textTheme.xSmall),
                    children: [
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: WorkOrderAddMisCostScreen
                              .workOrderMasterDatum[7].length,
                          itemBuilder: (BuildContext context, int index) {
                            return RadioListTile(
                                contentPadding: const EdgeInsets.only(
                                    left: xxxTinierSpacing),
                                activeColor: AppColor.deepBlue,
                                title: Text(
                                    WorkOrderAddMisCostScreen
                                        .workOrderMasterDatum[7][index]
                                        .currency,
                                    style: Theme.of(context).textTheme.xSmall),
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                value: WorkOrderAddMisCostScreen
                                    .workOrderMasterDatum[7][index].currency,
                                groupValue: state.currencyName,
                                toggleable: true,
                                onChanged: (_) {
                                  WorkOrderAddMisCostScreen
                                          .workOrderDetailsMap['currency'] =
                                      WorkOrderAddMisCostScreen
                                          .workOrderMasterDatum[7][index].id
                                          .toString();
                                  context.read<WorkOrderTabDetailsBloc>().add(
                                      WorkOrderSelectCurrencyOption(
                                          currencyName:
                                              WorkOrderAddMisCostScreen
                                                  .workOrderMasterDatum[7]
                                                      [index]
                                                  .currency));
                                });
                          })
                    ]));
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
