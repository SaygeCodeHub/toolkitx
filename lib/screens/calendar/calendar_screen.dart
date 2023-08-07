import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:toolkit/blocs/calendar/calendar_states.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/error_section.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../blocs/calendar/calendar_bloc.dart';
import '../../blocs/calendar/calendar_event.dart';
import '../../configs/app_color.dart';

class CalendarScreen extends StatelessWidget {
  static const routeName = 'CalendarScreen';

  const CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<CalendarBloc>().add(FetchCalendarEvents());
    return Scaffold(
        appBar: const GenericAppBar(title: 'Calendar View'),
        body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxTinierSpacing),
          child: BlocBuilder<CalendarBloc, CalendarStates>(
              buildWhen: (previousState, currentState) =>
                  currentState is FetchingCalendarEvents ||
                  currentState is CalendarEventsFetched,
              builder: (context, state) {
                if (state is FetchingCalendarEvents) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CalendarEventsFetched) {
                  return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(30)),
                              width: MediaQuery.of(context).size.width * 0.99,
                              child: TableCalendar(
                                availableGestures:
                                    AvailableGestures.horizontalSwipe,
                                onPageChanged: (page) {},
                                focusedDay:
                                    DateFormat("dd.MM.yyy").parse('01.05.2023'),
                                firstDay: DateTime(1900),
                                lastDay: DateTime(9000),
                                // calendarFormat: format,
                                onFormatChanged: (CalendarFormat format) {
                                  format = format;
                                },
                                startingDayOfWeek: StartingDayOfWeek.sunday,
                                daysOfWeekVisible: true,
                                onDaySelected: (DateTime date, events) {
                                  // onTapOfDay(date);
                                },
                                selectedDayPredicate: (DateTime date) {
                                  return isSameDay(
                                      DateFormat('dd.MM.yyy')
                                          .parse('01.05.2023'),
                                      date);
                                },
                                eventLoader: (day) {
                                  return context
                                      .read<CalendarBloc>()
                                      .getEventsForDay(
                                          day, state.fetchCalendarEventsModel);
                                },
                                calendarStyle: const CalendarStyle(
                                  isTodayHighlighted: false,
                                  selectedDecoration: BoxDecoration(
                                    color: AppColor.orange,
                                    shape: BoxShape.circle,
                                  ),
                                  selectedTextStyle:
                                      TextStyle(color: AppColor.white),
                                  todayDecoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.orange,
                                  ),
                                ),
                                headerStyle: const HeaderStyle(
                                  formatButtonVisible: false,
                                  titleCentered: true,
                                  formatButtonShowsNext: false,
                                ),
                              )),
                          SizedBox(
                              height: MediaQuery.of(context).size.width * 0.02),
                        ],
                      ));
                } else if (state is CalendarEventsNotFetched) {
                  return GenericReloadButton(
                      onPressed: () {
                        context.read<CalendarBloc>().add(FetchCalendarEvents());
                      },
                      textValue: StringConstants.kReload);
                } else {
                  return const SizedBox.shrink();
                }
              }),
        ));
  }
}
