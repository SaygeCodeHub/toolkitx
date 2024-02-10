import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/leavesAndHolidays/leaves_and_holidays_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../blocs/expense/expense_bloc.dart';
import '../../../blocs/expense/expense_event.dart';
import '../../../blocs/expense/expense_state.dart';
import '../../../blocs/leavesAndHolidays/leaves_and_holidays_events.dart';
import '../../../blocs/leavesAndHolidays/leaves_and_holidays_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/generic_app_bar.dart';
import 'working_at_timesheet_tile.dart';

class LeavesAndHolidaysWorkingAtNumList extends StatelessWidget {
  final Map workingAtNumberMap;

  const LeavesAndHolidaysWorkingAtNumList(
      {super.key, required this.workingAtNumberMap});

  @override
  Widget build(BuildContext context) {
    context.read<ExpenseBloc>().add(
        FetchWorkingAtNumberData(groupBy: WorkingAtTimeSheetTile.workingAt));
    return Scaffold(
        appBar:
            const GenericAppBar(title: StringConstants.kSelectWorkingAtNumber),
        body: BlocBuilder<ExpenseBloc, ExpenseStates>(
          buildWhen: (previousState, currentState) =>
          currentState is TimeSheetWorkingAtOptionSelected ||
              currentState is FetchingWorkingAtNumberData ||
              currentState is WorkingAtNumberDataFetched ||
              currentState is WorkingAtNumberDataNotFetched,
          builder: (context, state) {
            if (state is FetchingWorkingAtNumberData) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WorkingAtNumberDataFetched) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: leftRightMargin, right: leftRightMargin),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: state.expenseWorkingAtNumberDataModel.data
                                .isNotEmpty,
                            replacement: Padding(
                              padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height / 2.7),
                              child: Center(
                                  child: Text(StringConstants.kNoRecordsFound,
                                      style:
                                          Theme.of(context).textTheme.medium)),
                            ),
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.expenseWorkingAtNumberDataModel
                                    .data.length,
                                itemBuilder: (context, index) {
                                  return RadioListTile(
                                      contentPadding: EdgeInsets.zero,
                                      dense: true,
                                      activeColor: AppColor.deepBlue,
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                      title: Text(state
                                          .expenseWorkingAtNumberDataModel
                                          .data[index]
                                          .name),
                                      value: state
                                          .expenseWorkingAtNumberDataModel
                                          .data[index]
                                          .id
                                          .toString(),
                                      groupValue: workingAtNumberMap[
                                              'working_at_number_id'] ??
                                          '',
                                      onChanged: (value) {
                                        context
                                            .read<LeavesAndHolidaysBloc>()
                                            .timeSheetWorkingAtNumberMap
                                            .clear();
                                        workingAtNumberMap[
                                                'working_at_number_id'] =
                                            state
                                                .expenseWorkingAtNumberDataModel
                                                .data[index]
                                                .id;
                                        workingAtNumberMap[
                                                'working_at_number'] =
                                            state
                                                .expenseWorkingAtNumberDataModel
                                                .data[index]
                                                .name;
                                        context
                                            .read<LeavesAndHolidaysBloc>()
                                            .add(SelectTimeSheetWorkingAtNumber(
                                                timeSheetWorkingAtNumberMap:
                                                    workingAtNumberMap));
                                        Navigator.pop(context);
                                      });
                                }),
                          ),
                          const SizedBox(height: xxxSmallerSpacing)
                        ])),
              );
            } else if (state is WorkingAtNumberDataNotFetched) {
              return Center(child: Text(state.dataNotFetched));
            } else {
              return const SizedBox.shrink();
            }
          },
        ));
  }
}
