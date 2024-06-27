import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../configs/app_spacing.dart';

class DateDividerWidget extends StatelessWidget {
  final String msgTime;

  const DateDividerWidget({super.key, required this.msgTime});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: xxxTinierSpacing),
        child: Text(DateFormat('MMMM d').format(DateTime.parse(msgTime)),
            style: Theme.of(context)
                .textTheme
                .xxSmall
                .copyWith(color: Colors.grey)));
  }
}
