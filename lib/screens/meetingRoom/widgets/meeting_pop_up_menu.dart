import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/meetingRoom/meeting_room_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/%20meetingRoom/fetch_meeting_details_model.dart';
import 'package:toolkit/screens/meetingRoom/edit_meeting_details_screen.dart';
import 'package:toolkit/widgets/android_pop_up.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/progress_bar.dart';
import '../meeting_details_screen.dart';

class MeetingPopupMenuButton extends StatelessWidget {
  const MeetingPopupMenuButton(
      {super.key,
      required this.popUpMenuItems,
      required this.fetchMeetingDetailsModel});

  final List popUpMenuItems;
  final FetchMeetingDetailsModel fetchMeetingDetailsModel;

  PopupMenuItem _buildPopupMenuItem(context, String title, String position) {
    return PopupMenuItem(
        value: position,
        child: Text(title, style: Theme.of(context).textTheme.xSmall));
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        onSelected: (value) {
          if (value == DatabaseUtil.getText('Edit')) {
            Navigator.pushNamed(context, EditMeetingDetailsScreen.routeName,
                arguments: fetchMeetingDetailsModel.data);
          }
          if (value == DatabaseUtil.getText('Delete')) {
            showDialog(
                context: context,
                builder: (context) =>
                    BlocListener<MeetingRoomBloc, MeetingRoomState>(
                      listener: (context, state) {
                        if (state is BookingDetailsDeleting) {
                          ProgressBar.show(context);
                        } else if (state is BookingDetailsDeleted) {
                          ProgressBar.dismiss(context);
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(
                              context, MeetingDetailsScreen.routeName,
                              arguments:
                                  context.read<MeetingRoomBloc>().bookingId);
                        }
                        if (state is BookingDetailsNotDeleted) {
                          ProgressBar.dismiss(context);
                          showCustomSnackBar(context, state.errorMessage, '');
                        }
                      },
                      child: AndroidPopUp(
                        titleValue: DatabaseUtil.getText('Delete'),
                        contentValue: DatabaseUtil.getText('DeleteRecord'),
                        onPrimaryButton: () {
                          context
                              .read<MeetingRoomBloc>()
                              .add(DeleteBookingDetails());
                        },
                      ),
                    ));
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
