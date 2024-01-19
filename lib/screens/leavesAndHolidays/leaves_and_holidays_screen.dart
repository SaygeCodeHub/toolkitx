import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toolkit/blocs/leavesAndHolidays/leaves_and_holidays_events.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/screens/leavesAndHolidays/widgtes/data_picker_text.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/secondary_button.dart';

import '../../blocs/leavesAndHolidays/leaves_and_holidays_bloc.dart';
import '../../blocs/leavesAndHolidays/leaves_and_holidays_states.dart';
import '../../configs/app_spacing.dart';
import 'leaves_details_screen.dart';
import 'leaves_summary_screen.dart';
import 'widgtes/leaves_and_holidays_list_body.dart';

class LeavesAndHolidaysScreen extends StatelessWidget {
  static const routeName = 'LeavesAndHolidaysScreen';
  static List leavesAndHolidaysIdList = [];

  const LeavesAndHolidaysScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isChecked = false;
    context.read<LeavesAndHolidaysBloc>().month = '';
    context.read<LeavesAndHolidaysBloc>().year = '';
    context.read<LeavesAndHolidaysBloc>().add(GetTimeSheet(
        month: context.read<LeavesAndHolidaysBloc>().month == ''
            ? DateFormat('M').format(DateTime.now())
            : context.read<LeavesAndHolidaysBloc>().month,
        year: context.read<LeavesAndHolidaysBloc>().year == ''
            ? DateFormat('yyyy').format(DateTime.now())
            : context.read<LeavesAndHolidaysBloc>().year));

    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('TimeAndVacation')),
        body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxTinierSpacing),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(
                  child: SecondaryButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, LeavesDetailsScreen.routeName);
                      },
                      textValue: StringConstants.kLeaveDetails)),
              const SizedBox(width: xxTinierSpacing),
              Expanded(
                  child: SecondaryButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, LeavesSummaryScreen.routeName);
                      },
                      textValue: DatabaseUtil.getText('leave_summary')))
            ]),
            DatePickerTextButton(
                onDateChanged: (String date) {}, maxDate: DateTime.now()),
            const SizedBox(height: tiniestSpacing),
            const Divider(
                color: AppColor.blueGrey, thickness: xxxTiniestSpacing),
            const SizedBox(height: tiniestSpacing),
            BlocBuilder<LeavesAndHolidaysBloc, LeavesAndHolidaysStates>(
                buildWhen: (previous, currentState) =>
                    currentState is GetTimeSheetFetching ||
                    currentState is GetTimeSheetFetched ||
                    currentState is GetTimeSheetNotFetched,
                builder: (context, state) {
                  if (state is GetTimeSheetFetching) {
                    return const Expanded(
                        child: Center(child: CircularProgressIndicator()));
                  } else if (state is GetTimeSheetFetched) {
                    var data = state.fetchTimeSheetModel.data;
                    return Expanded(
                        child: Column(children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(StringConstants.kSubmissionPeriod),
                            Text(StringConstants.kMonthly)
                          ]),
                      const SizedBox(height: xxTinierSpacing),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(StringConstants.kMethodOfReporting),
                            Text(StringConstants.kRegularReporting),
                          ]),
                      const SizedBox(height: smallerSpacing),
                      const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(StringConstants.kSubmitAll),
                            // SizedBox(
                            //     width: smallerSpacing,
                            //     child: TimeSheetCheckbox(
                            //       id: data.dates[].status,
                            //       idList: [],
                            //       onCreatedForChanged: (idList) {},
                            //       selectedCreatedForIdList: [],
                            //     ))
                          ]),
                      Expanded(
                          child: LeavesAndHolidaysListBody(
                              data: data, isChecked: isChecked))
                    ]));
                  } else if (state is GetTimeSheetNotFetched) {
                    return const Text(StringConstants.kDataNotCorrect);
                  }
                  return const SizedBox.shrink();
                })
          ]),
        ));
  }
}
