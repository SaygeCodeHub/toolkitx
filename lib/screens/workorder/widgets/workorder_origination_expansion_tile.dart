import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';

class WorkOrderOriginationExpansionTile extends StatelessWidget {
  final List data;
  final Map workOrderDetailsMap;

  const WorkOrderOriginationExpansionTile(
      {super.key, required this.data, required this.workOrderDetailsMap});

  @override
  Widget build(BuildContext context) {
    context.read<WorkOrderTabDetailsBloc>().add(
        SelectWorkOrderOriginationOptions(
            originationId: workOrderDetailsMap['originationid'] ?? '',
            originationName: workOrderDetailsMap['origination'] ?? ''));
    return BlocBuilder<WorkOrderTabDetailsBloc, WorkOrderTabDetailsStates>(
        buildWhen: (previousState, currentState) =>
            currentState is WorkOrderCategoryOriginationSelected,
        builder: (context, state) {
          if (state is WorkOrderCategoryOriginationSelected) {
            workOrderDetailsMap['originationid'] = state.originationId;
            return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: AppColor.transparent),
                child: ExpansionTile(
                    maintainState: true,
                    key: GlobalKey(),
                    title: Text(
                        (state.originationName.isEmpty)
                            ? StringConstants.kSelectOrigination
                            : state.originationName,
                        style: Theme.of(context).textTheme.xSmall),
                    children: [
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data[4].length,
                          itemBuilder: (BuildContext context, int index) {
                            return RadioListTile(
                                contentPadding: const EdgeInsets.only(
                                    left: xxxTinierSpacing),
                                activeColor: AppColor.deepBlue,
                                title: Text(data[4][index].origination,
                                    style: Theme.of(context).textTheme.xSmall),
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                value: data[4][index].id.toString(),
                                groupValue: state.originationId,
                                onChanged: (value) {
                                  context.read<WorkOrderTabDetailsBloc>().add(
                                      SelectWorkOrderOriginationOptions(
                                          originationId:
                                              data[4][index].id.toString(),
                                          originationName:
                                              data[4][index].origination));
                                });
                          })
                    ]));
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
