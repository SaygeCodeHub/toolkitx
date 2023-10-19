import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/incident/widgets/date_picker.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../../blocs/assets/assets_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../incident/widgets/time_picker.dart';

class AssetsAddDowntimeScreen extends StatelessWidget {
  static const routeName = "AssetsAddDowntimeScreen";
  AssetsAddDowntimeScreen({super.key});
  final Map saveDowntimeMap = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText("AddDowntime")),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(tinierSpacing),
            child: BlocListener<AssetsBloc, AssetsState>(
              listener: (context, state) {
                if (state is AssetsDownTimeSaving) {
                  ProgressBar.show(context);
                } else if (state is AssetsDownTimeSaved) {
                  ProgressBar.dismiss(context);
                  showCustomSnackBar(context, "DownTime Saved", "");
                  Navigator.pop(context);
                } else if (state is AssetsDownTimeNotSaved) {
                  ProgressBar.dismiss(context);
                  showCustomSnackBar(context, state.errorMessage, "");
                }
              },
              child: PrimaryButton(
                  onPressed: () {
                    context.read<AssetsBloc>().add(
                        SaveAssetsDownTime(saveDowntimeMap: saveDowntimeMap));
                  },
                  textValue: "Save"),
            )),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Start date",
                  style: Theme.of(context).textTheme.xSmall.copyWith(
                      fontWeight: FontWeight.w500, color: AppColor.black)),
              Padding(
                  padding: const EdgeInsets.only(top: xxxTinierSpacing),
                  child: DatePickerTextField(onDateChanged: (date) {
                    saveDowntimeMap["startdate"] = date;
                  })),
              const SizedBox(height: tinierSpacing),
              Text("End date",
                  style: Theme.of(context).textTheme.xSmall.copyWith(
                      fontWeight: FontWeight.w500, color: AppColor.black)),
              Padding(
                  padding: const EdgeInsets.only(top: xxxTinierSpacing),
                  child: DatePickerTextField(onDateChanged: (date) {
                    saveDowntimeMap["enddate"] = date;
                  })),
              const SizedBox(height: tinierSpacing),
              Text("Start Time",
                  style: Theme.of(context).textTheme.xSmall.copyWith(
                      fontWeight: FontWeight.w500, color: AppColor.black)),
              Padding(
                  padding: const EdgeInsets.only(top: xxxTinierSpacing),
                  child: TimePickerTextField(onTimeChanged: (String time) {
                    saveDowntimeMap["starttime"] = time;
                  })),
              const SizedBox(height: tinierSpacing),
              Text("End Time",
                  style: Theme.of(context).textTheme.xSmall.copyWith(
                      fontWeight: FontWeight.w500, color: AppColor.black)),
              Padding(
                  padding: const EdgeInsets.only(top: xxxTinierSpacing),
                  child: TimePickerTextField(onTimeChanged: (String time) {
                    saveDowntimeMap["endtime"] = time;
                  })),
              const SizedBox(height: tinierSpacing),
              Text("Note",
                  style: Theme.of(context).textTheme.xSmall.copyWith(
                      fontWeight: FontWeight.w500, color: AppColor.black)),
              Padding(
                  padding: const EdgeInsets.only(top: xxxTinierSpacing),
                  child:
                      TextFieldWidget(onTextFieldChanged: (String textField) {
                    saveDowntimeMap["note"] = textField;
                  }))
            ])));
  }
}
