import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/screens/meetingRoom/widgets/meeting_view_room_checkbox_tile.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import '../../data/models/ meetingRoom/fetch_search_for_rooms_model.dart';

class ViewAvailableRoomsScreen extends StatelessWidget {
  static const routeName = 'ViewAvailableRoomsScreen';

  const ViewAvailableRoomsScreen(
      {super.key, required this.searchForRoomsDatum});

  final List<SearchForRoomsDatum> searchForRoomsDatum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('viewRoomAvailable')),
      body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxTinierSpacing,
              bottom: xxTinierSpacing),
          child: ListView.separated(
              itemCount: searchForRoomsDatum.length,
              itemBuilder: (context, index) {
                return CustomCard(
                  child: Padding(
                    padding: const EdgeInsets.all(xxTinierSpacing),
                    child: MeetingViewRoomCheckboxTile(
                        searchForRoomsDatum: searchForRoomsDatum[index]),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: xxTinierSpacing);
              })),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxTinierSpacing),
        child: Row(
          children: [
            Expanded(
                child: PrimaryButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    textValue: DatabaseUtil.getText('buttonBack'))),
            const SizedBox(width: xxxSmallestSpacing),
            Expanded(
              child: PrimaryButton(
                  onPressed: () {},
                  textValue: DatabaseUtil.getText('continue')),
            )
          ],
        ),
      ),
    );
  }
}
