import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/equipmentTraceability/equipment_traceability_bloc.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/expansion_tile_border.dart';

class SelectWarehouseExpansionTile extends StatelessWidget {
  const SelectWarehouseExpansionTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    context.read<EquipmentTraceabilityBloc>().add(
        SelectWarehouse(warehouse: '', id: ''));
    return BlocBuilder<EquipmentTraceabilityBloc, EquipmentTraceabilityState>(
        buildWhen: (previousState, currentState) =>
        currentState is WarehouseSelected,
        builder: (context, state) {
          if (state is WarehouseSelected) {
            return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: AppColor.transparent),
                child: ExpansionTile(
                    collapsedShape:
                    ExpansionTileBorder().buildOutlineInputBorder(),
                    collapsedBackgroundColor: AppColor.white,
                    backgroundColor: AppColor.white,
                    shape: ExpansionTileBorder().buildOutlineInputBorder(),
                    key: GlobalKey(),
                    title: Text(state.warehouse),
                    children: [
                      MediaQuery(
                          data: MediaQuery.of(context)
                              .removePadding(removeTop: true),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.fetchWarehouseModel.data.length,
                              itemBuilder: (context, listIndex) {
                                return ListTile(
                                    contentPadding: const EdgeInsets.only(
                                        left: xxTinierSpacing),
                                    title: Text(state.fetchWarehouseModel
                                        .data[listIndex].name),
                                    onTap: () {
                                      context
                                          .read<EquipmentTraceabilityBloc>()
                                          .add(SelectWarehouse(
                                          warehouse: state.fetchWarehouseModel
                                              .data[listIndex].name,
                                          id: state.fetchWarehouseModel
                                              .data[listIndex].id));
                                    });
                              }))
                    ]));
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}