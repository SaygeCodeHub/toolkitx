import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/equipmentTraceability/equipment_traceability_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/equipmentTraceability/widgets/select_transfer_type.dart';
import 'package:toolkit/screens/equipmentTraceability/widgets/select_warehouse_positions_list_tile.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import 'widgets/select_employee_list_tile.dart';
import 'widgets/select_warehouse_list_tile.dart';

class SendTransferScreen extends StatelessWidget {
  static const routeName = "SendTransferScreen";

  const SendTransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context
        .read<EquipmentTraceabilityBloc>()
        .add(SelectTransferTypeName(transferType: '', transferValue: ''));
    return Scaffold(
      appBar: const GenericAppBar(title: StringConstants.kTransfer),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(StringConstants.kSelect,
                style: Theme.of(context).textTheme.xSmall.copyWith(
                    fontWeight: FontWeight.w500, color: AppColor.black)),
            const SizedBox(height: tiniestSpacing),
            const SelectTransferType(),
            const SizedBox(height: xxxTinierSpacing),
            const SelectWarehouseListTile(),
            const SizedBox(height: xxxTinierSpacing),
            const SelectWarehousePositionsListTile(),
            const SizedBox(height: xxxTinierSpacing),
            const SelectEmployeeListTile()
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxTinierSpacing),
        child: PrimaryButton(
            onPressed: () {}, textValue: StringConstants.kTransfer),
      ),
    );
  }
}
