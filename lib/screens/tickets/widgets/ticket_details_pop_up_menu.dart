import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/tickets/tickets_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/enums/ticket_status_enum.dart';
import 'package:toolkit/data/models/tickets/fetch_ticket_details_model.dart';
import 'package:toolkit/screens/tickets/add_ticket_comment_screen.dart';
import 'package:toolkit/screens/tickets/add_ticket_document_screen.dart';
import 'package:toolkit/screens/tickets/widgets/add_ticket_comment_screen.dart';
import 'package:toolkit/screens/tickets/widgets/ticket_completion_date_screen.dart';
import 'package:toolkit/screens/tickets/widgets/ticket_edt_hour_screen.dart';
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
          if (value == DatabaseUtil.getText('ticket_estimateedt')) {
            context.read<TicketsBloc>().add(UpdateTicketStatus(
                edtHrs: '',
                completionDate: '',
                status: TicketStatusEnum.estimateDT.value));
          }
          if (value ==
              DatabaseUtil.getText('ticket_waitingfordevelopmentapproval')) {
            fetchTicketDetailsModel.data.isbug == '1'
                ? Navigator.pushNamed(context, TicketEDTHoursScreen.routeName)
                : context.read<TicketsBloc>().add(UpdateTicketStatus(
                    edtHrs: '0',
                    completionDate: '',
                    status: TicketStatusEnum.waitingForDevelopment.value));
          }
          if (value == DatabaseUtil.getText('ticket_approvefordevelopment')) {
            context.read<TicketsBloc>().add(UpdateTicketStatus(
                edtHrs: '',
                completionDate: '',
                status: TicketStatusEnum.approveForDevelopment.value));
          }
          if (value == DatabaseUtil.getText('ticket_development')) {
            Navigator.pushNamed(context, TicketCompletionDateScreen.routeName);
          }
          if (value == DatabaseUtil.getText('ticket_testing')) {
            context.read<TicketsBloc>().add(UpdateTicketStatus(
                edtHrs: '',
                completionDate: '',
                status: TicketStatusEnum.testing.value));
          }
          if (value == DatabaseUtil.getText('ticket_testing')) {
            context.read<TicketsBloc>().add(UpdateTicketStatus(
                edtHrs: '',
                completionDate: '',
                status: TicketStatusEnum.testing.value));
          }
          if (value == DatabaseUtil.getText('approve')) {
            context.read<TicketsBloc>().add(UpdateTicketStatus(
                edtHrs: '',
                completionDate: '',
                status: TicketStatusEnum.approved.value));
          }

          if (value == DatabaseUtil.getText('ticket_rollout')) {
            context.read<TicketsBloc>().add(UpdateTicketStatus(
                edtHrs: '',
                completionDate: '',
                status: TicketStatusEnum.rolledOut.value));
          }

          if (value == DatabaseUtil.getText('ticket_close')) {
            context.read<TicketsBloc>().add(UpdateTicketStatus(
                edtHrs: '',
                completionDate: '',
                status: TicketStatusEnum.closed.value));
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
