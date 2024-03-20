import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/tickets/fetch_ticket_details_model.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';

class TicketsDetailsPopUpMenu extends StatelessWidget {
  final List popUpMenuItems;
  final FetchTicketDetailsModel fetchTicketDetailsModel;

  const TicketsDetailsPopUpMenu(
      {Key? key,
      required this.popUpMenuItems,
      required this.fetchTicketDetailsModel})
      : super(key: key);

  PopupMenuItem _buildPopupMenuItem(context, String title, int position) {
    return PopupMenuItem(
        value: position,
        child: Text(title, style: Theme.of(context).textTheme.xSmall));
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kCardRadius)),
        iconSize: kIconSize,
        icon: const Icon(Icons.more_vert_outlined),
        offset: const Offset(0, xxTiniestSpacing),
        onSelected: (value) {},
        position: PopupMenuPosition.under,
        itemBuilder: (BuildContext context) => [
              for (int i = 0; i < popUpMenuItems.length; i++)
                _buildPopupMenuItem(context, popUpMenuItems[i], i)
            ]);
  }
}
