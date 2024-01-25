import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toolkit/blocs/leavesAndHolidays/leaves_and_holidays_events.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/leavesAndHolidays/widgtes/data_picker_text.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/secondary_button.dart';

import '../../blocs/leavesAndHolidays/leaves_and_holidays_bloc.dart';
import '../../blocs/leavesAndHolidays/leaves_and_holidays_states.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/leavesAndHolidays/fetch_get_time_sheet_model.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/progress_bar.dart';
import 'leaves_and_holidays_checkbox.dart';
import 'leaves_details_screen.dart';
import 'leaves_summary_screen.dart';
import 'widgtes/leaves_and_holidays_list_body.dart';

class LeavesAndHolidaysScreen extends StatelessWidget {
  static const routeName = 'LeavesAndHolidaysScreen';

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
        floatingActionButton:
            BlocListener<LeavesAndHolidaysBloc, LeavesAndHolidaysStates>(
          listener: (context, state) {
            if (state is TimeSheetSubmitting) {
              ProgressBar.show(context);
            } else if (state is TimeSheetSubmitted) {
              ProgressBar.dismiss(context);
              context.read<LeavesAndHolidaysBloc>().timeSheetIdList.clear();
              TimeSheetCheckbox.idsList.clear();
              context.read<LeavesAndHolidaysBloc>().add(GetTimeSheet(
                  month: context.read<LeavesAndHolidaysBloc>().month == ''
                      ? DateFormat('M').format(DateTime.now())
                      : context.read<LeavesAndHolidaysBloc>().month,
                  year: context.read<LeavesAndHolidaysBloc>().year == ''
                      ? DateFormat('yyyy').format(DateTime.now())
                      : context.read<LeavesAndHolidaysBloc>().year));
            } else if (state is TimeSheetNotSubmitted) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.errorMessage, "");
            }
          },
          child: FloatingActionButton(
              onPressed: () {
                context
                    .read<LeavesAndHolidaysBloc>()
                    .add(SubmitTimeSheet(submitTimeSheetMap: {
                      "idm":
                          context.read<LeavesAndHolidaysBloc>().timeSheetIdList,
                      "timesheetids":
                          context.read<LeavesAndHolidaysBloc>().timeSheetIdList
                    }));
              },
              child: const Icon(Icons.check)),
        ),
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
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        CheckBoxWidget(
                            dates: state.fetchTimeSheetModel.data.dates)
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

class CheckBoxWidget extends StatefulWidget {
  final List<Date> dates;

  const CheckBoxWidget({super.key, required this.dates});

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(StringConstants.kSelectAll,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(fontWeight: FontWeight.w500)),
        Checkbox(
          activeColor: AppColor.deepBlue,
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value!;
            });
            context
                .read<LeavesAndHolidaysBloc>()
                .add(SelectAllCheckBox(dates: widget.dates));
          },
        ),
      ],
    );
  }
}
