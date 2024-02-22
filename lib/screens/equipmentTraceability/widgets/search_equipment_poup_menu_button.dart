import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/equipmentTraceability/equipment_traceability_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/equipmentTraceability/equipment_save_images.dart';
import 'package:toolkit/screens/equipmentTraceability/transfer_equipment_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../equipment_set_parameter_screen.dart';

class SearchEquipmentPopupMenuButton extends StatelessWidget {
  const SearchEquipmentPopupMenuButton(
      {super.key,
      required this.popupItems,
      required this.searchEquipmentDetailsMap});

  final List popupItems;
  final Map searchEquipmentDetailsMap;
  static Map equipmentSaveLocationMap = {};

  PopupMenuItem _buildPopupMenuItem(context, String title, String position) {
    return PopupMenuItem(
        value: position,
        child: Text(title, style: Theme.of(context).textTheme.xSmall));
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        onSelected: (value) {
          if (value == StringConstants.kTransfer) {
            Navigator.pushNamed(context, TransferEquipmentScreen.routeName);
          }
          if (value == StringConstants.kSetParameter) {
            Navigator.pushNamed(context, EquipmentSetParameterScreen.routeName,
                arguments: searchEquipmentDetailsMap);
          }
          if (value == StringConstants.kUploadMedia) {
            Navigator.pushNamed(context, EquipmentSaveImages.routeName);
          }
          if (value == StringConstants.kSetLocation) {
            context.read<EquipmentTraceabilityBloc>().add(EquipmentSaveLocation(
                equipmentSaveLocationMap: equipmentSaveLocationMap));
          }
        },
        position: PopupMenuPosition.under,
        itemBuilder: (context) => [
              for (int i = 0; i < popupItems.length; i++)
                _buildPopupMenuItem(context, popupItems[i], popupItems[i])
            ]);
  }
}
