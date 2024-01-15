import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/incident/widgets/date_picker.dart';
import 'package:toolkit/screens/leavesAndHolidays/widgtes/working_at_number_timesheet_tile.dart';
import 'package:toolkit/screens/leavesAndHolidays/widgtes/working_at_timesheet_tile.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import 'package:toolkit/widgets/primary_button.dart';
import '../../blocs/leavesAndHolidays/leaves_and_holidays_bloc.dart';
import '../../blocs/leavesAndHolidays/leaves_and_holidays_events.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';

class AddAndEditTimeSheetScreen extends StatelessWidget {
  const AddAndEditTimeSheetScreen({super.key, required this.date});

  static const routeName = 'TimeSheetWorkingAtScreen';
  final String date;

  @override
  Widget build(BuildContext context) {
    context
        .read<LeavesAndHolidaysBloc>()
        .add(FetchCheckInTimeSheet(date: date));
    return Scaffold(
      appBar: GenericAppBar(title: date),
      body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxTinierSpacing),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Working at",
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        fontWeight: FontWeight.w500, color: AppColor.black)),
                const SizedBox(height: 10),
                const WorkingAtTimeSheetTile(),
                const SizedBox(height: 10),
                Text("Working at number",
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        fontWeight: FontWeight.w500, color: AppColor.black)),
                const SizedBox(height: 10),
                const WorkingAtNumberTimeSheetTile(),
                const SizedBox(height: 10),
                Text("Start Time",
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        fontWeight: FontWeight.w500, color: AppColor.black)),
                const SizedBox(height: 10),
                DatePickerTextField(
                  onDateChanged: (date) {},
                ),
                const SizedBox(height: 10),
                Text("End Time",
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        fontWeight: FontWeight.w500, color: AppColor.black)),
                const SizedBox(height: 10),
                DatePickerTextField(
                  onDateChanged: (date) {},
                ),
                const SizedBox(height: 10),
                Text("Break(mins)",
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        fontWeight: FontWeight.w500, color: AppColor.black)),
                const SizedBox(height: 10),
                TextFieldWidget(
                  onTextFieldChanged: (textField) {},
                ),
                const SizedBox(height: 10),
                Text("Work Description",
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        fontWeight: FontWeight.w500, color: AppColor.black)),
                const SizedBox(height: 10),
                TextFieldWidget(
                  onTextFieldChanged: (textField) {},
                )
              ],
            ),
          )),
      bottomNavigationBar: BottomAppBar(
        child: PrimaryButton(onPressed: () {}, textValue: "Save"),
      ),
    );
  }
}
