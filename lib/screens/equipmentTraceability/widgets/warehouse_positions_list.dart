import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/equipmentTraceability/equipment_traceability_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../widgets/generic_app_bar.dart';

class WarehousePositionsList extends StatelessWidget {
  final Map positionsMap;

  const WarehousePositionsList({Key? key, required this.positionsMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<EquipmentTraceabilityBloc>().add(FetchWarehousePositions());
    return Scaffold(
        appBar: const GenericAppBar(title: "Select Positions"),
        body:
            BlocBuilder<EquipmentTraceabilityBloc, EquipmentTraceabilityState>(
          buildWhen: (previousState, currentState) =>
              currentState is WarehousePositionsSelected ||
              currentState is WarehousePositionsFetching ||
              currentState is WarehousePositionsFetched ||
              currentState is WarehousePositionsNotFetched,
          builder: (context, state) {
            if (state is WarehousePositionsFetching) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WarehousePositionsFetched) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: leftRightMargin, right: leftRightMargin),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: state
                                .fetchWarehousePositionsModel.data.isNotEmpty,
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
                                itemCount: state
                                    .fetchWarehousePositionsModel.data.length,
                                itemBuilder: (context, index) {
                                  return RadioListTile(
                                      contentPadding: EdgeInsets.zero,
                                      dense: true,
                                      activeColor: AppColor.deepBlue,
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                      title: Text(state
                                          .fetchWarehousePositionsModel
                                          .data[index]
                                          .name),
                                      value: state.fetchWarehousePositionsModel
                                          .data[index].id,
                                      groupValue:
                                          positionsMap['positionid'] ?? '',
                                      onChanged: (value) {
                                        positionsMap['positionid'] = state
                                            .fetchWarehousePositionsModel
                                            .data[index]
                                            .id;
                                        positionsMap['position'] = state
                                            .fetchWarehousePositionsModel
                                            .data[index]
                                            .name;
                                        context
                                            .read<EquipmentTraceabilityBloc>()
                                            .add(SelectWarehousePositions(
                                                positionsMap: positionsMap));
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
