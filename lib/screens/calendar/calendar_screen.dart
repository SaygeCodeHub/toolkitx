import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/models/calendar/fetch_calendar_event_model.dart';
import '../../di/app_module.dart';
import '../../repositories/calendar/calendar_repository.dart';
import 'widgets/calendar_list_view.dart';

class CalendarScreen extends StatefulWidget {
  static const routeName = 'CalendarScreen';

  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final CalendarRepository _calendarRepository = getIt<CalendarRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  FetchCalendarEventsModel fetchCalendarEventsModel =
      FetchCalendarEventsModel();

  DateFormat formatter = DateFormat('dd.MM.yyyy');
  String? selectedDateFromCalendar;
  CalendarFormat format = CalendarFormat.month;

  late DateTime _selectedDay = DateTime.now();
  late DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _fetchCalendarEvents(_focusedDay);
  }

  Future<void> _fetchCalendarEvents(DateTime month) async {
    String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
    String? userId = await _customerCache.getUserId(CacheKeys.userId);
    FetchCalendarEventsModel? fetchedCalendarEventsModel =
        await _calendarRepository.fetchCalendarEvents(
            userId!, hashCode!, _formatDate(month), 'month');
    if (fetchedCalendarEventsModel.data != null) {
      setState(() {
        fetchCalendarEventsModel = fetchedCalendarEventsModel;
      });
    }
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  List<Object> getEventsForDay(DateTime day) {
    List<CalendarEvent> calendarEvents = [];
    if (fetchCalendarEventsModel.data != null) {
      calendarEvents = fetchCalendarEventsModel.data!
          .where((data) => data.fulldate == formatter.format(day))
          .expand((data) => data.events)
          .toList();
    }
    return calendarEvents;
  }

  int calculateEventsLoaderCount() {
    return fetchCalendarEventsModel.data?.length ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('CalenderView')),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing),
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                    padding: const EdgeInsets.all(tiniestSpacing),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              decoration: BoxDecoration(
                                color: AppColor.pastelBlue,
                                borderRadius:
                                    BorderRadius.circular(kCalendarRadius),
                              ),
                              width: kCalendarContainerWidth,
                              child: TableCalendar(
                                  availableGestures: AvailableGestures.all,
                                  onPageChanged: (date) {
                                    setState(() {
                                      _focusedDay = date;
                                    });
                                    _fetchCalendarEvents(date);
                                  },
                                  focusedDay: _focusedDay,
                                  firstDay: DateTime(1900),
                                  lastDay: DateTime(2100),
                                  calendarFormat: format,
                                  onFormatChanged: (CalendarFormat format) {
                                    setState(() {
                                      this.format = format;
                                    });
                                  },
                                  startingDayOfWeek: StartingDayOfWeek.monday,
                                  daysOfWeekVisible: true,
                                  selectedDayPredicate: (DateTime date) {
                                    return isSameDay(_selectedDay, date);
                                  },
                                  onDaySelected: (selectedDate, focusedDate) {
                                    if (getEventsForDay(selectedDate)
                                        .isNotEmpty) {
                                      setState(() {
                                        selectedDateFromCalendar =
                                            _formatDate(selectedDate);
                                        _selectedDay = selectedDate;
                                      });
                                      _fetchCalendarEvents(selectedDate);
                                    }
                                  },
                                  eventLoader: (day) {
                                    return getEventsForDay(day);
                                  },
                                  calendarStyle: const CalendarStyle(
                                      isTodayHighlighted: false,
                                      selectedDecoration: BoxDecoration(
                                          color: AppColor.deepBlue,
                                          shape: BoxShape.circle),
                                      selectedTextStyle:
                                          TextStyle(color: AppColor.white),
                                      todayDecoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColor.deepBlue)),
                                  headerStyle: const HeaderStyle(
                                      formatButtonVisible: false,
                                      titleCentered: true,
                                      formatButtonShowsNext: false),
                                  enabledDayPredicate: (DateTime date) {
                                    return getEventsForDay(date).isNotEmpty;
                                  })),
                          const SizedBox(height: xxTinierSpacing),
                          if (fetchCalendarEventsModel.data != null &&
                              fetchCalendarEventsModel.data!.isNotEmpty)
                            CalendarListView(
                                calendarEvents: fetchCalendarEventsModel.data!
                                    .expand((eventData) => eventData.events)
                                    .toList(),
                                currentDate: _formatDate(_selectedDay),
                                eventsLoaderCount: calculateEventsLoaderCount(),
                                fetchCalendarEventsModel:
                                    fetchCalendarEventsModel)
                        ])))));
  }
}
