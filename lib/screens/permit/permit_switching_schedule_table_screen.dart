import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_bloc.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';
import 'package:toolkit/blocs/permit/permit_states.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/data/enums/permit/permit_switching_schedule_enum.dart';
import 'package:toolkit/screens/permit/widgets/permit_schedule_instuction_bottom_sheet.dart';
import 'package:toolkit/screens/permit/widgets/switching_schedule_table_checkbox.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_no_records_text.dart';
import 'package:toolkit/widgets/primary_button.dart';

import 'edit_multiselect_switching_schedule_screen.dart';

class PermitSwitchingScheduleTableScreen extends StatelessWidget {
  static const routeName = 'PermitSwitchingScheduleTableScreen';
  final String scheduleId;

  const PermitSwitchingScheduleTableScreen(
      {super.key, required this.scheduleId});

  @override
  Widget build(BuildContext context) {
    List selectedIdList = [];
    String instructionIds = '';
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
                            DataColumn(
                                label: SizedBox(
                              height: kPermitEditSelectedButtonHeight,
                              width: kPermitEditSelectedButtonWidth,
                              child: PrimaryButton(
                                  onPressed: () {
                                    if (instructionIds != '') {
                                      Navigator.pushNamed(
                                          context,
                                          EditMultiSelectSwitchingScheduleScreen
                                              .routeName,
                                          arguments: [
                                            scheduleId,
                                            instructionIds
                                          ]);
                                    } else {
                                      showCustomSnackBar(
                                          context, 'No records selected', '');
                                    }
                                  },
                                  textValue: StringConstants.kEditSelected),
                            )),
                          ],
                          rows: [
                            for (var index = 0;
                                index < state.scheduleInstructionDatum.length;
                                index++)
                              DataRow(
                                color: WidgetStateProperty.resolveWith<Color?>(
                                  (Set<WidgetState> states) {
                                    if (state.scheduleInstructionDatum[index]
                                            .ismanual ==
                                        1) {
                                      return AppColor.basicYellow;
                                    }
                                    return AppColor.white;
                                  },
                                ),
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
                                  DataCell(Visibility(
                                    visible: state
                                            .scheduleInstructionDatum[index]
                                            .canexecute ==
                                        '1',
                                    child: TextButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (context) {
                                                return PermitScheduleInstructionBottomSheet(
                                                  permitSwithcingScheduleInstructionDatum:
                                                      state.scheduleInstructionDatum[
                                                          index],
                                                  scheduleId: scheduleId,
                                                  index: index,
                                                  length: state
                                                      .scheduleInstructionDatum
                                                      .length,
                                                );
                                              });
                                        },
                                        child: const Text(
                                            StringConstants.kViewOptions)),
                                  )),
                                  DataCell(
                                    Visibility(
                                      visible: state
                                              .scheduleInstructionDatum[index]
                                              .canexecute ==
                                          '1',
                                      child: SwitchingScheduleTableCheckbox(
                                        index: index,
                                        scheduleInstructionDatum:
                                            state.scheduleInstructionDatum,
                                        selectedIdList: selectedIdList,
                                        onCreatedForChanged: (List idList) {
                                          selectedIdList = idList;
                                          instructionIds =
                                              selectedIdList.join(',');
                                        },
                                      ),
                                    ),
                                  ),
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
