import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/equipmentTraceability/equipment_traceability_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import 'view_my_request_screen.dart';
import 'widgets/select_workorder_equipment_list_tile.dart';

class ApproveEquipmentRequestScreen extends StatelessWidget {
  static const routeName = 'ApproveEquipmentRequestScreen';

  const ApproveEquipmentRequestScreen({super.key, required this.requestId});

  final String requestId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomCard(
              child: Padding(
                padding: const EdgeInsets.all(xxTinySpacing),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DatabaseUtil.getText('AcceptRequestMessage'),
                        style: Theme.of(context).textTheme.small.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColor.black)),
                    const SizedBox(height: xxTinierSpacing),
                    Visibility(
                        visible: context
                            .read<EquipmentTraceabilityBloc>()
                            .equipmentWorkOrderList
                            .isNotEmpty,
                        child: const SelectWorkOrderEquipmentListTile()),
                    const SizedBox(height: xxTinySpacing),
                    Row(
                      children: [
                        Expanded(
                            child: PrimaryButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                textValue: StringConstants.kClose)),
                        const SizedBox(width: xxTinySpacing),
                        Expanded(
                            child: BlocListener<EquipmentTraceabilityBloc,
                                EquipmentTraceabilityState>(
                          listener: (context, state) {
                            if (state is TransferRequestApproving) {
                              ProgressBar.show(context);
                            }
                            if (state is TransferRequestApproved) {
                              ProgressBar.dismiss(context);
                              showCustomSnackBar(context, "Approved", '');
                              Navigator.pop(context);
                              Navigator.pushReplacementNamed(
                                  context, ViewMyRequestScreen.routeName);
                            }
                            if (state is TransferRequestNotApproved) {
                              ProgressBar.dismiss(context);
                              showCustomSnackBar(
                                  context, state.errorMessage, '');
                            }
                          },
                          child: PrimaryButton(
                              onPressed: () {
                                context.read<EquipmentTraceabilityBloc>().add(
                                    ApproveTransferRequest(
                                        requestId: requestId));
                              },
                              textValue: DatabaseUtil.getText('approve')),
                        )),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
