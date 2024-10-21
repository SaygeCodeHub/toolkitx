import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';

class WorkOrderCompanyExpansionTile extends StatelessWidget {
  final List data;
  final Map workOrderDetailsMap;

  const WorkOrderCompanyExpansionTile(
      {super.key, required this.data, required this.workOrderDetailsMap});

  @override
  Widget build(BuildContext context) {
    context.read<WorkOrderTabDetailsBloc>().add(SelectWorkOrderCategoryOptions(
        categoryId: workOrderDetailsMap['categoryid'] ?? '',
        categoryName: workOrderDetailsMap['category'] ?? ''));
    return BlocBuilder<WorkOrderTabDetailsBloc, WorkOrderTabDetailsStates>(
        buildWhen: (previousState, currentState) =>
            currentState is WorkOrderCategoryOptionSelected,
        builder: (context, state) {
          if (state is WorkOrderCategoryOptionSelected) {
            workOrderDetailsMap['categoryid'] = state.categoryId;
            return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: AppColor.transparent),
                child: ExpansionTile(
                    maintainState: true,
                    key: GlobalKey(),
                    title: Text(
                        (state.categoryName.isEmpty)
                            ? StringConstants.kSelectCategory
                            : state.categoryName,
                        style: Theme.of(context).textTheme.xSmall),
                    children: [
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data[3].length,
                          itemBuilder: (BuildContext context, int index) {
                            return RadioListTile(
                                contentPadding: const EdgeInsets.only(
                                    left: xxxTinierSpacing),
                                activeColor: AppColor.deepBlue,
                                title: Text(data[3][index].category,
                                    style: Theme.of(context).textTheme.xSmall),
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                value: data[3][index].id.toString(),
                                groupValue: state.categoryId,
                                onChanged: (value) {
                                  context.read<WorkOrderTabDetailsBloc>().add(
                                      SelectWorkOrderCategoryOptions(
                                          categoryId:
                                              data[3][index].id.toString(),
                                          categoryName:
                                              data[3][index].category));
                                });
                          })
                    ]));
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
