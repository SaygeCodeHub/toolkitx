import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_dimensions.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../blocs/leavesAndHolidays/leaves_and_holidays_bloc.dart';
import '../../../blocs/leavesAndHolidays/leaves_and_holidays_events.dart';
import '../../../blocs/leavesAndHolidays/leaves_and_holidays_states.dart';
import '../add_and_edit_timesheet_screen.dart';
import 'leaves_and_holidays_working_at_num_list.dart';

class TimSheetWorkingAtNumberListTile extends StatelessWidget {
  static Map workingAtNumberMap = {};

  const TimSheetWorkingAtNumberListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<LeavesAndHolidaysBloc>().add(SelectTimeSheetWorkingAtNumber(
        timeSheetWorkingAtNumberMap: workingAtNumberMap));
    return BlocBuilder<LeavesAndHolidaysBloc, LeavesAndHolidaysStates>(
      buildWhen: (previousState, currentState) =>
          currentState is TimeSheetWorkingAtNumberSelected,
      builder: (context, state) {
        if (state is TimeSheetWorkingAtNumberSelected) {
          AddAndEditTimeSheetScreen.saveTimeSheetMap['working_at_number_id'] =
              state.timeSheetWorkingAtNumberMap['new_working_at_number'] ?? '';
          return ListTile(
              contentPadding: EdgeInsets.zero,
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LeavesAndHolidaysWorkingAtNumList(
                        workingAtNumberMap: workingAtNumberMap)));
                AddAndEditTimeSheetScreen
                        .saveTimeSheetMap['working_at_number_id'] =
                    workingAtNumberMap['working_at_number_id'];
              },
              title: Text(
                StringConstants.kWorkingAtNumber,
                style: Theme.of(context).textTheme.xSmall.copyWith(
                    color: AppColor.black, fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                state.timeSheetWorkingAtNumberMap['working_at_number'] ?? '',
                style: Theme.of(context)
                    .textTheme
                    .xSmall
                    .copyWith(color: AppColor.black),
              ),
              trailing:
                  const Icon(Icons.navigate_next_rounded, size: kIconSize));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
