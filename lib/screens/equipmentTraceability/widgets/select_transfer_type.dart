import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/equipmentTraceability/equipment_traceability_bloc.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/expansion_tile_border.dart';

class SelectTransferType extends StatelessWidget {
  const SelectTransferType({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List transferTypeList = [StringConstants.kWarehouse, StringConstants.kEmployee];
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
                              itemCount: transferTypeList.length,
                              itemBuilder: (context, listIndex) {
                                return ListTile(
                                    contentPadding: const EdgeInsets.only(
                                        left: xxTinierSpacing),
                                    title: Text(transferTypeList[listIndex]),
                                    onTap: () {
                                      context
                                          .read<EquipmentTraceabilityBloc>()
                                          .add(SelectTransferTypeName(
                                              transferType:
                                                  transferTypeList[listIndex]));
                                    });
                              }))
                    ]));
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
