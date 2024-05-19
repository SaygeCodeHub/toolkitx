import '../../data/models/calendar/fetch_calendar_event_model.dart';

abstract class CalendarEvents {}

class FetchCalendarEvents extends CalendarEvents {
  final String currentDate;

  FetchCalendarEvents({required this.currentDate});
}

class SelectCalendarDate extends CalendarEvents {
  final DateTime selectedDate;
  final FetchCalendarEventsModel fetchCalendarEventsModel;

  SelectCalendarDate(
      {required this.fetchCalendarEventsModel, required this.selectedDate});
}

class UpdateSelectedDate extends CalendarEvents {
  final DateTime selectedDate;

  UpdateSelectedDate({required this.selectedDate});
}
