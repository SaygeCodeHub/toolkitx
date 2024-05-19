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

  FutureOr<void> _fetchCalendarEvents(
      FetchCalendarEvents event, Emitter<CalendarStates> emit) async {
    emit(FetchingCalendarEvents());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      FetchCalendarEventsModel fetchCalendarEventsModel =
          await _calendarRepository.fetchCalendarEvents(
              userId!, hashCode!, event.currentDate, 'month');
      emit(CalendarEventsFetched(
          fetchCalendarEventsModel: fetchCalendarEventsModel,
          calendarEvents: eventsList,
          selectedDate: DateTime.now(),
          currentDate: ''));
    } catch (e) {
      emit(CalendarEventsNotFetched(eventsNotFetched: e.toString()));
    }
  }

  _selectCalendarDate(SelectCalendarDate event, Emitter<CalendarStates> emit) {
    selectedDateFromCalendar = formatter.format(event.selectedDate);
    eventsList = event.fetchCalendarEventsModel.data!
        .where((item) => item.fulldate == selectedDateFromCalendar)
        .expand((item) => item.events)
        .toList();
    String currentDate =
        "${event.selectedDate.day}/${event.selectedDate.month}/${event.selectedDate.year}";
    emit(CalendarEventsFetched(
        fetchCalendarEventsModel: event.fetchCalendarEventsModel,
        calendarEvents: eventsList,
        selectedDate: event.selectedDate,
        currentDate: currentDate));
  }

  List<Object> getEventsForDay(
      DateTime day, FetchCalendarEventsModel fetchCalendarEventsModel) {
    List<CalendarEvent> calendarEvents = [];
    calendarEvents.clear();
    calendarEvents = fetchCalendarEventsModel.data!
        .where((data) => data.fulldate == formatter.format(day))
        .expand((data) => data.events)
        .toList();
    return calendarEvents;
  }

  void updateCalendarFormat(CalendarFormat newFormat) {
    format = newFormat;
  }
}
