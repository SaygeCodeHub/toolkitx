import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/%20meetingRoom/fetch_search_for_rooms_model.dart';

import '../../../blocs/meetingRoom/meeting_room_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';

class MeetingViewRoomCheckboxTile extends StatelessWidget {
  const MeetingViewRoomCheckboxTile(
      {super.key,
      required this.searchForRoomsDatum,
      required this.viewRoomMap});

  final SearchForRoomsDatum searchForRoomsDatum;
  final Map viewRoomMap;

  @override
  Widget build(BuildContext context) {
    context.read<MeetingRoomBloc>().add(SelectRoomId(roomId: ''));
    return BlocBuilder<MeetingRoomBloc, MeetingRoomState>(
      buildWhen: (previousState, currentState) =>
          currentState is RoomIdSelected,
      builder: (context, state) {
        if (state is RoomIdSelected) {
          return RadioListTile(
            contentPadding: EdgeInsets.zero,
            activeColor: AppColor.deepBlue,
            controlAffinity: ListTileControlAffinity.trailing,
            title: Text(searchForRoomsDatum.roomname,
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w500, color: AppColor.black)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: tiniestSpacing),
                Text(searchForRoomsDatum.location,
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        fontWeight: FontWeight.w400, color: AppColor.grey)),
                const SizedBox(height: tiniestSpacing),
                Text("Capacity Upto ${searchForRoomsDatum.capacity} People",
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        fontWeight: FontWeight.w400, color: AppColor.grey)),
                const SizedBox(height: tiniestSpacing),
                Text(searchForRoomsDatum.facilityname,
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        fontWeight: FontWeight.w400, color: AppColor.grey)),
                const SizedBox(height: tiniestSpacing),
              ],
            ),
            value: searchForRoomsDatum.roomid,
            groupValue: state.roomId,
            onChanged: (value) {
              viewRoomMap['location'] = searchForRoomsDatum.location;
              viewRoomMap['roomname'] = searchForRoomsDatum.roomname;
              viewRoomMap['roomid'] = searchForRoomsDatum.roomid;
              context
                  .read<MeetingRoomBloc>()
                  .add(SelectRoomId(roomId: searchForRoomsDatum.roomid));
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
