import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/equipmentTraceability/equipment_traceability_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../widgets/generic_app_bar.dart';

class EquipmentWorkOrderList extends StatelessWidget {
  final Map workOrderEquipmentMap;

  const EquipmentWorkOrderList({Key? key, required this.workOrderEquipmentMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<EquipmentTraceabilityBloc>().add(FetchMyRequest(pageNo: 1));
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kSelectEmployee),
        body:
            BlocBuilder<EquipmentTraceabilityBloc, EquipmentTraceabilityState>(
          buildWhen: (previousState, currentState) =>
              currentState is EquipmentWorkOrderSelected ||
              currentState is MyRequestFetching ||
              currentState is MyRequestFetched ||
              currentState is MyRequestNotFetched,
          builder: (context, state) {
            if (state is MyRequestFetching) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MyRequestFetched) {
              var list = state.fetchMyRequestModel.data.workorders!;
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: leftRightMargin, right: leftRightMargin),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: list.isNotEmpty,
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
                                itemCount: list.length,
                                itemBuilder: (context, index) {
                                  return RadioListTile(
                                      contentPadding: EdgeInsets.zero,
                                      dense: true,
                                      activeColor: AppColor.deepBlue,
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                      title: Text(list[index].woname!),
                                      value: list[index].id!,
                                      groupValue:
                                          workOrderEquipmentMap['workorder'] ??
                                              '',
                                      onChanged: (value) {
                                        workOrderEquipmentMap['workorderid'] =
                                            list[index].id.toString();
                                        workOrderEquipmentMap['workorder'] =
                                            list[index].woname;
                                        context
                                            .read<EquipmentTraceabilityBloc>()
                                            .add(SelectWorkOrderEquipment(
                                                workOrderEquipmentMap:
                                                    workOrderEquipmentMap));
                                        Navigator.pop(context);
                                      });
                                }),
                          ),
                          const SizedBox(height: xxxSmallerSpacing)
                        ])),
              );
            } else if (state is EmployeeNotFetched) {
              return Center(child: Text(state.errorMessage));
            } else {
              return const SizedBox.shrink();
            }
          },
        ));
  }
}
