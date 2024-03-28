import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/tickets/fetch_ticket_details_model.dart';
import 'package:toolkit/screens/tickets/add_ticket_comment_screen.dart';
import 'package:toolkit/screens/tickets/add_ticket_document_screen.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../../blocs/imagePickerBloc/image_picker_bloc.dart';
import '../../../blocs/imagePickerBloc/image_picker_event.dart';

class TicketsDetailsPopUpMenu extends StatelessWidget {
  final List popUpMenuItems;
  final FetchTicketDetailsModel fetchTicketDetailsModel;

  const TicketsDetailsPopUpMenu(
      {Key? key,
      required this.popUpMenuItems,
      required this.fetchTicketDetailsModel})
      : super(key: key);

  PopupMenuItem _buildPopupMenuItem(context, String title, String position) {
    return PopupMenuItem(
        value: position,
        child: Text(title, style: Theme.of(context).textTheme.xSmall));
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        onSelected: (value) {
          if (value == DatabaseUtil.getText('AddComments')) {
            Navigator.pushNamed(context, AddTicketCommentScreen.routeName);
          }
          if (value == DatabaseUtil.getText('AddDocuments')) {
            context.read<ImagePickerBloc>().pickedImagesList.clear();
            context.read<ImagePickerBloc>().add(PickImageInitial());
            Navigator.pushNamed(context, AddTicketDocumentScreen.routeName);
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
