import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/tickets/tickets_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/enums/ticket_status_enum.dart';
import 'package:toolkit/screens/tickets/add_ticket_comment_screen.dart';
import 'package:toolkit/screens/tickets/add_ticket_document_screen.dart';
import 'package:toolkit/screens/tickets/widgets/ticket_completion_date_screen.dart';
import 'package:toolkit/screens/tickets/widgets/ticket_edt_hour_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../../blocs/imagePickerBloc/image_picker_bloc.dart';
import '../../../blocs/imagePickerBloc/image_picker_event.dart';
import '../../../data/models/tickets2/fetch_ticket_two_details_model.dart';

class TicketTwoDetailsPopUpMenu extends StatelessWidget {
  final List popUpMenuItems;
  final FetchTicketTwoDetailsModel fetchTicketTwoDetailsModel;

  const TicketTwoDetailsPopUpMenu(
      {super.key,
      required this.popUpMenuItems,
      required this.fetchTicketTwoDetailsModel});

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
                edtHrs: 0,
                completionDate: '',
                status: TicketStatusEnum.estimateDT.value));
          }
          if (value ==
              DatabaseUtil.getText('ticket_waitingfordevelopmentapproval')) {
            fetchTicketTwoDetailsModel.data.isbug != '1'
                ? Navigator.pushNamed(context, TicketEDTHoursScreen.routeName)
                : context.read<TicketsBloc>().add(UpdateTicketStatus(
                    edtHrs: 0,
                    completionDate: '',
                    status: TicketStatusEnum.waitingForDevelopment.value));
          }
          if (value == DatabaseUtil.getText('ticket_approvefordevelopment')) {
            // context.read<TicketsBloc>().add(UpdateTicketStatus(
            //     edtHrs: int.tryParse(fetchTicketDetailsModel.data.etd),
            //     completionDate: '',
            //     status: TicketStatusEnum.approveForDevelopment.value));
          }
          if (value == DatabaseUtil.getText('ticket_development')) {
            Navigator.pushNamed(context, TicketCompletionDateScreen.routeName);
          }
          if (value == DatabaseUtil.getText('ticket_defer')) {
            context.read<TicketsBloc>().add(UpdateTicketStatus(
                edtHrs: 0,
                completionDate: '',
                status: TicketStatusEnum.deferred.value));
          }
          if (value == DatabaseUtil.getText('ticket_testing')) {
            context.read<TicketsBloc>().add(UpdateTicketStatus(
                edtHrs: 0,
                completionDate: '',
                status: TicketStatusEnum.testing.value));
          }
          if (value == DatabaseUtil.getText('approve')) {
            context.read<TicketsBloc>().add(UpdateTicketStatus(
                edtHrs: 0,
                completionDate: '',
                status: TicketStatusEnum.approved.value));
          }

          if (value == DatabaseUtil.getText('ticket_rollout')) {
            context.read<TicketsBloc>().add(UpdateTicketStatus(
                edtHrs: 0,
                completionDate: '',
                status: TicketStatusEnum.rolledOut.value));
          }

          if (value == DatabaseUtil.getText('ticket_close')) {
            context.read<TicketsBloc>().add(UpdateTicketStatus(
                edtHrs: 0,
                completionDate: '',
                status: TicketStatusEnum.closed.value));
          }
          if (value == StringConstants.kOpenTicket) {
            // Navigator.pushNamed(context, OpenTicketScreen.routeName);
          }
          if (value == StringConstants.kBackToApprove) {
            context.read<TicketsBloc>().add(UpdateTicketStatus(
                edtHrs: 0,
                completionDate: '',
                status: TicketStatusEnum.backToApprove.value));
          }
          if (value == StringConstants.kApproveRolledOut) {
            context.read<TicketsBloc>().add(UpdateTicketStatus(
                edtHrs: 0,
                completionDate: '',
                status: TicketStatusEnum.approveRolledOut.value));
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
