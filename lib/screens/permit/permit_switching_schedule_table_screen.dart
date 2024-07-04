import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_bloc.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';
import 'package:toolkit/blocs/permit/permit_states.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/data/enums/permit/permit_switching_schedule_enum.dart';
import 'package:toolkit/data/models/permit/fetch_switching_schedule_instructions_model.dart';
import 'package:toolkit/screens/permit/widgets/permit_schedule_instuction_bottom_sheet.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
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
                                    Navigator.pushNamed(
                                        context,
                                        EditMultiSelectSwitchingScheduleScreen
                                            .routeName,
                                        arguments: [
                                          scheduleId,
                                          instructionIds
                                        ]);
                                  },
                                  textValue: "Edit Selected"),
                            )),
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
                                                        index],
                                                scheduleId: scheduleId,
                                              );
                                            });
                                      },
                                      child: const Text(
                                          StringConstants.kViewOptions))),
                                  DataCell(
                                    SwitchingScheduleTableCheckbox(
                                      index: index,
                                      scheduleInstructionDatum:
                                          state.scheduleInstructionDatum,
                                      onCreatedForChanged: (List idList) {
                                        if (idList.isNotEmpty) {
                                          if (!selectedIdList
                                              .contains(idList[0])) {
                                            selectedIdList.add(idList[0]);
                                            instructionIds = selectedIdList
                                                .toString()
                                                .replaceAll("[", "")
                                                .replaceAll("]", "")
                                                .replaceAll(", ", ",");
                                          }
                                        }
                                      },
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

typedef CreatedForStringCallBack = Function(List idList);

class SwitchingScheduleTableCheckbox extends StatefulWidget {
  const SwitchingScheduleTableCheckbox({
    super.key,
    required this.index,
    required this.scheduleInstructionDatum,
    required this.onCreatedForChanged,
  });

  final CreatedForStringCallBack onCreatedForChanged;
  final List<PermitSwithcingScheduleInstructionDatum> scheduleInstructionDatum;
  final int index;

  @override
  State<SwitchingScheduleTableCheckbox> createState() =>
      _SwitchingScheduleTableCheckboxState();
}

class _SwitchingScheduleTableCheckboxState
    extends State<SwitchingScheduleTableCheckbox> {
  List selectedIdList = [];

  void _checkboxChange(isSelected, userId) {
    if (isSelected) {
      selectedIdList.add(userId);
      widget.onCreatedForChanged(selectedIdList);
    } else {
      selectedIdList.remove(userId);
      widget.onCreatedForChanged(selectedIdList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: AppColor.deepBlue,
      value: selectedIdList
          .contains(widget.scheduleInstructionDatum[widget.index].id),
      onChanged: (isChecked) {
        setState(() {
          _checkboxChange(
              isChecked, widget.scheduleInstructionDatum[widget.index].id);
        });
      },
    );
  }
}
