import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/screens/meetingRoom/search_rooms_screen.dart';
import 'package:toolkit/utils/meeting_room_util.dart';

class MeetingFloatingButton extends StatelessWidget {
  const MeetingFloatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          _showOptions(context);
        },
        child: const Icon(Icons.menu));
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 180,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Card(
                  child: ListTile(
                    title: Center(
                        child: Text(MeetingRoomUtil().meetingButtons[index])),
                    onTap: () {
                      navigateToModule(
                          MeetingRoomUtil().meetingButtons[index], context);
                    },
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: tiniestSpacing,
              );
            },
          ),
        );
      },
    );
  }

  navigateToModule(
    buttonName,
    context,
  ) {
    switch (buttonName) {
      case "Month View":
        Navigator.pop(context);
        break;
      case "View Availability":
        Navigator.pop(context);
        break;
      case "Book Meeting":
        Navigator.pushNamed(context, SearchRoomsScreen.routeName);
        break;
    }
  }
}
