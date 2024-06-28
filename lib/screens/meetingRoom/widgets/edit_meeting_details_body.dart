import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/ meetingRoom/fetch_meeting_details_model.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/generic_text_field.dart';
import 'meeting_participant_expansion_tile.dart';

class EditMeetingDetailsBody extends StatelessWidget {
  const EditMeetingDetailsBody({
    super.key,
    required this.meetingDetailsData,
    required this.locationList,
    required this.editDetailsMap,
    required this.participantList,
  });

  final MeetingDetailsData meetingDetailsData;
  final List locationList;
  final Map editDetailsMap;
  final List participantList;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(DatabaseUtil.getText('Date'),
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(
            '${meetingDetailsData.startdatetime} - ${meetingDetailsData.enddatetime}'),
        const SizedBox(height: xxxSmallestSpacing),
        Text(DatabaseUtil.getText('Building'),
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(locationList[0]),
        const SizedBox(height: xxxSmallestSpacing),
        Text(DatabaseUtil.getText('Floor'),
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(locationList[1]),
        const SizedBox(height: xxxSmallestSpacing),
        Text(DatabaseUtil.getText('Room'),
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(meetingDetailsData.roomname),
        const SizedBox(height: xxxSmallestSpacing),
        Text(DatabaseUtil.getText('shortAgenda'),
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        TextFieldWidget(
          value: meetingDetailsData.shortagenda,
          onTextFieldChanged: (textField) {
            editDetailsMap['shortagenda'] = textField;
          },
        ),
        const SizedBox(height: xxxSmallestSpacing),
        Text(DatabaseUtil.getText('longAgenda'),
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        TextFieldWidget(
          value: meetingDetailsData.longagenda,
          onTextFieldChanged: (textField) {
            editDetailsMap['longagenda'] = textField;
          },
        ),
        const SizedBox(height: xxxSmallestSpacing),
        Text(DatabaseUtil.getText('participant'),
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        MeetingParticipantExpansionTile(
            participantList: participantList, bookRoomMap: editDetailsMap),
      ]),
    );
  }
}
