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
import '../../widgets/progress_bar.dart';

class AddAndEditTimeSheetScreen extends StatelessWidget {
  static Map saveTimeSheetMap = {};
  static const routeName = 'TimeSheetWorkingAtScreen';

  const AddAndEditTimeSheetScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    context
        .read<LeavesAndHolidaysBloc>()
        .add(FetchCheckInTimeSheet(date: saveTimeSheetMap['date']));
    return Scaffold(
      appBar: GenericAppBar(title: saveTimeSheetMap['date']),
      body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxTinierSpacing),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(StringConstants.kWorkingAt,
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        fontWeight: FontWeight.w500, color: AppColor.black)),
                const SizedBox(height: xxTinierSpacing),
                const WorkingAtTimeSheetTile(),
                const SizedBox(height: xxTinierSpacing),
                const TimSheetWorkingAtNumberListTile(),
                const SizedBox(height: xxTinierSpacing),
                Text(StringConstants.kStartTime,
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        fontWeight: FontWeight.w500, color: AppColor.black)),
                const SizedBox(height: xxTinierSpacing),
                TimePickerTextField(
                  onTimeChanged: (String time) {
                    saveTimeSheetMap['starttime'] = time;
                  },
                ),
                const SizedBox(height: xxTinierSpacing),
                Text(StringConstants.kEndTime,
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        fontWeight: FontWeight.w500, color: AppColor.black)),
                const SizedBox(height: xxTinierSpacing),
                TimePickerTextField(
                  onTimeChanged: (String time) {
                    saveTimeSheetMap['endtime'] = time;
                  },
                ),
                const SizedBox(height: xxTinierSpacing),
                Text(StringConstants.kMinsBreak,
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        fontWeight: FontWeight.w500, color: AppColor.black)),
                const SizedBox(height: xxTinierSpacing),
                TextFieldWidget(
                  textInputType: TextInputType.number,
                  onTextFieldChanged: (textField) {
                    saveTimeSheetMap['breakmins'] = textField;
                  },
                ),
                const SizedBox(height: xxTinierSpacing),
                Text(StringConstants.kDescription,
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        fontWeight: FontWeight.w500, color: AppColor.black)),
                const SizedBox(height: xxTinierSpacing),
                TextFieldWidget(
                  maxLines: 3,
                  textInputAction: TextInputAction.done,
                  onTextFieldChanged: (textField) {
                    saveTimeSheetMap['description'] = textField;
                  },
                )
              ],
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
