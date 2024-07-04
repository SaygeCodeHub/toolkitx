import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_bloc.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';
import 'package:toolkit/blocs/permit/permit_states.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/permit/fetch_switching_schedule_instructions_model.dart';
import 'package:toolkit/screens/permit/add_and_edit_switching_instruction_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/progress_bar.dart';

class PermitScheduleInstructionBottomSheet extends StatelessWidget {
  const PermitScheduleInstructionBottomSheet(
      {super.key,
      required this.permitSwithcingScheduleInstructionDatum,
      required this.scheduleId});

  final String scheduleId;
  final PermitSwithcingScheduleInstructionDatum
      permitSwithcingScheduleInstructionDatum;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kPermitScheduleInstBottomSheetHeight,
      child: Padding(
        padding: const EdgeInsets.all(xxTinierSpacing),
        child: BottomSheet(
            onClosing: () {},
            builder: (context) {
              return BlocListener<PermitBloc, PermitStates>(
                listener: (context, state) {
                  if (state is PermitSwitchingScheduleMovingDown) {
                    ProgressBar.show(context);
                  } else if (state is PermitSwitchingScheduleMovedDown) {
                    ProgressBar.dismiss(context);
                    Navigator.pop(context);
                    context.read<PermitBloc>().add(
                        FetchSwitchingScheduleInstructions(
                            scheduleId: scheduleId));
                  } else if (state is PermitSwitchingScheduleNotMovedDown) {
                    ProgressBar.dismiss(context);
                    showCustomSnackBar(context, state.errorMessage, '');
                  }

                  if (state is PermitSwitchingScheduleMovingUp) {
                    ProgressBar.show(context);
                  } else if (state is PermitSwitchingScheduleMovedUp) {
                    ProgressBar.dismiss(context);
                    Navigator.pop(context);
                    context.read<PermitBloc>().add(
                        FetchSwitchingScheduleInstructions(
                            scheduleId: scheduleId));
                  } else if (state is PermitSwitchingScheduleNotMovedUp) {
                    ProgressBar.dismiss(context);
                    showCustomSnackBar(context, state.errorMessage, '');
                  }
                },
                child: Column(
                  children: [
                    ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context,
                              AddAndEditSwitchingInstructionScreen.routeName,
                              arguments: [
                                permitSwithcingScheduleInstructionDatum,
                                false,
                                scheduleId
                              ]);
                        },
                        leading: const Icon(Icons.add,
                            size: kPermitScheduleInstIconSize),
                        title: Text(StringConstants.kAdd,
                            style: Theme.of(context).textTheme.xSmall)),
                    ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context,
                              AddAndEditSwitchingInstructionScreen.routeName,
                              arguments: [
                                permitSwithcingScheduleInstructionDatum,
                                true,
                                scheduleId
                              ]);
                        },
                        leading: const Icon(Icons.edit,
                            size: kPermitScheduleInstIconSize),
                        title: Text(StringConstants.kEdit,
                            style: Theme.of(context).textTheme.xSmall)),
                    ListTile(
                        onTap: () {
                          context.read<PermitBloc>().add(
                              MoveUpPermitSwitchingSchedule(
                                  instructionId:
                                      permitSwithcingScheduleInstructionDatum
                                          .id));
                        },
                        leading: const Icon(Icons.arrow_upward,
                            size: kPermitScheduleInstIconSize),
                        title: Text(StringConstants.kMoveUp,
                            style: Theme.of(context).textTheme.xSmall)),
                    ListTile(
                        onTap: () {
                          context.read<PermitBloc>().add(
                              MoveDownPermitSwitchingSchedule(
                                  instructionId:
                                      permitSwithcingScheduleInstructionDatum
                                          .id));
                        },
                        leading: const Icon(Icons.arrow_downward,
                            size: kPermitScheduleInstIconSize),
                        title: Text(StringConstants.kMoveDown,
                            style: Theme.of(context).textTheme.xSmall)),
                    ListTile(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        leading: const Icon(Icons.delete,
                            size: kPermitScheduleInstIconSize),
                        title: Text(StringConstants.kDelete,
                            style: Theme.of(context).textTheme.xSmall))
                  ],
                ),
              );
            }),
      ),
    );
  }
}
