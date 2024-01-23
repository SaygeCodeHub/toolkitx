import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/incident/widgets/time_picker.dart';
import 'package:toolkit/screens/leavesAndHolidays/widgtes/working_at_number_timesheet_tile.dart';
import 'package:toolkit/screens/leavesAndHolidays/widgtes/working_at_timesheet_tile.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../blocs/leavesAndHolidays/leaves_and_holidays_bloc.dart';
import '../../blocs/leavesAndHolidays/leaves_and_holidays_events.dart';
import '../../blocs/leavesAndHolidays/leaves_and_holidays_states.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/error_section.dart';
import '../../widgets/progress_bar.dart';

class AddAndEditTimeSheetScreen extends StatelessWidget {
  static Map saveTimeSheetMap = {};
  static const routeName = 'TimeSheetWorkingAtScreen';
  static bool isFromEdit = false;

  const AddAndEditTimeSheetScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    log("Id===========>${saveTimeSheetMap['id']}");
    log("date===========>${saveTimeSheetMap["date"]}");
    context.read<LeavesAndHolidaysBloc>().add(FetchTimeSheetDetails(
        timeSheetDetailsId: AddAndEditTimeSheetScreen.saveTimeSheetMap['id']));
    return Scaffold(
      appBar: GenericAppBar(title: saveTimeSheetMap['date']),
      body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxTinierSpacing),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: leftRightMargin,
                  right: leftRightMargin,
                  top: xxTinierSpacing,
                  bottom: leftRightMargin),
              child:
                  BlocBuilder<LeavesAndHolidaysBloc, LeavesAndHolidaysStates>(
                buildWhen: (previousState, currentState) =>
                    currentState is FetchingTimeSheetDetails ||
                    currentState is TimeSheetDetailsFetched ||
                    currentState is TimeSheetDetailsNotFetched,
                builder: (context, state) {
                  log("state==================>$state");
                  if (state is FetchingTimeSheetDetails) {
                    return Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.35),
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  } else if (state is TimeSheetDetailsFetched) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(StringConstants.kWorkingAt,
                            style: Theme.of(context).textTheme.xSmall.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColor.black)),
                        const SizedBox(height: xxTinierSpacing),
                        const WorkingAtTimeSheetTile(),
                        const SizedBox(height: xxTinierSpacing),
                        const TimSheetWorkingAtNumberListTile(),
                        const SizedBox(height: xxTinierSpacing),
                        Text(StringConstants.kStartTime,
                            style: Theme.of(context).textTheme.xSmall.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColor.black)),
                        const SizedBox(height: xxTinierSpacing),
                        TimePickerTextField(
                          editTime: AddAndEditTimeSheetScreen.isFromEdit == true
                              ? AddAndEditTimeSheetScreen
                                  .saveTimeSheetMap["starttime"] :
                              "",
                          onTimeChanged: (String time) {
                            saveTimeSheetMap['starttime'] = time;
                          },
                        ),
                        const SizedBox(height: xxTinierSpacing),
                        Text(StringConstants.kEndTime,
                            style: Theme.of(context).textTheme.xSmall.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColor.black)),
                        const SizedBox(height: xxTinierSpacing),
                        TimePickerTextField(
                          editTime: AddAndEditTimeSheetScreen.isFromEdit == true
                              ? AddAndEditTimeSheetScreen
                                  .saveTimeSheetMap["endtime"] :
                              "",
                          onTimeChanged: (String time) {
                            saveTimeSheetMap['endtime'] = time;
                          },
                        ),
                        const SizedBox(height: xxTinierSpacing),
                        Text(StringConstants.kMinsBreak,
                            style: Theme.of(context).textTheme.xSmall.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColor.black)),
                        const SizedBox(height: xxTinierSpacing),
                        TextFieldWidget(
                          textInputType: TextInputType.number,
                          value: AddAndEditTimeSheetScreen.isFromEdit == true
                              ? AddAndEditTimeSheetScreen
                                  .saveTimeSheetMap["breakmins"]
                              : "",
                          onTextFieldChanged: (textField) {
                            saveTimeSheetMap['breakmins'] = textField;
                          },
                        ),
                        const SizedBox(height: xxTinierSpacing),
                        Text(StringConstants.kDescription,
                            style: Theme.of(context).textTheme.xSmall.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColor.black)),
                        const SizedBox(height: xxTinierSpacing),
                        TextFieldWidget(
                          value: AddAndEditTimeSheetScreen.isFromEdit == true
                              ? AddAndEditTimeSheetScreen
                                  .saveTimeSheetMap["description"] :
                              "",
                          maxLines: 3,
                          textInputAction: TextInputAction.done,
                          onTextFieldChanged: (textField) {
                            saveTimeSheetMap['description'] = textField;
                          },
                        )
                      ],
                    );
                  } else if (state is TimeSheetDetailsNotFetched) {
                    return Center(
                      child: GenericReloadButton(
                          onPressed: () {
                            context.read<LeavesAndHolidaysBloc>().add(
                                FetchTimeSheetDetails(
                                    timeSheetDetailsId: saveTimeSheetMap[
                                        'timeSheetDetailsId']));
                          },
                          textValue: StringConstants.kReload),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          )),
      bottomNavigationBar: BottomAppBar(
        child: BlocListener<LeavesAndHolidaysBloc, LeavesAndHolidaysStates>(
          listener: (context, state) {
            if (state is TimeSheetSaving) {
              ProgressBar.show(context);
            } else if (state is TimeSheetSaved) {
              ProgressBar.dismiss(context);
              Navigator.pop(context);
            } else if (state is TimeSheetNotSaved) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.errorMessage, '');
            }
          },
          child: PrimaryButton(
              onPressed: () {
                context
                    .read<LeavesAndHolidaysBloc>()
                    .add(SaveTimeSheet(saveTimeSheetMap: saveTimeSheetMap));
              },
              textValue: StringConstants.kSave),
        ),
      ),
    );
  }
}
