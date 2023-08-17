import 'dart:async';
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
    on<SelectCalendarDate>(_selectCalendarDate);
  }

  DateFormat formatter = DateFormat('dd.MM.yyyy');
  List eventsList = [];
  String? selectedDateFromCalendar;
  CalendarFormat format = CalendarFormat.month;
  String pageChangeMonth = "${DateTime.now().month}-${DateTime.now().year}";

  FutureOr<void> _fetchCalendarEvents(
      FetchCalendarEvents event, Emitter<CalendarStates> emit) async {
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      FetchCalendarEventsModel fetchCalendarEventsModel =
          await _calendarRepository.fetchCalendarEvents(
              userId!, hashCode!, formatter.format(DateTime.now()), 'month');
      emit(CalendarEventsFetched(
          fetchCalendarEventsModel: fetchCalendarEventsModel,
          calendarEvents: eventsList,
          selectedDate: DateTime.now()));
    } catch (e) {
      emit(CalendarEventsNotFetched(eventsNotFetched: e.toString()));
    }
  }

  _selectCalendarDate(SelectCalendarDate event, Emitter<CalendarStates> emit) {
    eventsList.clear();
    selectedDateFromCalendar = formatter.format(event.calendarDate);
    for (var item in event.fetchCalendarEventsModel.data!) {
      if (item.fulldate == selectedDateFromCalendar) {
        eventsList.addAll(item.events);
      }
    }
    emit(CalendarEventsFetched(
        fetchCalendarEventsModel: event.fetchCalendarEventsModel,
        calendarEvents: eventsList,
        selectedDate: event.calendarDate));
  }

  List<Object> getEventsForDay(
      DateTime day, FetchCalendarEventsModel fetchCalendarEventsModel) {
    List<CalendarEvent> calendarEvents = [];
    for (int i = 0; i < fetchCalendarEventsModel.data!.length; i++) {
      if (fetchCalendarEventsModel.data![i].fulldate == formatter.format(day)) {
        calendarEvents.addAll(fetchCalendarEventsModel.data![i].events);
      }
    }
    return calendarEvents;
  }
}
