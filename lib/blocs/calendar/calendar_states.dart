import 'package:equatable/equatable.dart';

import '../../data/models/calendar/fetch_calendar_event_model.dart';

abstract class CalendarStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class CalendarInitialState extends CalendarStates {}

class FetchingCalendarEvents extends CalendarStates {}

class CalendarEventsFetched extends CalendarStates {
  final FetchCalendarEventsModel fetchCalendarEventsModel;
  final List calendarEvents;
  final DateTime selectedDate;

  CalendarEventsFetched(
      {required this.selectedDate,
      required this.calendarEvents,
      required this.fetchCalendarEventsModel});

  @override
  List<Object?> get props => [selectedDate];
}

class CalendarEventsNotFetched extends CalendarStates {
  final String eventsNotFetched;

  CalendarEventsNotFetched({required this.eventsNotFetched});
}
