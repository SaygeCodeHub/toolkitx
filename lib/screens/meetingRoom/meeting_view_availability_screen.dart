import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toolkit/blocs/meetingRoom/meeting_room_bloc.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/meetingRoom/widgets/meeting_date_picker.dart';
import 'package:toolkit/screens/meetingRoom/widgets/view_availability_details.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../utils/constants/string_constants.dart';

class MeetingViewAvailabilityScreen extends StatelessWidget {
  static const routeName = 'MeetingViewAvailabilityScreen';

  const MeetingViewAvailabilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<MeetingRoomBloc>().add(
        FetchMeetingAllRooms(date: DateFormat.yMMMd().format(DateTime.now())));
    String date = '';
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('viewAvaibility')),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing,
            bottom: xxTinierSpacing),
        child: Column(children: [
          MeetingDatePicker(
            onDateChanged: (date) {
              context
                  .read<MeetingRoomBloc>()
                  .add(FetchMeetingAllRooms(date: date));
              date = date;
            },
          ),
          const SizedBox(height: tiniestSpacing),
          const Divider(color: AppColor.blueGrey, thickness: xxxTiniestSpacing),
          Expanded(
            child: BlocBuilder<MeetingRoomBloc, MeetingRoomState>(
              buildWhen: (previousState, currentState) =>
                  currentState is MeetingAllRoomsFetching ||
                  currentState is MeetingAllRoomsFetched ||
                  currentState is MeetingAllRoomsNotFetched,
              builder: (context, state) {
                if (state is MeetingAllRoomsFetching) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MeetingAllRoomsFetched) {
                  return ListView.separated(
                    itemCount: state.fetchMeetingAllRoomsModel.data.length,
                    itemBuilder: (context, index) {
                      var data = state.fetchMeetingAllRoomsModel.data;
                      return CustomCard(
                        child: Padding(
                          padding: const EdgeInsets.all(tiniestSpacing),
                          child: ListTile(
                            leading: Text('${index + 1}'),
                            title: Text(data[index].roomname,
                                style: Theme.of(context)
                                    .textTheme
                                    .small
                                    .copyWith(
                                        color: AppColor.black,
                                        fontWeight: FontWeight.w600)),
                            subtitle: ViewAvailabilityDetails(
                                roomId: data[index].roomid,
                                date: date == ''
                                    ? DateFormat.yMMMd().format(DateTime.now())
                                    : date),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: xxTinierSpacing);
                    },
                  );
                } else if (state is MeetingAllRoomsNotFetched) {
                  return const Center(
                      child: Text(StringConstants.kNoRecordsFound));
                }
                return const SizedBox.shrink();
              },
            ),
          )
        ]),
      ),
    );
  }
}
