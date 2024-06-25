import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../../../configs/app_color.dart';
import '../../../widgets/text_button.dart';

typedef StringCallBack = Function(String date);

class MeetingDatePicker extends StatefulWidget {
  final DateTime? initialDate;
  final StringCallBack onDateChanged;
  final DateTime? maxDate;
  final String editDate;
  final String? text;
  final DateTime? minimumDate;
  static List<String> dateList = [];
  static dynamic indexOf = 1;

  const MeetingDatePicker({
    super.key,
    this.initialDate,
    this.maxDate,
    this.editDate = '',
    this.text,
    this.minimumDate,
    required this.onDateChanged,
  });

  @override
  State<MeetingDatePicker> createState() => _MeetingDatePickerState();
}

class _MeetingDatePickerState extends State<MeetingDatePicker> {
  String dateInput = "";
  String month = '';
  String year = '';
  bool isFirstTime = true;

  @override
  void initState() {
    dateInput = widget.editDate;
    super.initState();
  }

  void showDatePicker(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Container(
              height: kDateTimePickerContainerHeight,
              color: AppColor.white,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: kDateTimePickerHeight,
                        child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            initialDateTime: (isFirstTime != false)
                                ? widget.initialDate
                                : DateFormat.yMMMd().parse(dateInput),
                            onDateTimeChanged: (value) {
                              setState(() {
                                String formattedDate =
                                    DateFormat.yMMMd().format(value);
                                dateInput = formattedDate;
                                month = DateFormat('M').format(value);
                                year = DateFormat('yyyy').format(value);
                                widget.onDateChanged(
                                    DateFormat.yMMMd().format(value));
                                isFirstTime = false;
                              });
                            })),
                    CustomTextButton(
                        onPressed: () {
                          if (isFirstTime != false) {
                            if (widget.initialDate == null) {
                              dateInput =
                                  DateFormat.yMMMd().format(DateTime.now());
                              widget.onDateChanged(
                                  DateFormat.yMMMd().format(DateTime.now()));
                            } else {
                              dateInput = DateFormat.yMMMd()
                                  .format(widget.initialDate!);

                              setState(() {
                                widget.onDateChanged(DateFormat.yMMMd()
                                    .format(widget.initialDate!));
                              });
                            }
                          }
                          MeetingDatePicker.dateList = dateInput.split(" ");
                          Navigator.pop(context);
                        },
                        textValue: DatabaseUtil.getText('buttonDone')),
                  ]));
        });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () async {
          showDatePicker(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            dateInput.isEmpty
                ? Text(
                    DateFormat.yMMMd().format(DateTime.now()),
                    style: const TextStyle(
                        fontSize: kDatePickerTextSize, color: AppColor.black),
                  )
                : Text(dateInput,
                    style: const TextStyle(
                        fontSize: kDatePickerTextSize, color: AppColor.black)),
          ],
        ));
  }
}
