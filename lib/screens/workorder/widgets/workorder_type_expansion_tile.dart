import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';

class WorkOrderTypeExpansionTile extends StatelessWidget {
  final List data;
  final Map workOrderDetailsMap;

  const WorkOrderTypeExpansionTile(
      {Key? key, required this.data, required this.workOrderDetailsMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<WorkOrderTabDetailsBloc>().add(SelectWorkOrderTypeOptions(
        typeId: workOrderDetailsMap['type'] ?? '',
        typeName: workOrderDetailsMap['workordertype'] ?? ''));
    return BlocBuilder<WorkOrderTabDetailsBloc, WorkOrderTabDetailsStates>(
        buildWhen: (previousState, currentState) =>
            currentState is WorkOrderTypeOptionSelected,
        builder: (context, state) {
          if (state is WorkOrderTypeOptionSelected) {
            return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: AppColor.transparent),
                child: ExpansionTile(
                    collapsedShape: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: AppColor.grey,
                      width: kExpansionBorderWidth,
                    )),
                    collapsedBackgroundColor: AppColor.white,
                    backgroundColor: AppColor.white,
                    shape: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: AppColor.grey,
                      width: kExpansionBorderWidth,
                    )),
                    maintainState: true,
                    key: GlobalKey(),
                    title: Text(
                        (state.typeName.isEmpty)
                            ? StringConstants.kSelectType
                            : state.typeName,
                        style: Theme.of(context).textTheme.xSmall),
                    children: [
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data[6].length,
                          itemBuilder: (BuildContext context, int itemIndex) {
                            return RadioListTile(
                                contentPadding: const EdgeInsets.only(
                                    left: xxxTinierSpacing),
                                activeColor: AppColor.deepBlue,
                                title: Text(data[6][itemIndex].workordertype,
                                    style: Theme.of(context).textTheme.xSmall),
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                value: data[6][itemIndex].id.toString(),
                                groupValue: state.typeId,
                                onChanged: (value) {
                                  workOrderDetailsMap['type'] =
                                      data[6][itemIndex].id.toString();
                                  context.read<WorkOrderTabDetailsBloc>().add(
                                      SelectWorkOrderTypeOptions(
                                          typeId:
                                              data[6][itemIndex].id.toString(),
                                          typeName: data[6][itemIndex]
                                              .workordertype));
                                });
                          })
                    ]));
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
