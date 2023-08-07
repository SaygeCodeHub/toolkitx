import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:toolkit/repositories/calendar/calendar_repository.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../../di/app_module.dart';
import '../../data/cache/cache_keys.dart';
import '../../data/models/calendar/fetch_calendar_event_model.dart';
import 'calendar_event.dart';
import 'calendar_states.dart';

class CalendarBloc extends Bloc<CalendarEvents, CalendarStates> {
  final CalendarRepository _calendarRepository = getIt<CalendarRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  FetchCalendarEventsModel fetchCalendarEventsModel =
      FetchCalendarEventsModel();

  CalendarStates get initialState => CalendarInitialState();

  CalendarBloc() : super(CalendarInitialState()) {
    on<FetchCalendarEvents>(_fetchCalendarEvents);
  }

  final DateFormat formatter = DateFormat('dd.MM.yyyy');

  FutureOr<void> _fetchCalendarEvents(
      FetchCalendarEvents event, Emitter<CalendarStates> emit) async {
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      String selectedDateFromCalendar = '';
      final DateFormat formatter = DateFormat('dd.MM.yyyy');
      List formattedList = [];
      CalendarFormat format = CalendarFormat.month;
      String pageChangeMonth = "${DateTime.now().month}-${DateTime.now().year}";
      FetchCalendarEventsModel fetchCalendarEventsModel =
          await _calendarRepository.fetchCalendarEvents(
              '2ATY8mLx8MjkcnrmiRLvrA==',
              'vbdvrj9aN/gnmG9HRZBOV137+VBlDH1innvdsfSI8lOHTShvQP8iAcfeuRbflSG0|3|1|1|west_2',
              '01/6/2023',
              'month');
      log("model data====>$fetchCalendarEventsModel");
      emit(CalendarEventsFetched(
          fetchCalendarEventsModel: fetchCalendarEventsModel));
    } catch (e) {}
  }

  List<Object> getEventsForDay(
      DateTime day, FetchCalendarEventsModel fetchCalendarEventsModel) {
    List<CalendarEvent> calendarEvents = [];
    for (int i = 0; i < fetchCalendarEventsModel.data!.length; i++) {
      if (fetchCalendarEventsModel.data![i].fulldate == formatter.format(day)) {
        calendarEvents.addAll(fetchCalendarEventsModel.data![i].events);
        log("string=====>$calendarEvents");
      }
    }
    return calendarEvents;
  }
}
