import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/leavesAndHolidays/add_and_edit_timesheet_screen.dart';
import 'package:toolkit/widgets/error_section.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import '../../blocs/leavesAndHolidays/leaves_and_holidays_bloc.dart';
import '../../blocs/leavesAndHolidays/leaves_and_holidays_events.dart';
import '../../blocs/leavesAndHolidays/leaves_and_holidays_states.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/custom_snackbar.dart';
import 'widgtes/timesheet_checkin_body.dart';

class TimeSheetCheckInScreen extends StatelessWidget {
  static const routeName = 'TimesheetCheckInScreen';

  const TimeSheetCheckInScreen(
      {super.key,
      required this.timeSheetMap,
      required this.submitTimeSheetMap});

  final Map timeSheetMap;
  final Map submitTimeSheetMap;

  @override
  Widget build(BuildContext context) {
    context
        .read<LeavesAndHolidaysBloc>()
        .add(FetchCheckInTimeSheet(date: timeSheetMap['date']));
    return Scaffold(
      appBar: GenericAppBar(
        title: timeSheetMap['date'],
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: xxTinierSpacing),
              child: Text(
                  timeSheetMap['status'] == 1 ? StringConstants.kSubmitted : '',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: AppColor.deepBlue)),
            ),
          ),
        ],
      ),
      body: BlocConsumer<LeavesAndHolidaysBloc, LeavesAndHolidaysStates>(
        buildWhen: (previous, currentState) =>
            currentState is CheckInTimeSheetFetching ||
            currentState is CheckInTimeSheetFetched ||
            currentState is CheckInTimeSheetNotFetched,
        builder: (context, state) {
          if (state is CheckInTimeSheetFetching) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CheckInTimeSheetFetched) {
            var data = state.fetchCheckInTimeSheetModel.data;
            return TimeSheetCheckInBody(
                checkInList: data.checkins, timeSheetMap: timeSheetMap);
          } else if (state is CheckInTimeSheetNotFetched) {
            return Center(
              child: GenericReloadButton(
                  onPressed: () {
                    context
                        .read<LeavesAndHolidaysBloc>()
                        .add(FetchCheckInTimeSheet(date: timeSheetMap['date']));
                  },
                  textValue: StringConstants.kReload),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
        listener: (BuildContext context, LeavesAndHolidaysStates state) {
          if (state is TimeSheetDeleting) {
            ProgressBar.show(context);
          } else if (state is TimeSheetDeleted) {
            ProgressBar.dismiss(context);
            Navigator.pop(context);
            context
                .read<LeavesAndHolidaysBloc>()
                .add(FetchCheckInTimeSheet(date: timeSheetMap['date']));
          } else if (state is TimeSheetNotDeleted) {
            ProgressBar.dismiss(context);
            showCustomSnackBar(context, state.errorMessage, "");
          }
          if (state is TimeSheetSubmitting) {
            ProgressBar.show(context);
          } else if (state is TimeSheetSubmitted) {
            ProgressBar.dismiss(context);
            Navigator.pop(context);
            showCustomSnackBar(
                context, StringConstants.kTimeSheetSubmittedSuccessfully, "");
          } else if (state is TimeSheetNotSubmitted) {
            ProgressBar.dismiss(context);
            showCustomSnackBar(context, state.errorMessage, "");
          }
        },
      ),
      bottomNavigationBar: Visibility(
        visible: timeSheetMap['status'] == 0,
        child: Padding(
          padding: const EdgeInsets.all(xxTinierSpacing),
          child: BlocBuilder<LeavesAndHolidaysBloc, LeavesAndHolidaysStates>(
            buildWhen: (previous, currentState) =>
                currentState is CheckInTimeSheetFetching ||
                currentState is CheckInTimeSheetFetched,
            builder: (context, state) {
              if (state is CheckInTimeSheetFetching) {
                return const SizedBox.shrink();
              } else if (state is CheckInTimeSheetFetched) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: PrimaryButton(
                            onPressed: () {
                              AddAndEditTimeSheetScreen
                                      .saveTimeSheetMap['date'] =
                                  timeSheetMap['date'];
                              Navigator.pushNamed(
                                  context, AddAndEditTimeSheetScreen.routeName);
                            },
                            textValue: StringConstants.kAddTimeSheet)),
                    Visibility(
                      visible: state
                          .fetchCheckInTimeSheetModel.data.checkins.isNotEmpty,
                      child: Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(left: tiniestSpacing),
                        child: PrimaryButton(
                            onPressed: () {
                              context.read<LeavesAndHolidaysBloc>().add(
                                  SubmitTimeSheet(
                                      submitTimeSheetMap: submitTimeSheetMap));
                            },
                            textValue: StringConstants.kSubmitTimeSheet),
                      )),
                    )
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
