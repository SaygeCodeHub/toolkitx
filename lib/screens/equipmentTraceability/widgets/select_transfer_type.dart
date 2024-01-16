import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/equipmentTraceability/equipment_traceability_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/enums/equipment_transfer_warehouse_enum.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../widgets/expansion_tile_border.dart';

class SelectTransferType extends StatelessWidget {
  const SelectTransferType({
    super.key,
  });

  static String transferType = '';
  static String transferValue = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EquipmentTraceabilityBloc, EquipmentTraceabilityState>(
        buildWhen: (previousState, currentState) =>
            currentState is TransferTypeSelected,
        builder: (context, state) {
          if (state is TransferTypeSelected) {
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
                    title: Text(state.transferType),
                    children: [
                      MediaQuery(
                          data: MediaQuery.of(context)
                              .removePadding(removeTop: true),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  EquipmentTransferWarehouseEnum.values.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                    contentPadding: const EdgeInsets.only(
                                        left: kExpansionTileMargin,
                                        right: kExpansionTileMargin),
                                    title: Text(
                                        EquipmentTransferWarehouseEnum.values
                                            .elementAt(index)
                                            .type,
                                        style:
                                            Theme.of(context).textTheme.xSmall),
                                    onTap: () {
                                      transferValue =
                                          EquipmentTransferWarehouseEnum.values
                                              .elementAt(index)
                                              .value;
                                      transferType =
                                          EquipmentTransferWarehouseEnum.values
                                              .elementAt(index)
                                              .type;
                                      context
                                          .read<EquipmentTraceabilityBloc>()
                                          .add(SelectTransferTypeName(
                                              transferType: transferType,
                                              transferValue: transferValue));
                                    });
                              }))
                    ]));
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
