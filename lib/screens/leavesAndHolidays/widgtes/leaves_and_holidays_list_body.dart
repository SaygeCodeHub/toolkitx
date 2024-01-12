import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/leavesAndHolidays/fetch_get_time_sheet_model.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_card.dart';

class LeavesAndHolidaysListBody extends StatelessWidget {
  const LeavesAndHolidaysListBody({
    super.key,
    required this.data,
    required this.isChecked,
  });

  final TimesheetData data;
  final bool isChecked;

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
                      height: 20,
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
                        : const Text('')
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
                      child: Padding(
                          padding: const EdgeInsets.only(
                              top: xxxSmallestSpacing,
                              bottom: xxxSmallestSpacing),
                          child: (data.dates[index].id != '' &&
                                  data.dates[index].hours != '-')
                              ? Checkbox(
                                  activeColor: AppColor.blueGrey,
                                  value: isChecked,
                                  onChanged: ((value) {}))
                              : const SizedBox.shrink()),
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
