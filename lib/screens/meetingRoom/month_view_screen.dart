import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toolkit/blocs/meetingRoom/meeting_room_bloc.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/meetingRoom/meeting_details_screen.dart';
import 'package:toolkit/screens/meetingRoom/widgets/meeting_month_picker.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

class MonthViewScreen extends StatelessWidget {
  static const routeName = 'MonthViewScreen';

  const MonthViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<MeetingRoomBloc>().add(
        FetchMonthlySchedule(date: DateFormat.yMMM().format(DateTime.now())));
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('viewAvaibility')),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing,
            bottom: xxTinierSpacing),
        child: BlocBuilder<MeetingRoomBloc, MeetingRoomState>(
          buildWhen: (previousState, currentState) =>
              currentState is MonthlyScheduleFetching ||
              currentState is MonthlyScheduleFetched ||
              currentState is MonthlyScheduleNotFetched,
          builder: (context, state) {
            if (state is MonthlyScheduleFetching) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MonthlyScheduleFetched) {
              var data = state.fetchMonthlyScheduleModel.data;
              return Column(children: [
                MeetingMonthPicker(onDateChanged: (String date) {
                  context
                      .read<MeetingRoomBloc>()
                      .add(FetchMonthlySchedule(date: date));
                }),
                const SizedBox(height: tiniestSpacing),
                const Divider(
                    color: AppColor.blueGrey, thickness: xxxTiniestSpacing),
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      List bookings = data[index].bookings;
                      return CustomCard(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: tiniestSpacing,
                            vertical: xxxTinierSpacing),
                        child: ListTile(
                          leading: SizedBox(
                            width: 50,
                            child: Text(
                                state
                                    .fetchMonthlyScheduleModel.data[index].date,
                                style: Theme.of(context)
                                    .textTheme
                                    .xLarge
                                    .copyWith(
                                        color: AppColor.black,
                                        fontWeight: FontWeight.w400)),
                          ),
                          title: SizedBox(
                            height: 30.0,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: data[index].bookings.length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  width: 90,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context,
                                          MeetingDetailsScreen.routeName,
                                          arguments: bookings[index].bookingid);
                                    },
                                    child: Card(
                                      color: AppColor.green,
                                      child: Center(
                                        child: Text(
                                            '${bookings[index].startdatetime}-${bookings[index].enddatetime}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .xSmall
                                                .copyWith(
                                                    color: AppColor.black,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(width: tiniestSpacing);
                              },
                            ),
                          ),
                        ),
                      ));
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: xxTinierSpacing);
                    },
                  ),
                ),
              ]);
            } else if (state is MonthlyScheduleNotFetched) {
              return const Center(child: Text(StringConstants.kNoRecordsFound));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
