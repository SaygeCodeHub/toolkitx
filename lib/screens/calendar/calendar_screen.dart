import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:toolkit/blocs/calendar/calendar_states.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/error_section.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../blocs/calendar/calendar_bloc.dart';
import '../../blocs/calendar/calendar_event.dart';
import '../../configs/app_color.dart';
import 'widgets/calendar_list_view.dart';
import 'widgets/calendar_section.dart';

class CalendarScreen extends StatelessWidget {
  static const routeName = 'CalendarScreen';

  CalendarScreen({Key? key}) : super(key: key);
  final String currentDate =
      "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";

  @override
  Widget build(BuildContext context) {
    context
        .read<CalendarBloc>()
        .add(FetchCalendarEvents(currentDate: currentDate));
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('CalenderView')),
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
                  return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(tiniestSpacing),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  decoration: BoxDecoration(
                                      color: AppColor.pastelBlue,
                                      borderRadius: BorderRadius.circular(
                                          kCalendarRadius)),
                                  width: kCalendarContainerWidth,
                                  child: TableCalendar(
                                    availableGestures:
                                        AvailableGestures.horizontalSwipe,
                                    onPageChanged: (date) {},
                                    focusedDay: DateTime.now(),
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
                                    ) {},
                                    selectedDayPredicate: (DateTime date) {
                                      return isSameDay(DateTime.now(), date);
                                    },
                                    eventLoader: (day) {
                                      return [];
                                    },
                                    calendarStyle: const CalendarStyle(
                                      isTodayHighlighted: false,
                                      selectedDecoration: BoxDecoration(
                                        color: AppColor.deepBlue,
                                        shape: BoxShape.circle,
                                      ),
                                      selectedTextStyle:
                                          TextStyle(color: AppColor.white),
                                      todayDecoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColor.deepBlue),
                                    ),
                                    headerStyle: const HeaderStyle(
                                      formatButtonVisible: false,
                                      titleCentered: true,
                                      formatButtonShowsNext: false,
                                    ),
                                  )),
                              const SizedBox(height: xxTinierSpacing)
                            ]),
                      ));
                } else if (state is CalendarEventsFetched) {
                  return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CalendarSection(
                                calendarEvents: state.calendarEvents,
                                selectedDate: state.selectedDate,
                                fetchCalendarEventsModel:
                                    state.fetchCalendarEventsModel),
                            const SizedBox(height: xxTinierSpacing),
                            CalendarListView(
                                calendarEvents: state.calendarEvents,
                                currentDate: state.currentDate),
                          ]));
                } else if (state is CalendarEventsNotFetched) {
                  return GenericReloadButton(
                      onPressed: () {
                        context
                            .read<CalendarBloc>()
                            .add(FetchCalendarEvents(currentDate: currentDate));
                      },
                      textValue: StringConstants.kReload);
                } else {
                  return const SizedBox.shrink();
                }
              }),
        ));
  }
}
