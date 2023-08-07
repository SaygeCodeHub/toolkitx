import 'dart:developer';

import '../../data/models/calendar/fetch_calendar_event_model.dart';
import '../../utils/constants/api_constants.dart';
import '../../utils/dio_client.dart';
import 'calendar_repository.dart';

class CalendarRepositoryImpl extends CalendarRepository {
  @override
  Future<FetchCalendarEventsModel> fetchCalendarEvents(
      String userId, String hashCode, String dateTime, String type) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}timesheet/getevents2?userid=$userId&hashcode=$hashCode&date=$dateTime&type=$type");
    log("response=====>$response");
    return FetchCalendarEventsModel.fromJson(response);
  }
}
