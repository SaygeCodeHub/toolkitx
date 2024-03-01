import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:toolkit/data/models/calendar/fetch_calendar_event_model.dart';

import '../../../blocs/calendar/calendar_bloc.dart';
import '../../../blocs/calendar/calendar_event.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';

class CalendarSection extends StatelessWidget {
  final List calendarEvents;
  final DateTime selectedDate;
  final FetchCalendarEventsModel fetchCalendarEventsModel;

  const CalendarSection(
      {Key? key,
      required this.calendarEvents,
      required this.selectedDate,
      required this.fetchCalendarEventsModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(tiniestSpacing),
      child: Container(
          decoration: BoxDecoration(
              color: AppColor.pastelBlue,
              borderRadius: BorderRadius.circular(kCalendarRadius)),
          width: kCalendarContainerWidth,
          child: TableCalendar(
            availableGestures: AvailableGestures.horizontalSwipe,
            onPageChanged: (date) {
              String pageChangeMonth = "${date.month}/${date.year}";
              context
                  .read<CalendarBloc>()
                  .add(FetchCalendarEvents(currentDate: pageChangeMonth));
            },
            focusedDay: selectedDate,
            firstDay: DateTime(1900),
            lastDay: DateTime(9000),
            calendarFormat: context.read<CalendarBloc>().format,
            onFormatChanged: (CalendarFormat format) {
              format = context.read<CalendarBloc>().format;
            },
            startingDayOfWeek: StartingDayOfWeek.sunday,
            daysOfWeekVisible: true,
            onDaySelected: (
              DateTime date,
              events,
            ) {
              context.read<CalendarBloc>().add(SelectCalendarDate(
                  selectedDate: date,
                  fetchCalendarEventsModel: fetchCalendarEventsModel));
            },
            selectedDayPredicate: (DateTime date) {
              return isSameDay(selectedDate, date);
            },
            eventLoader: (day) {
              return context
                  .read<CalendarBloc>()
                  .getEventsForDay(day, fetchCalendarEventsModel);
            },
            calendarStyle: const CalendarStyle(
              isTodayHighlighted: false,
              selectedDecoration: BoxDecoration(
                color: AppColor.deepBlue,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(color: AppColor.white),
              todayDecoration: BoxDecoration(
                  shape: BoxShape.circle, color: AppColor.deepBlue),
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              formatButtonShowsNext: false,
            ),
          )),
    );
  }
}
