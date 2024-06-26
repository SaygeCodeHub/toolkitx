import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_qr_scanner.dart';

import '../../../blocs/equipmentTraceability/equipment_traceability_bloc.dart';
import '../enter_equipment_code_screen.dart';
import '../search_equipment_list_screen.dart';

class TransferEquipmentPopupMenu extends StatelessWidget {
  const TransferEquipmentPopupMenu({super.key});

  PopupMenuItem _buildPopupMenuItem(context, String title, String position) {
    return PopupMenuItem(
        value: position,
        child: Text(title, style: Theme.of(context).textTheme.xSmall));
  }

  @override
  Widget build(BuildContext context) {
    List popUpMenuItems = [
      StringConstants.kScan,
      StringConstants.kEnter,
      StringConstants.kSearch,
      DatabaseUtil.getText('Cancel')
    ];
    return PopupMenuButton(
        onSelected: (value) {
          String code = '';
          Future<void> scanCode() async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CustomQRCodeScanner(
                        onCaptured: (String qrCode) {
                          code = qrCode;
                        },
                        onPressed: () {
                          context
                              .read<EquipmentTraceabilityBloc>()
                              .add(FetchEquipmentByCode(code: code));
                          Navigator.pop(context);
                        },
                      )),
            );
          }

          if (value == StringConstants.kScan) {
            scanCode();
          }
          if (value == StringConstants.kEnter) {
            Navigator.pushNamed(context, EnterEquipmentCodeScreen.routeName);
          }
          if (value == StringConstants.kSearch) {
            SearchEquipmentListScreen.isTransferScreen = true;
            Navigator.pushNamed(context, SearchEquipmentListScreen.routeName,
                arguments: false);
          }
        },
        position: PopupMenuPosition.under,
        itemBuilder: (BuildContext context) => [
              for (int i = 0; i < popUpMenuItems.length; i++)
                _buildPopupMenuItem(
                    context, popUpMenuItems[i], popUpMenuItems[i])
            ]);
  }
}
