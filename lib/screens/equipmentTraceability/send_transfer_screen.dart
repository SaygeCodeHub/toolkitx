import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/equipmentTraceability/equipment_traceability_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/equipmentTraceability/widgets/select_transfer_type.dart';
import 'package:toolkit/screens/equipmentTraceability/widgets/select_warehouse_positions_list_tile.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import 'widgets/select_employee_list_tile.dart';
import 'widgets/select_warehouse_list_tile.dart';

class SendTransferScreen extends StatelessWidget {
  static const routeName = "SendTransferScreen";

  const SendTransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SelectTransferType.transferValue = "";
    SelectEmployeeListTile.employeeMap = {};
    SelectWarehouseListTile.warehouseMap = {};
    SelectWarehousePositionsListTile.positionsMap = {};
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
            BlocConsumer<EquipmentTraceabilityBloc, EquipmentTraceabilityState>(
              listener: (context, state) {
                if(state is TransferRequestSending){
                  ProgressBar.show(context);
                }else if(state is TransferRequestSent){
                  ProgressBar.dismiss(context);
                  showCustomSnackBar(context, 'Transferred Successfully', '');
                  Navigator.pop(context);
                  Navigator.pop(context);
                }else if(state is TransferRequestNotSent){
                  ProgressBar.dismiss(context);
                  showCustomSnackBar(context, state.errorMessage, '');
                }
              },
              buildWhen: (previousState, currentState) =>
                  currentState is TransferTypeSelected,
              builder: (context, state) {
                if (state is TransferTypeSelected) {
                  return Column(
                    children: [
                      Visibility(
                        visible: SelectTransferType.transferValue == "1",
                        child: const SelectWarehouseListTile(),
                      ),
                      const SizedBox(height: xxxTinierSpacing),
                      Visibility(
                          visible: SelectTransferType.transferValue == "1",
                          child: const SelectWarehousePositionsListTile()),
                      const SizedBox(height: xxxTinierSpacing),
                      Visibility(
                          visible: SelectTransferType.transferValue == "2",
                          child: const SelectEmployeeListTile())
                    ],
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxTinierSpacing),
        child: PrimaryButton(
            onPressed: () {
              context.read<EquipmentTraceabilityBloc>().add(SendTransferRequest());
            }, textValue: StringConstants.kTransfer),
      ),
    );
  }
}
