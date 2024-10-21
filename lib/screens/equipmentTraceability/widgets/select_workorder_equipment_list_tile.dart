import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/equipmentTraceability/equipment_traceability_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/equipmentTraceability/widgets/equipment_workorder_list.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';

class SelectWorkOrderEquipmentListTile extends StatelessWidget {
  static Map workOrderEquipmentMap = {};

  const SelectWorkOrderEquipmentListTile({super.key});

  @override
  Widget build(BuildContext context) {
    context
        .read<EquipmentTraceabilityBloc>()
        .add(SelectWorkOrderEquipment(workOrderEquipmentMap: {}));
    return BlocBuilder<EquipmentTraceabilityBloc, EquipmentTraceabilityState>(
      buildWhen: (previousState, currentState) =>
          currentState is EquipmentWorkOrderSelected,
      builder: (context, state) {
        if (state is EquipmentWorkOrderSelected) {
          return ListTile(
              contentPadding: EdgeInsets.zero,
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EquipmentWorkOrderList(
                        workOrderEquipmentMap: workOrderEquipmentMap)));
              },
              title: Text(StringConstants.kWorkorder,
                  style: Theme.of(context).textTheme.xSmall.copyWith(
                      fontWeight: FontWeight.w500, color: AppColor.black)),
              subtitle: Text(
                state.workOrderEquipmentMap['workorder'] ?? '',
                style: Theme.of(context)
                    .textTheme
                    .xSmall
                    .copyWith(color: AppColor.black),
              ),
              trailing:
                  const Icon(Icons.navigate_next_rounded, size: kIconSize));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
