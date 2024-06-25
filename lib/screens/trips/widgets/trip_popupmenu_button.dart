import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/trips/widgets/add_special_report_screen.dart';

import '../../../utils/constants/string_constants.dart';

class TripsPopupMenuButton extends StatelessWidget {
  const TripsPopupMenuButton(
      {super.key, required this.popUpMenuItems, required this.tripId});

  final String tripId;

  final List popUpMenuItems;

  PopupMenuItem _buildPopupMenuItem(context, String title, String position) {
    return PopupMenuItem(
        value: position,
        child: Text(title, style: Theme.of(context).textTheme.xSmall));
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        onSelected: (value) {
          if (value == StringConstants.kAddSpecialRequest) {
            Navigator.pushNamed(context, AddSpecialReportScreen.routeName,
                arguments: tripId);
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
