import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_qr_scanner.dart';

import '../../../blocs/equipmentTraceability/equipment_traceability_bloc.dart';
import '../enter_equipment_code_screen.dart';
import '../search_equipment_list_screen.dart';

class TransferEquipmentPopupMenu extends StatefulWidget {
  const TransferEquipmentPopupMenu({super.key});

  @override
  State<TransferEquipmentPopupMenu> createState() => _TransferEquipmentPopupMenuState();
}

class _TransferEquipmentPopupMenuState extends State<TransferEquipmentPopupMenu> {
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
        onSelected: (value)  {
          Future<void> scanCode() async {
            final code = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CustomQRCodeScanner()),
            );
            if (!mounted) return;
            context
                .read<EquipmentTraceabilityBloc>()
                .add(FetchEquipmentByCode(code: code));
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
