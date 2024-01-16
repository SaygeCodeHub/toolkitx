import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/equipmentTraceability/equipment_traceability_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../widgets/generic_app_bar.dart';

class EquipmentWarehouseList extends StatelessWidget {
  final Map warehouseMap;

  const EquipmentWarehouseList({Key? key, required this.warehouseMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<EquipmentTraceabilityBloc>().add(FetchWarehouse());
    return Scaffold(
        appBar: const GenericAppBar(title: "Select Warehouse"),
        body:
            BlocBuilder<EquipmentTraceabilityBloc, EquipmentTraceabilityState>(
          buildWhen: (previousState, currentState) =>
              currentState is WarehouseSelected ||
              currentState is EquipmentWareHouseFetching ||
              currentState is EquipmentWareHouseFetched ||
              currentState is EquipmentWareHouseNotFetched,
          builder: (context, state) {
            if (state is EquipmentWareHouseFetching) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EquipmentWareHouseFetched) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: leftRightMargin, right: leftRightMargin),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: state.fetchWarehouseModel.data.isNotEmpty,
                            replacement: Padding(
                              padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height / 2.7),
                              child: Center(
                                  child: Text(StringConstants.kNoRecordsFound,
                                      style:
                                          Theme.of(context).textTheme.medium)),
                            ),
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    state.fetchWarehouseModel.data.length,
                                itemBuilder: (context, index) {
                                  return RadioListTile(
                                      contentPadding: EdgeInsets.zero,
                                      dense: true,
                                      activeColor: AppColor.deepBlue,
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                      title: Text(state.fetchWarehouseModel
                                          .data[index].name),
                                      value: state
                                          .fetchWarehouseModel.data[index].id,
                                      groupValue:
                                          warehouseMap['warehouseid'] ?? '',
                                      onChanged: (value) {
                                        warehouseMap['warehouseid'] = state
                                            .fetchWarehouseModel.data[index].id;
                                        warehouseMap['warehouse'] = state
                                            .fetchWarehouseModel
                                            .data[index]
                                            .name;
                                        context
                                            .read<EquipmentTraceabilityBloc>()
                                            .add(SelectWarehouse(
                                                warehouseMap: warehouseMap));
                                        Navigator.pop(context);
                                      });
                                }),
                          ),
                          const SizedBox(height: xxxSmallerSpacing)
                        ])),
              );
            } else if (state is EquipmentWareHouseNotFetched) {
              return Center(child: Text(state.errorMessage));
            } else {
              return const SizedBox.shrink();
            }
          },
        ));
  }
}
