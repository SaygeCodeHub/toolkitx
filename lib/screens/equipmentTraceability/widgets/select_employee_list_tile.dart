import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/equipmentTraceability/equipment_traceability_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/equipmentTraceability/widgets/employee_list.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';

class SelectEmployeeListTile extends StatelessWidget {
  static Map employeeMap = {};

  const SelectEmployeeListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context
        .read<EquipmentTraceabilityBloc>()
        .add(SelectEmployee(employeeMap: {}));
    return BlocBuilder<EquipmentTraceabilityBloc, EquipmentTraceabilityState>(
      buildWhen: (previousState, currentState) =>
          currentState is EmployeeSelected,
      builder: (context, state) {
        if (state is EmployeeSelected) {
          return ListTile(
              contentPadding: EdgeInsets.zero,
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        EmployeeList(employeeMap: employeeMap)));
              },
              title: Text(StringConstants.kEmployee,
                  style: Theme.of(context).textTheme.xSmall.copyWith(
                      fontWeight: FontWeight.w500, color: AppColor.black)),
              subtitle: Text(
                state.employeeMap['employee'] ?? '',
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
