import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../../../configs/app_color.dart';
import '../../../blocs/leavesAndHolidays/leaves_and_holidays_bloc.dart';
import '../../../blocs/leavesAndHolidays/leaves_and_holidays_events.dart';
import '../../../widgets/text_button.dart';

typedef StringCallBack = Function(String date);

class DatePickerTextButton extends StatefulWidget {
  final DateTime? initialDate;
  final StringCallBack onDateChanged;
  final DateTime? maxDate;
  final String editDate;
  final String? text;
  final DateTime? minimumDate;
  static List<String> dateList = [];
  static dynamic indexOf = 1;

  const DatePickerTextButton({
    Key? key,
    this.initialDate,
    this.maxDate,
    this.editDate = '',
    this.text,
    this.minimumDate,
    required this.onDateChanged,
  }) : super(key: key);

  @override
  State<DatePickerTextButton> createState() => _DatePickerTextFieldState();
}

class _DatePickerTextFieldState extends State<DatePickerTextButton> {
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
                                : DateFormat('MMMM yyyy').parse(dateInput),
                            onDateTimeChanged: (value) {
                              setState(() {
                                String formattedDate =
                                    DateFormat('MMMM yyyy').format(value);
                                dateInput = formattedDate;
                                month = DateFormat('M').format(value);
                                year = DateFormat('yyyy').format(value);
                                widget.onDateChanged(
                                    DateFormat('MMMM yyyy').format(value));
                                isFirstTime = false;
                              });
                            },
                            maximumDate:
                                DateTime.now().add(const Duration(days: 180)))),
                    CustomTextButton(
                        onPressed: () {
                          if (isFirstTime != false) {
                            if (widget.initialDate == null) {
                              dateInput = DateFormat('MMMM yyyy')
                                  .format(DateTime.now());
                              widget.onDateChanged(DateFormat('MMMM yyyy')
                                  .format(DateTime.now()));
                            } else {
                              dateInput = DateFormat('MMMM yyyy')
                                  .format(widget.initialDate!);

                              setState(() {
                                widget.onDateChanged(DateFormat('MMMM yyyy')
                                    .format(widget.initialDate!));
                              });
                            }
                          }
                          DatePickerTextButton.dateList = dateInput.split(" ");
                          context
                              .read<LeavesAndHolidaysBloc>()
                              .add(GetTimeSheet(month: month, year: year));
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
                    DateFormat('MMMM yyyy').format(DateTime.now()),
                    style: const TextStyle(
                        fontSize: kDatePickerTextSize, color: AppColor.black),
                  )
                : Text(dateInput,
                    style: const TextStyle(
                        fontSize: kDatePickerTextSize, color: AppColor.black)),
            const Icon(Icons.calendar_month, color: AppColor.black),
          ],
        ));
  }
}
