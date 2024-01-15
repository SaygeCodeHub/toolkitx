import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/leavesAndHolidays/leaves_and_holidays_bloc.dart';
import 'package:toolkit/blocs/leavesAndHolidays/leaves_and_holidays_events.dart';
import 'package:toolkit/blocs/leavesAndHolidays/leaves_and_holidays_states.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/enums/timesheet_working_at_enum.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/expansion_tile_border.dart';

class WorkingAtTimeSheetTile extends StatelessWidget {
  const WorkingAtTimeSheetTile({
    super.key,
  });

  static String type = '';
  static String values = '';

  @override
  Widget build(BuildContext context) {
    context
        .read<LeavesAndHolidaysBloc>()
        .add(SelectTimeSheetWorkingAt(value: '', status: ''));
    return BlocBuilder<LeavesAndHolidaysBloc, LeavesAndHolidaysStates>(
        buildWhen: (previousState, currentState) =>
            currentState is TimeSheetWorkingAtSelected,
        builder: (context, state) {
          if (state is TimeSheetWorkingAtSelected) {
            log('TimeSheetWorkingAtSelected============>');
            log('status============>${state.value}');
            return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: AppColor.transparent),
                child: ExpansionTile(
                    title: Text(
                        state.status == ""
                            ? StringConstants.kSelect
                            : state.status,
                        style: Theme.of(context).textTheme.xSmall),
                    collapsedShape:
                        ExpansionTileBorder().buildOutlineInputBorder(),
                    collapsedBackgroundColor: AppColor.white,
                    backgroundColor: AppColor.white,
                    shape: ExpansionTileBorder().buildOutlineInputBorder(),
                    key: GlobalKey(),
                    children: [
                      ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: TimeSheetWorkingAtEnum.values.length,
                        itemBuilder: (context, index) {
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
                              groupValue: type,
                              onChanged: (value) {
                                log("tapped");
                                type = TimeSheetWorkingAtEnum.values
                                    .elementAt(index)
                                    .value;
                                values = TimeSheetWorkingAtEnum.values
                                    .elementAt(index)
                                    .status;
                                context.read<LeavesAndHolidaysBloc>().add(
                                    SelectTimeSheetWorkingAt(
                                        value: type, status: values));
                              });
                        },
                      )
                    ]));
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
