import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/leavesAndHolidays/leaves_and_holidays_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/leavesAndHolidays/add_and_edit_timesheet_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_dimensions.dart';
import '../../../../widgets/expansion_tile_border.dart';
import '../../../blocs/leavesAndHolidays/leaves_and_holidays_events.dart';
import '../../../blocs/leavesAndHolidays/leaves_and_holidays_states.dart';
import '../../../data/enums/timesheet_working_at_enum.dart';

class WorkingAtTimeSheetTile extends StatelessWidget {
  const WorkingAtTimeSheetTile({super.key});
  static String workingAt = '';
  static String workingAtValue = '';

  @override
  Widget build(BuildContext context) {
    context.read<LeavesAndHolidaysBloc>().add(SelectTimeSheetWorkingAtOption(
        workingAt: workingAt, workingAtValue: workingAtValue));
    return BlocBuilder<LeavesAndHolidaysBloc, LeavesAndHolidaysStates>(
      buildWhen: (previousState, currentState) =>
          currentState is TimeSheetWorkingAtOptionSelected,
      builder: (context, state) {
        if (state is TimeSheetWorkingAtOptionSelected) {
          return Theme(
              data: Theme.of(context)
                  .copyWith(dividerColor: AppColor.transparent),
              child: ExpansionTile(
                  collapsedShape:
                      ExpansionTileBorder().buildOutlineInputBorder(),
                  collapsedBackgroundColor: AppColor.white,
                  backgroundColor: AppColor.white,
                  shape: ExpansionTileBorder().buildOutlineInputBorder(),
                  key: GlobalKey(),
                  title: Text(
                      (state.workingAtValue.isEmpty)
                          ? StringConstants.kSelect
                          : state.workingAtValue,
                      style: Theme.of(context).textTheme.xSmall),
                  children: [
                    ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: TimeSheetWorkingAtEnum.values.length,
                        itemBuilder: (BuildContext context, int index) {
                          return RadioListTile(
                              contentPadding: const EdgeInsets.only(
                                  left: kExpansionTileMargin,
                                  right: kExpansionTileMargin),
                              activeColor: AppColor.deepBlue,
                              title: Text(
                                  TimeSheetWorkingAtEnum.values
                                      .elementAt(index)
                                      .status,
                                  style: Theme.of(context).textTheme.xSmall),
                              controlAffinity: ListTileControlAffinity.trailing,
                              value: TimeSheetWorkingAtEnum.values
                                  .elementAt(index)
                                  .value,
                              groupValue: workingAt,
                              onChanged: (value) {
                                context
                                    .read<LeavesAndHolidaysBloc>()
                                    .timeSheetWorkingAtMap
                                    .clear();
                                workingAt = TimeSheetWorkingAtEnum.values
                                    .elementAt(index)
                                    .value;
                                workingAtValue = TimeSheetWorkingAtEnum.values
                                    .elementAt(index)
                                    .status;
                                AddAndEditTimeSheetScreen
                                        .saveTimeSheetMap['workingatid'] =
                                    workingAt;
                                context.read<LeavesAndHolidaysBloc>().add(
                                    SelectTimeSheetWorkingAtOption(
                                        workingAt: workingAt,
                                        workingAtValue: workingAtValue));
                              });
                        })
                  ]));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
