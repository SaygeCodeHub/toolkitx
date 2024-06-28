import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_bloc.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';
import 'package:toolkit/blocs/permit/permit_states.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/data/enums/permit/permit_switching_schedule_enum.dart';
import 'package:toolkit/screens/permit/widgets/permit_schedule_instuction_bottom_sheet.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_no_records_text.dart';

class PermitSwitchingScheduleTableScreen extends StatelessWidget {
  static const routeName = 'PermitSwitchingScheduleTableScreen';
  final String scheduleId;

  const PermitSwitchingScheduleTableScreen(
      {super.key, required this.scheduleId});

  @override
  Widget build(BuildContext context) {
    context
        .read<PermitBloc>()
        .add(FetchSwitchingScheduleInstructions(scheduleId: scheduleId));
    return Scaffold(
      appBar: const GenericAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin, right: leftRightMargin, top: xxTinySpacing),
        child: BlocBuilder<PermitBloc, PermitStates>(
          buildWhen: (previousState, currentState) =>
              currentState is FetchingSwitchingScheduleInstructions ||
              currentState is SwitchingScheduleInstructionsFetched ||
              currentState is SwitchingScheduleInstructionsNotFetched,
          builder: (context, state) {
            if (state is FetchingSwitchingScheduleInstructions) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SwitchingScheduleInstructionsFetched) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        decoration: BoxDecoration(border: Border.all()),
                        child: DataTable(
                          border: TableBorder.all(),
                          columns: [
                            const DataColumn(
                                label: Text(StringConstants.kSrNo)),
                            ...[
                              for (var columnEnum
                                  in PermitSwitchingScheduleEnum.values)
                                DataColumn(label: Text(columnEnum.value))
                            ],
                            const DataColumn(label: Text('')),
                          ],
                          rows: [
                            for (var index = 0;
                                index < state.scheduleInstructionDatum.length;
                                index++)
                              DataRow(
                                cells: [
                                  DataCell(Text((index + 1).toString())),
                                  ...[
                                    for (var columnEnum
                                        in PermitSwitchingScheduleEnum.values)
                                      DataCell(Text(
                                          state.scheduleInstructionDatum[index]
                                                  .toJson()[columnEnum.jsonKey]
                                                  ?.toString() ??
                                              '',
                                          overflow: TextOverflow.ellipsis))
                                  ],
                                  DataCell(TextButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return PermitScheduleInstructionBottomSheet(
                                                  permitSwithcingScheduleInstructionDatum:
                                                      state.scheduleInstructionDatum[
                                                          index]);
                                            });
                                      },
                                      child: const Text(
                                          StringConstants.kViewOptions)))
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is SwitchingScheduleInstructionsNotFetched) {
              return NoRecordsText(text: state.errorMessage);
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
