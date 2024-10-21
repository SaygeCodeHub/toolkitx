import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/equipmentTraceability/equipment_traceability_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/equipmentTraceability/widgets/warehouse_positions_list.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';

class SelectWarehousePositionsListTile extends StatelessWidget {
  static Map positionsMap = {};

  const SelectWarehousePositionsListTile({super.key});

  @override
  Widget build(BuildContext context) {
    context
        .read<EquipmentTraceabilityBloc>()
        .add(SelectWarehousePositions(positionsMap: {}));
    return BlocBuilder<EquipmentTraceabilityBloc, EquipmentTraceabilityState>(
      buildWhen: (previousState, currentState) =>
          currentState is WarehousePositionsSelected,
      builder: (context, state) {
        if (state is WarehousePositionsSelected) {
          return ListTile(
              contentPadding: EdgeInsets.zero,
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        WarehousePositionsList(positionsMap: positionsMap)));
              },
              title: Text(StringConstants.kPositions,
                  style: Theme.of(context).textTheme.xSmall.copyWith(
                      fontWeight: FontWeight.w500, color: AppColor.black)),
              subtitle: Text(
                state.positionsMap['position'] ?? '',
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
