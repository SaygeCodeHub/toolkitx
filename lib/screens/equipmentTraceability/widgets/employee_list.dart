import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/equipmentTraceability/equipment_traceability_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../widgets/generic_app_bar.dart';

class EmployeeList extends StatelessWidget {
  final Map employeeMap;

  const EmployeeList({Key? key, required this.employeeMap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<EquipmentTraceabilityBloc>().add(FetchEmployee());
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kSelectPositions),
        body:
            BlocBuilder<EquipmentTraceabilityBloc, EquipmentTraceabilityState>(
          buildWhen: (previousState, currentState) =>
              currentState is EmployeeSelected ||
              currentState is EmployeeFetching ||
              currentState is EmployeeFetched ||
              currentState is EmployeeNotFetched,
          builder: (context, state) {
            if (state is EmployeeFetching) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EmployeeFetched) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: leftRightMargin, right: leftRightMargin),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: state.fetchEmployeesModel.data.isNotEmpty,
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
                                    state.fetchEmployeesModel.data.length,
                                itemBuilder: (context, index) {
                                  return RadioListTile(
                                      contentPadding: EdgeInsets.zero,
                                      dense: true,
                                      activeColor: AppColor.deepBlue,
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                      title: Text(state.fetchEmployeesModel
                                          .data[index].name),
                                      value: state
                                          .fetchEmployeesModel.data[index].id,
                                      groupValue:
                                          employeeMap['employeeid'] ?? '',
                                      onChanged: (value) {
                                        employeeMap['employeeid'] = state
                                            .fetchEmployeesModel.data[index].id;
                                        employeeMap['employee'] = state
                                            .fetchEmployeesModel
                                            .data[index]
                                            .name;
                                        context
                                            .read<EquipmentTraceabilityBloc>()
                                            .add(SelectEmployee(
                                                employeeMap: employeeMap));
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
