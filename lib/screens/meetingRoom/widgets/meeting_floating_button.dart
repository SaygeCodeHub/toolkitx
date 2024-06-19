import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';

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
    List meetingButtons = ["Month View", "View Availability", "Book Meeting"];
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
                    title: Center(child: Text(meetingButtons[index])),
                    onTap: () {
                      navigateToModule(meetingButtons[index], context);
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
        Navigator.pop(context);
        break;
    }
  }
}
