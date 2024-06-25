import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toolkit/blocs/meetingRoom/meeting_room_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/meetingRoom/meeting_details_screen.dart';
import 'package:toolkit/screens/meetingRoom/widgets/meeting_date_picker.dart';
import 'package:toolkit/screens/meetingRoom/widgets/meeting_floating_button.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';

class MyMeetingsScreen extends StatelessWidget {
  static const routeName = 'MyMeetingsScreen';

  const MyMeetingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<MeetingRoomBloc>().add(
        FetchMyMeetingRoom(date: DateFormat.yMMMd().format(DateTime.now())));
    String initialDate = '';
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('mymeetings')),
      floatingActionButton: const Padding(
        padding:
            EdgeInsets.only(right: xxTinierSpacing, bottom: xxxSmallestSpacing),
        child: MeetingFloatingButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing,
            bottom: xxTinierSpacing),
        child: Column(
          children: [
            MeetingDatePicker(
                onDateChanged: (String date) {
                  context
                      .read<MeetingRoomBloc>()
                      .add(FetchMyMeetingRoom(date: date));
                  initialDate = date;
                },
                maxDate: DateTime.now()),
            const SizedBox(height: tiniestSpacing),
            const Divider(
                color: AppColor.blueGrey, thickness: xxxTiniestSpacing),
            Expanded(
              child: BlocBuilder<MeetingRoomBloc, MeetingRoomState>(
                buildWhen: (previousState, currentState) =>
                    currentState is MyMeetingRoomFetching ||
                    currentState is MyMeetingRoomFetched ||
                    currentState is MyMeetingRoomNotFetched,
                builder: (context, state) {
                  if (state is MyMeetingRoomFetching) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MyMeetingRoomFetched) {
                    var data = state.fetchMyMeetingsModel.data;
                    return ListView.separated(
                        itemCount: data.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          List<String> startDateTime =
                              data[index].startdatetime.split(' ');
                          String startTime = startDateTime[1];
                          List<String> endDateTime =
                              data[index].enddatetime.split(' ');
                          String endTime = endDateTime[1];
                          return CustomCard(
                              child: Padding(
                            padding: const EdgeInsets.all(xxTinierSpacing),
                            child: ListTile(
                                onTap: () {
                                  MeetingDetailsScreen.roomName =
                                      data[index].roomname;
                                  Navigator.pushNamed(context,
                                          MeetingDetailsScreen.routeName,
                                          arguments: data[index].bookingid)
                                      .then((_) => context
                                          .read<MeetingRoomBloc>()
                                          .add(FetchMyMeetingRoom(
                                              date: initialDate == ''
                                                  ? DateFormat.yMMMd()
                                                      .format(DateTime.now())
                                                  : initialDate)));
                                },
                                title: Text(data[index].roomname,
                                    style: Theme.of(context)
                                        .textTheme
                                        .xSmall
                                        .copyWith(
                                            fontWeight: FontWeight.w800,
                                            color: AppColor.black)),
                                subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: tinierSpacing),
                                      Text(data[index].location,
                                          style: Theme.of(context)
                                              .textTheme
                                              .xSmall
                                              .copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColor.grey)),
                                      const SizedBox(height: tinierSpacing),
                                      Text('$startTime - $endTime',
                                          style: Theme.of(context)
                                              .textTheme
                                              .xSmall
                                              .copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColor.grey)),
                                      const SizedBox(height: tinierSpacing),
                                      Text(data[index].shortagenda,
                                          style: Theme.of(context)
                                              .textTheme
                                              .xSmall
                                              .copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColor.grey)),
                                      const SizedBox(height: tinierSpacing),
                                      Text(data[index].participantname,
                                          style: Theme.of(context)
                                              .textTheme
                                              .xSmall
                                              .copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColor.grey)),
                                    ])),
                          ));
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: xxTinierSpacing);
                        });
                  } else if (state is MyMeetingRoomNotFetched) {
                    return const Center(
                      child: Text(StringConstants.kNoMeetingsToday),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
