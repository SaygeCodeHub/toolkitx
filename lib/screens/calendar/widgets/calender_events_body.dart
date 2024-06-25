import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/calendar/fetch_calendar_event_model.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_card.dart';
import '../../workorder/workorder_details_tab_screen.dart';

class CalendarEventsBody extends StatelessWidget {
  const CalendarEventsBody({
    super.key,
    required this.calendarEventsDatum,
  });

  final CalendarEventsDatum calendarEventsDatum;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              top: xxTinierSpacing, bottom: xxTinierSpacing),
          child: Row(
            children: [
              Text(
                calendarEventsDatum.fulldate,
                style: Theme.of(context).textTheme.small,
              ),
              const Expanded(
                child: Divider(
                  indent: kDividerIndent,
                  endIndent: kDividerEndIndent,
                  thickness: 1,
                  color: AppColor.grey,
                ),
              )
            ],
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: calendarEventsDatum.events.length,
          itemBuilder: (context, dataIndex) {
            return CustomCard(
              color: Colors.blue.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kCardRadius),
              ),
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(
                      context, WorkOrderDetailsTabScreen.routeName,
                      arguments: calendarEventsDatum.events[dataIndex].id);
                },
                dense: true,
                contentPadding: const EdgeInsets.all(xxTinierSpacing),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            calendarEventsDatum.events[dataIndex].name,
                            style: Theme.of(context).textTheme.xSmall.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        const SizedBox(width: xxTiniestSpacing),
                        Text(calendarEventsDatum.events[dataIndex].time),
                      ],
                    ),
                    const SizedBox(height: xxTinierSpacing),
                    Row(
                      children: [
                        Text('${DatabaseUtil.getText('StartDate')}:'),
                        const SizedBox(width: xxTiniestSpacing),
                        Text(calendarEventsDatum.events[dataIndex].startDate),
                      ],
                    ),
                    const SizedBox(height: xxTinierSpacing),
                    Row(
                      children: [
                        Text('${DatabaseUtil.getText('EndDate')}:'),
                        const SizedBox(width: xxTiniestSpacing),
                        Text(calendarEventsDatum.events[dataIndex].endDate),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int dataIndex) {
            return const SizedBox(height: xxTinierSpacing);
          },
        ),
      ],
    );
  }
}
