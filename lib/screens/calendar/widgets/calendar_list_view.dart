import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_card.dart';

class CalendarListView extends StatelessWidget {
  final List calendarEvents;
  final String currentDate;

  const CalendarListView(
      {Key? key, required this.calendarEvents, required this.currentDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: calendarEvents.isEmpty,
      replacement: ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: calendarEvents.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: xxTinierSpacing, bottom: xxTinierSpacing),
                child: Row(
                  children: [
                    Text(currentDate, style: Theme.of(context).textTheme.small),
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
              CustomCard(
                color: Colors.blue.shade50,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kCardRadius),
                ),
                child: ListTile(
                  onTap: () {},
                  dense: true,
                  contentPadding: const EdgeInsets.all(xxTinierSpacing),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            calendarEvents[index].name,
                            style: Theme.of(context)
                                .textTheme
                                .xSmall
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: xxTiniestSpacing),
                          Text(calendarEvents[index].time),
                        ],
                      ),
                      const SizedBox(height: xxTinierSpacing),
                      Row(
                        children: [
                          Text('${DatabaseUtil.getText('StartDate')}:'),
                          const SizedBox(width: xxTiniestSpacing),
                          Text(calendarEvents[index].startDate),
                        ],
                      ),
                      const SizedBox(height: xxTinierSpacing),
                      Row(
                        children: [
                          Text('${DatabaseUtil.getText('EndDate')}:'),
                          const SizedBox(width: xxTiniestSpacing),
                          Text(calendarEvents[index].endDate),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: xxTinySpacing);
        },
      ),
      child: Center(
        child: Text(DatabaseUtil.getText('nocalenderEvents'),
            style: Theme.of(context).textTheme.small),
      ),
    );
  }
}
