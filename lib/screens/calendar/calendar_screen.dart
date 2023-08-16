import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:toolkit/blocs/calendar/calendar_states.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/error_section.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../blocs/calendar/calendar_bloc.dart';
import '../../blocs/calendar/calendar_event.dart';
import '../../configs/app_color.dart';

class CalendarScreen extends StatelessWidget {
  static const routeName = 'CalendarScreen';

  CalendarScreen({Key? key}) : super(key: key);
  final DateFormat formatter = DateFormat('dd.MM.yyyy');

  @override
  Widget build(BuildContext context) {
    context.read<CalendarBloc>().add(FetchCalendarEvents());
    return Scaffold(
        appBar: const GenericAppBar(title: 'Calendar View'),
        body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxTinierSpacing),
          child: BlocBuilder<CalendarBloc, CalendarStates>(
              buildWhen: (previousState, currentState) =>
              currentState is FetchingCalendarEvents ||
                  currentState is CalendarEventsFetched,
              builder: (context, state) {
                if (state is FetchingCalendarEvents) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CalendarEventsFetched) {
                  return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    borderRadius: BorderRadius.circular(30)),
                                width: MediaQuery.of(context).size.width * 0.99,
                                child: TableCalendar(
                                  availableGestures:
                                      AvailableGestures.horizontalSwipe,
                                  onPageChanged: (page) {},
                                  focusedDay: DateFormat("dd.MM.yyy").parse(
                                      (context
                                                  .read<CalendarBloc>()
                                                  .selectedDateFromCalendar
                                                  .toString() ==
                                              'null')
                                          ? formatter.format(DateTime.now())
                                          : context
                                              .read<CalendarBloc>()
                                              .selectedDateFromCalendar!),
                                  firstDay: DateTime(1900),
                                  lastDay: DateTime(9000),
                                  calendarFormat:
                                      context.read<CalendarBloc>().format,
                                  onFormatChanged: (CalendarFormat format) {
                                    format =
                                        context.read<CalendarBloc>().format;
                                  },
                                  startingDayOfWeek: StartingDayOfWeek.sunday,
                                  daysOfWeekVisible: true,
                                  onDaySelected: (
                                    DateTime date,
                                    events,
                                  ) {
                                    context.read<CalendarBloc>().onTapOfDay(
                                        date, state.fetchCalendarEventsModel);
                                  },
                                  selectedDayPredicate: (DateTime date) {
                                    log("on selected day=====>${context.read<CalendarBloc>().selectedDateFromCalendar.toString()}");
                                    return isSameDay(
                                        DateFormat('dd.MM.yyy').parse((context
                                                    .read<CalendarBloc>()
                                                    .selectedDateFromCalendar
                                                    .toString() ==
                                                'null')
                                            ? formatter.format(DateTime.now())
                                            : context
                                                .read<CalendarBloc>()
                                                .selectedDateFromCalendar!),
                                        date);
                                  },
                                  eventLoader: (day) {
                                    return context
                                        .read<CalendarBloc>()
                                        .getEventsForDay(day,
                                            state.fetchCalendarEventsModel);
                                  },
                                  calendarStyle: const CalendarStyle(
                                    isTodayHighlighted: true,
                                    selectedDecoration: BoxDecoration(
                                      color: AppColor.deepBlue,
                                      shape: BoxShape.circle,
                                    ),
                                    selectedTextStyle:
                                        TextStyle(color: AppColor.white),
                                    todayDecoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColor.orange),
                                  ),
                                  headerStyle: const HeaderStyle(
                                    formatButtonVisible: false,
                                    titleCentered: true,
                                    formatButtonShowsNext: false,
                                  ),
                                )),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.02)
                          ]));
                } else if (state is CalendarEventsNotFetched) {
                  return GenericReloadButton(
                      onPressed: () {
                        context.read<CalendarBloc>().add(FetchCalendarEvents());
                      },
                      textValue: StringConstants.kReload);
                } else {
                  return const SizedBox.shrink();
                }
              }),
        ));
  }
}
