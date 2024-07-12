import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/screens/permit/widgets/permit_date_picker.dart';
import 'package:toolkit/screens/permit/widgets/permit_time_picker.dart';

typedef CallBackFunctionForDateTime = Function(String date, String time);

class PermitSwitchingDateTimeFields extends StatefulWidget {
  const PermitSwitchingDateTimeFields(
      {super.key,
      required this.callBackFunctionForDateTime,
      this.editDate,
      this.editTime});

  final CallBackFunctionForDateTime callBackFunctionForDateTime;
  final String? editDate;
  final String? editTime;

  @override
  State<PermitSwitchingDateTimeFields> createState() =>
      _PermitSwitchingDateTimeFieldsState();
}

class _PermitSwitchingDateTimeFieldsState
    extends State<PermitSwitchingDateTimeFields> {
  bool showInstructedDateTime = false;
  String? selectedDate;
  String? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PermitDatePicker(
            editDate: widget.editDate ?? '',
            hintText: selectedDate ?? '',
            onDateChanged: (date) {
              selectedDate = date;
              widget.callBackFunctionForDateTime(
                  selectedDate ?? '', selectedTime ?? '');
            },
          ),
        ),
        const SizedBox(width: xxxSmallestSpacing),
        Expanded(
          child: PermitTimePicker(
            editTime: widget.editTime ?? '',
            hintText: selectedTime ?? '',
            onTimeChanged: (time) {
              selectedTime = time;
              widget.callBackFunctionForDateTime(
                  selectedDate ?? '', selectedTime ?? '');
            },
          ),
        ),
        IconButton(
            onPressed: () {
              setState(() {
                selectedDate = DateFormat("dd MMM yyyy").format(DateTime.now());
                selectedTime = DateFormat("HH:mm").format(DateTime.now());
                String formatDate =
                    DateFormat('dd.MM.yyyy').format(DateTime.now());
                widget.callBackFunctionForDateTime(
                    formatDate, selectedTime ?? '');
              });
            },
            icon: const Icon(Icons.watch_later_outlined))
      ],
    );
  }
}
