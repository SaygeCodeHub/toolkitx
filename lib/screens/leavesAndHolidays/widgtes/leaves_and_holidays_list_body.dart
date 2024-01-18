import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/leavesAndHolidays/fetch_get_time_sheet_model.dart';
import 'package:toolkit/screens/leavesAndHolidays/timesheet_checkin_screen.dart';

import '../../../blocs/leavesAndHolidays/leaves_and_holidays_bloc.dart';
import '../../../blocs/leavesAndHolidays/leaves_and_holidays_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_card.dart';
import '../leaves_and_holidays_checkbox.dart';

class LeavesAndHolidaysListBody extends StatelessWidget {
  const LeavesAndHolidaysListBody({
    super.key,
    required this.data,
    required this.isChecked,
  });

  final TimesheetData data;
  final bool isChecked;
  static List leavesAndHolidaysIdList = [];
  static int index = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
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
                      arguments: timeSheetMap);
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
                    BlocBuilder<LeavesAndHolidaysBloc, LeavesAndHolidaysStates>(
                      buildWhen: (previous, currentState) =>
                          currentState is GetTimeSheetFetching ||
                          currentState is GetTimeSheetFetched ||
                          currentState is GetTimeSheetNotFetched,
                      builder: (context, state) {
                        if (state is GetTimeSheetFetched) {
                          return Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    top: xxxSmallestSpacing,
                                    bottom: xxxSmallestSpacing),
                                child: (data.dates[index].id != '' &&
                                        data.dates[index].hours != '-')
                                    ? TimeSheetCheckbox(
                                        selectedCreatedForIdList:
                                            leavesAndHolidaysIdList,
                                        id: state.fetchTimeSheetModel.data
                                            .dates[index].id,
                                        onCreatedForChanged:
                                            (List<dynamic> idList) {},
                                        idList: const [],
                                      )
                                    : const SizedBox.shrink()),
                          );
                        } else if (state is GetTimeSheetNotFetched) {
                          return const Text(StringConstants.kDataNotCorrect);
                        }
                        return const SizedBox.shrink();
                      },
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
