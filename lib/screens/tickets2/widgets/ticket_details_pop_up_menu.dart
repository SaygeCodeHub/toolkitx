import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/tickets2/update_ticket_two_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../../blocs/imagePickerBloc/image_picker_bloc.dart';
import '../../../blocs/imagePickerBloc/image_picker_event.dart';
import '../../../blocs/tickets2/tickets2_bloc.dart';
import '../../../blocs/tickets2/tickets2_event.dart';
import '../../../data/enums/ticketTwo/ticket_two_status_enum.dart';
import '../../../data/models/tickets2/fetch_ticket_two_details_model.dart';
import '../add_ticket_two_document_screen.dart';
import '../reject_ticket_two_screen.dart';
import '../ticket_two_completion_date_screen.dart';
import '../ticket_two_edt_hours_screen.dart';
import '../add_ticket_two_comments_screen.dart';
import '../open_ticket_two_screen.dart';

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
            AddTicketTwoCommentScreen.comment = '';
            Navigator.pushNamed(context, AddTicketTwoCommentScreen.routeName);
          }
          if (value == DatabaseUtil.getText('AddDocuments')) {
            context.read<ImagePickerBloc>().pickedImagesList.clear();
            context.read<ImagePickerBloc>().add(PickImageInitial());
            Navigator.pushNamed(context, AddTicketTwoDocumentScreen.routeName);
          }
          if (value == DatabaseUtil.getText('ticket_estimateedt')) {
            context.read<Tickets2Bloc>().add(UpdateTicket2Status(
                edtHrs: 0,
                completionDate: '',
                status: TicketTwoStatusEnum.estimateDT.value));
          }
          if (value ==
              DatabaseUtil.getText('ticket_waitingfordevelopmentapproval')) {
            fetchTicketTwoDetailsModel.data.isbug != '1'
                ? Navigator.pushNamed(
                    context, TicketTwoEDTHoursScreen.routeName)
                : context.read<Tickets2Bloc>().add(UpdateTicket2Status(
                    edtHrs: 0,
                    completionDate: '',
                    status: TicketTwoStatusEnum.waitingForDevelopment.value));
          }
          if (value == DatabaseUtil.getText('ticket_approvefordevelopment')) {
            context.read<Tickets2Bloc>().add(UpdateTicket2Status(
                edtHrs: int.tryParse(fetchTicketTwoDetailsModel.data.etd),
                completionDate: '',
                status: TicketTwoStatusEnum.approveForDevelopment.value));
          }
          if (value == DatabaseUtil.getText('ticket_development')) {
            Navigator.pushNamed(
                context, TicketTwoCompletionDateScreen.routeName);
          }
          if (value == DatabaseUtil.getText('ticket_defer')) {
            context.read<Tickets2Bloc>().add(UpdateTicket2Status(
                edtHrs: 0,
                completionDate: '',
                status: TicketTwoStatusEnum.deferred.value));
          }
          if (value == DatabaseUtil.getText('ticket_testing')) {
            context.read<Tickets2Bloc>().add(UpdateTicket2Status(
                edtHrs: 0,
                completionDate: '',
                status: TicketTwoStatusEnum.testing.value));
          }
          if (value == DatabaseUtil.getText('approve')) {
            context.read<Tickets2Bloc>().add(UpdateTicket2Status(
                edtHrs: 0,
                completionDate: '',
                status: TicketTwoStatusEnum.approved.value));
          }

          if (value == DatabaseUtil.getText('ticket_rollout')) {
            context.read<Tickets2Bloc>().add(UpdateTicket2Status(
                edtHrs: 0,
                completionDate: '',
                status: TicketTwoStatusEnum.rolledOut.value));
          }

          if (value == DatabaseUtil.getText('ticket_close')) {
            context.read<Tickets2Bloc>().add(UpdateTicket2Status(
                edtHrs: 0,
                completionDate: '',
                status: TicketTwoStatusEnum.closed.value));
          }
          if (value == StringConstants.kOpenTicket) {
            Navigator.pushNamed(context, OpenTicketTwoScreen.routeName);
          }
          if (value == StringConstants.kBackToApprove) {
            context.read<Tickets2Bloc>().add(UpdateTicket2Status(
                edtHrs: 0,
                completionDate: '',
                status: TicketTwoStatusEnum.backToApprove.value));
          }
          if (value == StringConstants.kApproveRolledOut) {
            context.read<Tickets2Bloc>().add(UpdateTicket2Status(
                edtHrs: 0,
                completionDate: '',
                status: TicketTwoStatusEnum.approveRolledOut.value));
          }
          if (value == DatabaseUtil.getText('Edit')) {
            Navigator.pushNamed(context, UpdateTicketTwoScreen.routeName,
                arguments: fetchTicketTwoDetailsModel.data.id);
          }
          if (value == DatabaseUtil.getText('Reject')) {
            context.read<Tickets2Bloc>().rejectTicketComment = '';
            Navigator.pushNamed(context, RejectTicketTwoScreen.routeName);
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
