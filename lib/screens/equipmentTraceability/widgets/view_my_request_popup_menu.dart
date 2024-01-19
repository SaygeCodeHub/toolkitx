import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/equipmentTraceability/equipment_traceability_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/android_pop_up.dart';

import '../approve_equipment_request_screen.dart';

class ViewMyRequestPopUp extends StatelessWidget {
  const ViewMyRequestPopUp({
    super.key,
    required this.popUpMenuItems,
    required this.requestId,
  });

  final List popUpMenuItems;
  final String requestId;

  PopupMenuItem _buildPopupMenuItem(context, String title, String position) {
    return PopupMenuItem(
        value: position,
        child: Text(title, style: Theme.of(context).textTheme.xSmall));
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        onSelected: (value) {
          if (value == DatabaseUtil.getText('approve')) {
            Navigator.pushNamed(
                context, ApproveEquipmentRequestScreen.routeName,
                arguments: requestId);
          }
          if (value == DatabaseUtil.getText('Reject')) {
            showDialog(
                context: context,
                builder: (context) => AndroidPopUp(
                      titleValue: DatabaseUtil.getText('Reject'),
                      contentValue: StringConstants.kAreYouSureToReject,
                      onPrimaryButton: () {
                        context
                            .read<EquipmentTraceabilityBloc>()
                            .add(RejectTransferRequest(requestId: requestId));
                      },
                    ));
          }
          if (value == DatabaseUtil.getText("Cancel")) {}
        },
        position: PopupMenuPosition.under,
        itemBuilder: (BuildContext context) => [
              for (int i = 0; i < popUpMenuItems.length; i++)
                _buildPopupMenuItem(
                    context, popUpMenuItems[i], popUpMenuItems[i])
            ]);
  }
}
