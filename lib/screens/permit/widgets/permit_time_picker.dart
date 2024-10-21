import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/text_button.dart';

typedef StringCallBack = Function(String time);

class PermitTimePicker extends StatefulWidget {
  final StringCallBack onTimeChanged;
  final DateTime? initialDateTime;
  final String editTime;
  final String? hintText;
  final DateTime? minimumTime;

  const PermitTimePicker({
    super.key,
    this.initialDateTime,
    this.editTime = '',
    this.hintText,
    this.minimumTime,
    required this.onTimeChanged,
  });

  @override
  State<PermitTimePicker> createState() => _PermitTimePickerState();
}

class _PermitTimePickerState extends State<PermitTimePicker> {
  final TextEditingController timeInputController = TextEditingController();
  bool? isFirstTime = true;

  @override
  void initState() {
    timeInputController.text = widget.editTime;
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
                            mode: CupertinoDatePickerMode.time,
                            use24hFormat: true,
                            initialDateTime: (isFirstTime != false)
                                ? widget.initialDateTime
                                : DateFormat("HH:mm")
                                    .parse(timeInputController.text),
                            onDateTimeChanged: (value) {
                              setState(() {
                                String formattedDate =
                                    DateFormat("HH:mm").format(value);
                                timeInputController.text = formattedDate;
                                widget.onTimeChanged(timeInputController.text);
                                isFirstTime = false;
                              });
                            },
                            minuteInterval: 1)),
                    CustomTextButton(
                        onPressed: () {
                          if (isFirstTime != false) {
                            if (widget.initialDateTime == null) {
                              timeInputController.text =
                                  DateFormat('HH:mm').format(DateTime.now());
                              widget.onTimeChanged(timeInputController.text);
                            } else {
                              timeInputController.text = DateFormat('HH:mm')
                                  .format(widget.initialDateTime!);
                              widget.onTimeChanged(timeInputController.text);
                            }
                          }
                          Navigator.pop(context);
                        },
                        textValue: DatabaseUtil.getText('buttonDone'))
                  ]));
        });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        readOnly: true,
        controller: timeInputController,
        onTap: () async {
          showDatePicker(context);
        },
        cursorColor: AppColor.black,
        decoration: InputDecoration(
            hintStyle: Theme.of(context).textTheme.xSmall.copyWith(
                color: AppColor.black, fontSize: kPermitDatePickerFontSize),
            hintText: widget.hintText,
            contentPadding: const EdgeInsets.all(xxTinierSpacing),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.lightGrey)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.lightGrey)),
            filled: true,
            fillColor: AppColor.white));
  }
}
