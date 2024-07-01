import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/permit/fetch_switching_schedule_instructions_model.dart';
import 'package:toolkit/screens/incident/widgets/date_picker.dart';
import 'package:toolkit/screens/incident/widgets/time_picker.dart';
import 'package:toolkit/screens/permit/widgets/control_engineer_expansion_tile.dart';
import 'package:toolkit/screens/permit/widgets/instruction_received_expansion_tile.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import 'package:toolkit/widgets/primary_button.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';

class EditSwitchingInstructionScreen extends StatelessWidget {
  static const routeName = 'EditSwitchingInstructionScreen';

  const EditSwitchingInstructionScreen({
    super.key,
    required this.permitSwithcingScheduleInstructionDatum,
  });

  final PermitSwithcingScheduleInstructionDatum
      permitSwithcingScheduleInstructionDatum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(),
      body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxTinierSpacing,
              bottom: xxTinierSpacing),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(DatabaseUtil.getText('Location'),
                  style: Theme.of(context).textTheme.xSmall.copyWith(
                      color: AppColor.black, fontWeight: FontWeight.bold)),
              const SizedBox(height: tiniestSpacing),
              Text(permitSwithcingScheduleInstructionDatum.location),
              const SizedBox(height: xxxSmallestSpacing),
              Text(StringConstants.kEquipmentUIN,
                  style: Theme.of(context).textTheme.xSmall.copyWith(
                      color: AppColor.black, fontWeight: FontWeight.bold)),
              const SizedBox(height: tiniestSpacing),
              Text(permitSwithcingScheduleInstructionDatum.equipmentuid),
              const SizedBox(height: xxxSmallestSpacing),
              Text(StringConstants.kOperation,
                  style: Theme.of(context).textTheme.xSmall.copyWith(
                      color: AppColor.black, fontWeight: FontWeight.bold)),
              const SizedBox(height: tiniestSpacing),
              Text(permitSwithcingScheduleInstructionDatum.operation),
              const SizedBox(height: xxxSmallestSpacing),
              Text(StringConstants.kInstructionReceivedBy,
                  style: Theme.of(context).textTheme.xSmall.copyWith(
                      color: AppColor.black, fontWeight: FontWeight.bold)),
              const SizedBox(height: tiniestSpacing),
              const InstructionReceivedExpansionTile(),
              const SizedBox(height: xxxSmallestSpacing),
              Text(StringConstants.kInstructedDateTime,
                  style: Theme.of(context).textTheme.xSmall.copyWith(
                      color: AppColor.black, fontWeight: FontWeight.bold)),
              const SizedBox(height: tiniestSpacing),
              InstructedDateTimeFields(),
              const SizedBox(height: xxxSmallestSpacing),
              Text(StringConstants.kControlEngineer,
                  style: Theme.of(context).textTheme.xSmall.copyWith(
                      color: AppColor.black, fontWeight: FontWeight.bold)),
              const SizedBox(height: tiniestSpacing),
              const ControlEngineerExpansionTile(),
              const SizedBox(height: xxxSmallestSpacing),
              Text(StringConstants.kCarriedoutDateTime,
                  style: Theme.of(context).textTheme.xSmall.copyWith(
                      color: AppColor.black, fontWeight: FontWeight.bold)),
              const SizedBox(height: tiniestSpacing),
              Row(
                children: [
                  Expanded(
                    child: DatePickerTextField(
                      editDate:
                          DateFormat("dd MMM yyyy").format(DateTime.now()),
                      onDateChanged: (date) {},
                    ),
                  ),
                  const SizedBox(width: xxxSmallestSpacing),
                  Expanded(
                    child: TimePickerTextField(
                      editTime: DateFormat("HH:mm").format(DateTime.now()),
                      onTimeChanged: (time) {},
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.watch_later_outlined))
                ],
              ),
              const SizedBox(height: xxxSmallestSpacing),
              Text(StringConstants.kCarriedoutConfirmedDateTime,
                  style: Theme.of(context).textTheme.xSmall.copyWith(
                      color: AppColor.black, fontWeight: FontWeight.bold)),
              const SizedBox(height: tiniestSpacing),
              Row(
                children: [
                  Expanded(
                    child: DatePickerTextField(
                      editDate:
                          DateFormat("dd MMM yyyy").format(DateTime.now()),
                      onDateChanged: (date) {},
                    ),
                  ),
                  const SizedBox(width: xxxSmallestSpacing),
                  Expanded(
                    child: TimePickerTextField(
                      editTime: DateFormat("HH:mm").format(DateTime.now()),
                      onTimeChanged: (time) {},
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.watch_later_outlined))
                ],
              ),
              const SizedBox(height: xxxSmallestSpacing),
              Text(StringConstants.kSafetyKeyNumber,
                  style: Theme.of(context).textTheme.xSmall.copyWith(
                      color: AppColor.black, fontWeight: FontWeight.bold)),
              const SizedBox(height: tiniestSpacing),
              TextFieldWidget(
                onTextFieldChanged: (textField) {},
              ),
            ]),
          )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxTinierSpacing),
        child: PrimaryButton(
            onPressed: () {}, textValue: DatabaseUtil.getText('buttonSave')),
      ),
    );
  }
}

class InstructedDateTimeFields extends StatefulWidget {
  const InstructedDateTimeFields({super.key});

  @override
  State<InstructedDateTimeFields> createState() =>
      _InstructedDateTimeFieldsState();
}

class _InstructedDateTimeFieldsState extends State<InstructedDateTimeFields> {
  bool showInstructedDateTime = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DatePickerTextField(
            editDate: showInstructedDateTime == true
                ? DateFormat("dd MMM yyyy").format(DateTime.now())
                : '',
            onDateChanged: (date) {},
          ),
        ),
        const SizedBox(width: xxxSmallestSpacing),
        Expanded(
          child: TimePickerTextField(
            editTime: DateFormat("HH:mm").format(DateTime.now()),
            onTimeChanged: (time) {},
          ),
        ),
        // const SizedBox(width: xxTinierSpacing),
        IconButton(
            onPressed: () {
              setState(() {
                showInstructedDateTime = true;
              });
            },
            icon: const Icon(Icons.watch_later_outlined))
      ],
    );
  }
}
