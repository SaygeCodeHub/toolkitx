import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/meetingRoom/widgets/meeting_floor_expansion_tile.dart';

import '../../../blocs/meetingRoom/meeting_room_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';

class MeetingFloorWidget extends StatelessWidget {
  const MeetingFloorWidget({
    super.key,
    required this.searchRoomMap,
  });

  final Map searchRoomMap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(DatabaseUtil.getText('Floor'),
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        BlocBuilder<MeetingRoomBloc, MeetingRoomState>(
          builder: (context, state) {
            if (state is MeetingBuildingFloorFetched) {
              return MeetingFloorExpansionTile(
                  floorList: state.fetchMeetingBuildingFloorModel.data,
                  searchRoomMap: searchRoomMap);
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
