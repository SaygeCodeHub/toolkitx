import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toolkit/blocs/chat/chat_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';

class MsgTextWidget extends StatelessWidget {
  final dynamic snapshot;
  final int reversedIndex;

  const MsgTextWidget(
      {super.key, required this.snapshot, required this.reversedIndex});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Align(
        alignment: (snapshot.data![reversedIndex]['isReceiver'] == 1)
            ? Alignment.centerLeft
            : Alignment.centerRight,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                  (snapshot.data![reversedIndex]['isReceiver'] == 1)
                      ? context
                              .read<ChatBloc>()
                              .chatDetailsMap['employee_name'] ??
                          ''
                      : '',
                  style: Theme.of(context).textTheme.tinySmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1),
              const SizedBox(height: xxTiniestSpacing),
              Container(
                  padding: const EdgeInsets.all(8.0),
                  color: (snapshot.data![reversedIndex]['isReceiver'] == 1)
                      ? AppColor.blueGrey
                      : Colors.grey[300],
                  child: Text(snapshot.data![reversedIndex]['msg'])),
            ]),
      ),
      subtitle: Align(
        alignment: (snapshot.data![reversedIndex]['isReceiver'] == 1)
            ? Alignment.centerLeft
            : Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.all(tiniestSpacing),
          child: Text(
              DateFormat('h:mm a').format(DateTime.parse(getTimeForUserTimeZone(
                      context, snapshot.data?[reversedIndex]['msg_time'])
                  .toString())),
              style: Theme.of(context).textTheme.smallTextBlack),
        ),
      ),
    );
  }
}

DateTime getTimeForUserTimeZone(BuildContext context, String time) {
  DateTime dateTime = DateTime.parse(time);
  List offset = context
      .read<ChatBloc>()
      .timeZoneFormat
      .replaceAll('+', '')
      .replaceAll('-', '')
      .split(':');
  if (context.read<ChatBloc>().timeZoneFormat.contains('+')) {
    dateTime = dateTime.toUtc().add(Duration(
        hours: int.parse(offset[0]), minutes: int.parse(offset[1].trim())));
    return dateTime;
  } else {
    dateTime = dateTime.toUtc().subtract(Duration(
        hours: int.parse(offset[0]), minutes: int.parse(offset[1].trim())));
    return dateTime;
  }
}
