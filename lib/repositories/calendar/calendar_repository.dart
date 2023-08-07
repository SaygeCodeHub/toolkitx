import '../../data/models/calendar/fetch_calendar_event_model.dart';

abstract class CalendarRepository {
  Future<FetchCalendarEventsModel> fetchCalendarEvents(
      String userId, String hashCode, String dateTime, String type);
}
