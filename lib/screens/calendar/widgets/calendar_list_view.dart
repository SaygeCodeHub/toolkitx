import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../data/models/calendar/fetch_calendar_event_model.dart';
import '../../../utils/database_utils.dart';
import 'calender_events_body.dart';

class CalendarListView extends StatelessWidget {
  final List<CalendarEvent> calendarEvents;
  final String currentDate;
  final int eventsLoaderCount;
  final FetchCalendarEventsModel fetchCalendarEventsModel;

  const CalendarListView({
    super.key,
    required this.calendarEvents,
    required this.currentDate,
    required this.eventsLoaderCount,
    required this.fetchCalendarEventsModel,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: calendarEvents.isNotEmpty,
      replacement: Center(
        child: Text(
          DatabaseUtil.getText('nocalenderEvents'),
          style: Theme.of(context).textTheme.small,
        ),
      ),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: fetchCalendarEventsModel.data!.length,
        itemBuilder: (BuildContext context, int index) {
          return Visibility(
              visible: fetchCalendarEventsModel.data![index].events.isNotEmpty,
              child: CalendarEventsBody(
                  calendarEventsDatum: fetchCalendarEventsModel.data![index]));
        },
      ),
    );
  }
}
