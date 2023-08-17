import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:toolkit/blocs/calendar/calendar_states.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_card.dart';
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
                                  focusedDay: state.selectedDate,
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
                                    context.read<CalendarBloc>().add(
                                        SelectCalendarDate(
                                            calendarDate: date,
                                            fetchCalendarEventsModel: state
                                                .fetchCalendarEventsModel));
                                  },
                                  selectedDayPredicate: (DateTime date) {
                                    return isSameDay(state.selectedDate, date);
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
                                        color: AppColor.deepBlue),
                                  ),
                                  headerStyle: const HeaderStyle(
                                    formatButtonVisible: false,
                                    titleCentered: true,
                                    formatButtonShowsNext: false,
                                  ),
                                )),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.02),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.width * 0.03,
                                  bottom:
                                      MediaQuery.of(context).size.width * 0.03),
                              child: Row(
                                children: [
                                  Text(
                                    '',
                                    style: Theme.of(context).textTheme.small,
                                  ),
                                  const Expanded(
                                    child: Divider(
                                      indent: 10,
                                      endIndent: 10,
                                      thickness: 0.8,
                                      color: AppColor.grey,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            (state.calendarEvents.isEmpty)
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        top: MediaQuery.of(context).size.width *
                                            0.03),
                                    child: Center(
                                      child: Text(
                                        'No records found!',
                                        style:
                                            Theme.of(context).textTheme.small,
                                      ),
                                    ),
                                  )
                                : ListView.separated(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: state.calendarEvents.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return CustomCard(
                                        color: AppColor.lightGrey,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: ListTile(
                                          onTap: () {},
                                          dense: true,
                                          contentPadding:
                                              const EdgeInsets.all(10),
                                          title: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                state
                                                    .calendarEvents[index].name,
                                                style: const TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                              const SizedBox(
                                                  height: xxTinierSpacing),
                                              Text(state.calendarEvents[index]
                                                  .startDate),
                                              const SizedBox(
                                                  height: xxTinierSpacing),
                                              Text(state.calendarEvents[index]
                                                  .endDate),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02);
                                    },
                                  ),
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
