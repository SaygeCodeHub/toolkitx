import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/equipmentTraceability/equipment_save_images.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../equipment_set_parameter_screen.dart';

class SearchEquipmentPopupMenuButton extends StatelessWidget {
  const SearchEquipmentPopupMenuButton(
      {super.key,
      required this.popupItems,
      required this.searchEquipmentDetailsMap});

  final List popupItems;
  final Map searchEquipmentDetailsMap;

  PopupMenuItem _buildPopupMenuItem(context, String title, String position) {
    return PopupMenuItem(
        value: position,
        child: Text(title, style: Theme.of(context).textTheme.xSmall));
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        onSelected: (value) {
          if (value == StringConstants.kSetParameter) {
            Navigator.pushNamed(context, EquipmentSetParameterScreen.routeName,
                arguments: searchEquipmentDetailsMap);
          } else if (value == StringConstants.kUploadMedia) {
            Navigator.pushNamed(context, EquipmentSaveImages.routeName);
          }
        },
        position: PopupMenuPosition.under,
        itemBuilder: (context) => [
              for (int i = 0; i < popupItems.length; i++)
                _buildPopupMenuItem(context, popupItems[i], popupItems[i])
            ]);
  }
}
