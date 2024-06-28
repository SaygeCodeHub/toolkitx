import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/permit/fetch_switching_schedule_instructions_model.dart';
import 'package:toolkit/screens/permit/edit_switching_instruction_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

class PermitScheduleInstructionBottomSheet extends StatelessWidget {
  const PermitScheduleInstructionBottomSheet(
      {super.key, required this.permitSwithcingScheduleInstructionDatum});

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
              return Column(
                children: [
                  ListTile(
                      onTap: () {
                        Navigator.pushNamed(
                            context, EditSwitchingInstructionScreen.routeName,
                            arguments: permitSwithcingScheduleInstructionDatum);
                      },
                      leading: const Icon(Icons.edit,
                          size: kPermitScheduleInstIconSize),
                      title: Text(StringConstants.kEdit,
                          style: Theme.of(context).textTheme.xSmall)),
                  ListTile(
                      leading: const Icon(Icons.arrow_upward,
                          size: kPermitScheduleInstIconSize),
                      title: Text(StringConstants.kMoveUp,
                          style: Theme.of(context).textTheme.xSmall)),
                  ListTile(
                      leading: const Icon(Icons.arrow_downward,
                          size: kPermitScheduleInstIconSize),
                      title: Text(StringConstants.kMoveDown,
                          style: Theme.of(context).textTheme.xSmall)),
                  ListTile(
                      leading: const Icon(Icons.delete,
                          size: kPermitScheduleInstIconSize),
                      title: Text(StringConstants.kDelete,
                          style: Theme.of(context).textTheme.xSmall))
                ],
              );
            }),
      ),
    );
  }
}
