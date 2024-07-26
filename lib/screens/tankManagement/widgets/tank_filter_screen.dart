import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/tankManagement/tank_management_bloc.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/incident/widgets/date_picker.dart';
import 'package:toolkit/screens/tankManagement/tank_management_list_screen.dart';
import 'package:toolkit/screens/tankManagement/widgets/tank_status_filter.dart';
import 'package:toolkit/screens/tankManagement/widgets/tank_title_filter.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import 'package:toolkit/widgets/primary_button.dart';

class TankFilterScreen extends StatelessWidget {
  static const routeName = 'TankFilterScreen';
  static Map tankFilterMap = {};

  const TankFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('Filters')),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Title',
              style: Theme.of(context).textTheme.small.copyWith(
                  fontWeight: FontWeight.w500, color: AppColor.black)),
          const SizedBox(height: xxTinierSpacing),
          TankTitleFilter(tankFilterMap: tankFilterMap),
          const SizedBox(height: xxTinierSpacing),
          Text(DatabaseUtil.getText('StartDate'),
              style: Theme.of(context).textTheme.small.copyWith(
                  fontWeight: FontWeight.w500, color: AppColor.black)),
          const SizedBox(height: tiniestSpacing),
          DatePickerTextField(onDateChanged: (date) {
            tankFilterMap['st'] = date;
          }),
          const SizedBox(height: xxTinierSpacing),
          Text(DatabaseUtil.getText('EndDate'),
              style: Theme.of(context).textTheme.small.copyWith(
                  fontWeight: FontWeight.w500, color: AppColor.black)),
          const SizedBox(height: tiniestSpacing),
          DatePickerTextField(onDateChanged: (date) {
            tankFilterMap['et'] = date;
          }),
          const SizedBox(height: xxTinierSpacing),
          Text('Contract',
              style: Theme.of(context).textTheme.small.copyWith(
                  fontWeight: FontWeight.w500, color: AppColor.black)),
          const SizedBox(height: xxTinierSpacing),
          TextFieldWidget(onTextFieldChanged: (textField) {
            tankFilterMap['contract'] = textField;
          }),
          const SizedBox(height: xxTinierSpacing),
          Text(DatabaseUtil.getText('Status'),
              style: Theme.of(context).textTheme.small.copyWith(
                  fontWeight: FontWeight.w500, color: AppColor.black)),
          const SizedBox(height: xxTinierSpacing),
          TankStatusFilter(tankFilterMap: tankFilterMap),
        ])),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxTinierSpacing),
        child: PrimaryButton(
            onPressed: () {
              context
                  .read<TankManagementBloc>()
                  .add(ApplyTankFilter(tankFilterMap: tankFilterMap));
              Navigator.pop(context);
              Navigator.pushReplacementNamed(
                  context, TankManagementListScreen.routeName,
                  arguments: false);
            },
            textValue: StringConstants.kApply),
      ),
    );
  }
}
