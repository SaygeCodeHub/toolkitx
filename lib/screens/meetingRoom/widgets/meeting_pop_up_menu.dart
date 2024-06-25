import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/%20meetingRoom/fetch_meeting_details_model.dart';
import 'package:toolkit/screens/meetingRoom/edit_meeting_details_screen.dart';
import '../../../utils/database_utils.dart';

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
          if (value == DatabaseUtil.getText('Delete')) {}
        },
        position: PopupMenuPosition.under,
        itemBuilder: (BuildContext context) => [
              for (int i = 0; i < popUpMenuItems.length; i++)
                _buildPopupMenuItem(
                    context, popUpMenuItems[i], popUpMenuItems[i])
            ]);
  }
}
