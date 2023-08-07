import '../../data/models/calendar/fetch_calendar_event_model.dart';

abstract class CalendarStates {}

class CalendarInitialState extends CalendarStates {}

class FetchingCalendarEvents extends CalendarStates {}

class CalendarEventsFetched extends CalendarStates {
  final FetchCalendarEventsModel fetchCalendarEventsModel;

  CalendarEventsFetched({required this.fetchCalendarEventsModel});
}

class CalendarEventsNotFetched extends CalendarStates {
  final String eventsNotFetched;

  CalendarEventsNotFetched({required this.eventsNotFetched});
}
