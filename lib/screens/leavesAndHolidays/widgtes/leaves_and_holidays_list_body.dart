import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/leavesAndHolidays/fetch_get_time_sheet_model.dart';

import '../../../blocs/leavesAndHolidays/leaves_and_holidays_bloc.dart';
import '../../../blocs/leavesAndHolidays/leaves_and_holidays_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_card.dart';
import '../leaves_and_holidays_checkbox.dart';
import '../timesheet_checkin_screen.dart';

class LeavesAndHolidaysListBody extends StatelessWidget {
  const LeavesAndHolidaysListBody({
    super.key,
    required this.data,
    required this.isChecked,
  });

  final TimesheetData data;
  final bool isChecked;
  static List leavesAndHolidaysIdList = [];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          addIds(data.dates[index].hours, data.dates[index].id,
              data.dates[index].status, leavesAndHolidaysIdList);
          log("leavesAndHolidaysIdList================>$leavesAndHolidaysIdList");
          return CustomCard(
            elevation: xxTiniestSpacing,
            child: Padding(
              padding: const EdgeInsets.all(xxTinierSpacing),
              child: ListTile(
                onTap: () {
                  Map timeSheetMap = {
                    'date': data.dates[index].fulldate,
                    'status': data.dates[index].status
                  };
                  Navigator.pushNamed(context, TimeSheetCheckInScreen.routeName,
                          arguments: timeSheetMap)
                      .then((_) => context.read<LeavesAndHolidaysBloc>().add(
                          GetTimeSheet(
                              month: context
                                          .read<LeavesAndHolidaysBloc>()
                                          .month ==
                                      ''
                                  ? DateFormat('M').format(DateTime.now())
                                  : context.read<LeavesAndHolidaysBloc>().month,
                              year: context
                                          .read<LeavesAndHolidaysBloc>()
                                          .year ==
                                      ''
                                  ? DateFormat('yyyy').format(DateTime.now())
                                  : context
                                      .read<LeavesAndHolidaysBloc>()
                                      .year)));
                },
                title: Row(
                  children: [
                    Text("${data.dates[index].day} ${data.dates[index].date}",
                        style: Theme.of(context).textTheme.small.copyWith(
                            fontWeight: FontWeight.w500,
                            color: (data.dates[index].isweekend != "1")
                                ? AppColor.black
                                : AppColor.errorRed)),
                    const SizedBox(width: tinierSpacing),
                    (data.dates[index].id != '' &&
                            data.dates[index].hours != '-')
                        ? Text('[${StringConstants.kDraft}]',
                            style: Theme.of(context).textTheme.small.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColor.errorRed))
                        : const SizedBox.shrink(),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: tinierSpacing),
                    Text(data.dates[index].hours,
                        style: Theme.of(context).textTheme.xSmall.copyWith(
                            fontWeight: FontWeight.w400, color: AppColor.grey)),
                    const SizedBox(height: tinierSpacing),
                    Text(
                        "${StringConstants.kSubmissionDate} ${data.dates[index].submissionDate}",
                        style: Theme.of(context).textTheme.xSmall.copyWith(
                            fontWeight: FontWeight.w400, color: AppColor.grey)),
                    const SizedBox(
                      height: xxxSmallestSpacing,
                    ),
                    data.dates[index].isoverdue == "1"
                        ? const CustomCard(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(xxxTiniestSpacing))),
                            color: AppColor.yellow,
                            child: Padding(
                              padding: EdgeInsets.all(xxxTinierSpacing),
                              child: Text(
                                StringConstants.kOverdue,
                                style: TextStyle(color: AppColor.white),
                              ),
                            ))
                        : const SizedBox.shrink()
                  ],
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    data.dates[index].status == 1
                        ? const Text(
                            StringConstants.kSubmitted,
                            style: TextStyle(color: AppColor.deepBlue),
                          )
                        : const Text(StringConstants.kNotSubmitted,
                            style: TextStyle(color: AppColor.deepBlue)),
                    Expanded(
                      child: ((data.dates[index].id != '' &&
                              (data.dates[index].hours != '-' ||
                                  data.dates[index].hours == '-') &&
                              data.dates[index].status == 0))
                          ? TimeSheetCheckbox(
                              selectedCreatedForIdList: leavesAndHolidaysIdList,
                              id: data.dates[index].id,
                              onCreatedForChanged: (List<dynamic> idList) {
                                context
                                    .read<LeavesAndHolidaysBloc>()
                                    .timeSheetIdList
                                    .add({
                                  "id": idList
                                      .toString()
                                      .replaceAll('[', "")
                                      .replaceAll(']', "")
                                      .replaceAll(',', ",")
                                });
                              },
                            )
                          : const SizedBox.shrink(),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: tinierSpacing);
        },
        itemCount: data.dates.length);
  }
}

addIds(String hours, String id, int status, List leavesAndHolidaysIdList) {
  if (id != '' && (hours != '-' || hours == '-') && status == 0) {
    if (leavesAndHolidaysIdList
            .indexWhere((element) => element.toString().trim() == id.trim()) ==
        -1) {
      leavesAndHolidaysIdList.add(id);
    }
  }
}
