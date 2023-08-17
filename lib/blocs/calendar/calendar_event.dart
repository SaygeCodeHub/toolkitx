import '../../data/models/calendar/fetch_calendar_event_model.dart';

abstract class CalendarEvents {}

class FetchCalendarEvents extends CalendarEvents {}

class SelectCalendarDate extends CalendarEvents {
  final DateTime calendarDate;
  final FetchCalendarEventsModel fetchCalendarEventsModel;

  SelectCalendarDate(
      {required this.fetchCalendarEventsModel, required this.calendarDate});
}
