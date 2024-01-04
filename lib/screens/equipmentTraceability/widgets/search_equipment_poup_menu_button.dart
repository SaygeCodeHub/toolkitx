import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

class SearchEquipmentPopupMenuButton extends StatelessWidget {
  const SearchEquipmentPopupMenuButton({super.key, required this.popupItems});

  final List popupItems;

  PopupMenuItem _buildPopupMenuItem(context, String title, String position) {
    return PopupMenuItem(
        value: position,
        child: Text(title, style: Theme.of(context).textTheme.xSmall));
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        onSelected: (value) {},
        position: PopupMenuPosition.under,
        itemBuilder: (context) => [
              for (int i = 0; i < popupItems.length; i++)
                _buildPopupMenuItem(context, popupItems[i], popupItems[i])
            ]);
  }
}
