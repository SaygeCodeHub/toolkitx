import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/meetingRoom/meeting_room_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/incident/widgets/date_picker.dart';
import 'package:toolkit/screens/meetingRoom/search_rooms_screen.dart';
import 'package:toolkit/screens/meetingRoom/widgets/meeting_participant_expansion_tile.dart';
import 'package:toolkit/screens/meetingRoom/widgets/meeting_repeat_expansion_tile.dart';
import 'package:toolkit/widgets/generic_text_field.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';

class BookMeetingRoomBody extends StatelessWidget {
  const BookMeetingRoomBody({
    super.key,
    required this.bookRoomMap,
    required this.participantList,
  });

  final Map bookRoomMap;
  final List participantList;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(DatabaseUtil.getText('Date'),
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
      const SizedBox(height: tiniestSpacing),
      Text(
          '${SearchRoomsScreen.searchRoomMap['st']} - ${SearchRoomsScreen.searchRoomMap['et']}'),
      const SizedBox(height: xxxSmallestSpacing),
      Text(DatabaseUtil.getText('Room'),
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
      const SizedBox(height: tiniestSpacing),
      Text('${bookRoomMap['roomname']}(${bookRoomMap['location']})'),
      const SizedBox(height: xxxSmallestSpacing),
      Text(DatabaseUtil.getText('Repeat'),
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
      const SizedBox(height: tiniestSpacing),
      MeetingRepeatExpansionTile(bookRoomMap: bookRoomMap),
      BlocBuilder<MeetingRoomBloc, MeetingRoomState>(
        buildWhen: (previousState, currentState) =>
            currentState is RepeatValueSelected,
        builder: (context, state) {
          if (state is RepeatValueSelected) {
            return Visibility(
              visible: (state.repeat != "0" || bookRoomMap['repeat'] == null),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: xxxSmallestSpacing),
                  Text(DatabaseUtil.getText('EndsOn'),
                      style: Theme.of(context).textTheme.xSmall.copyWith(
                          color: AppColor.black, fontWeight: FontWeight.bold)),
                  const SizedBox(height: tiniestSpacing),
                  DatePickerTextField(
                    onDateChanged: (date) {
                      bookRoomMap['endson'] = date;
                    },
                  )
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      const SizedBox(height: xxxSmallestSpacing),
      Text(DatabaseUtil.getText('shortAgenda'),
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
      const SizedBox(height: tiniestSpacing),
      TextFieldWidget(
        onTextFieldChanged: (textField) {
          bookRoomMap['shortagenda'] = textField;
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
        onTextFieldChanged: (textField) {
          bookRoomMap['longagenda'] = textField;
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
          participantList: participantList, bookRoomMap: bookRoomMap),
      const SizedBox(height: xxxSmallestSpacing),
      Text(DatabaseUtil.getText('newExternalUser'),
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
      const SizedBox(height: tiniestSpacing),
      TextFieldWidget(
        maxLines: 2,
        onTextFieldChanged: (textField) {
          bookRoomMap['externalusers'] = textField;
        },
      ),
      const SizedBox(height: xxxSmallestSpacing),
      Text(DatabaseUtil.getText('commaSepratedEmail'),
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(color: AppColor.grey, fontWeight: FontWeight.w400)),
    ]);
  }
}
