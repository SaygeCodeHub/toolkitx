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
        child: Container(
          padding: const EdgeInsets.all(8),
          margin: (snapshot.data![reversedIndex]['isReceiver'] == 1)
              ? const EdgeInsets.only(right: 34.0)
              : const EdgeInsets.only(left: 34.0),
          decoration: BoxDecoration(
              color: (snapshot.data![reversedIndex]['isReceiver'] == 1)
                  ? AppColor.blueGrey
                  : Colors.grey[300],
              borderRadius: BorderRadius.circular(5)),
          child: SelectionArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (snapshot.data![reversedIndex]['isReceiver'] == 1) ...[
                  Flexible(
                    child: Text(snapshot.data![reversedIndex]['msg']),
                  ),
                  const SizedBox(height: tiniestSpacing),
                  (snapshot.data![reversedIndex]['msg_status'] != '1')
                      ? const Icon(Icons.timer, size: 13)
                      : const SizedBox.shrink(),
                ] else ...[
                  Flexible(
                    child: Text(snapshot.data![reversedIndex]['msg']),
                  ),
                  const SizedBox(height: tiniestSpacing),
                  (snapshot.data![reversedIndex]['msg_status'] != '1')
                      ? const Icon(Icons.timer, size: 13)
                      : const SizedBox.shrink(),
                ],
              ],
            ),
          ),
        ),
      ),
      subtitle: Align(
        alignment: (snapshot.data![reversedIndex]['isReceiver'] == 1)
            ? Alignment.centerLeft
            : Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: tiniestSpacing, horizontal: 0),
          child: (snapshot.data![reversedIndex]['isReceiver'] == 1)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        (snapshot.data![reversedIndex]['isReceiver'] == 1)
                            ? '${context.read<ChatBloc>().chatDetailsMap['employee_name']} // '
                            : '',
                        style: Theme.of(context).textTheme.smallTextBlack,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1),
                    Text(
                        DateFormat('HH:mm').format(DateTime.parse(
                            getTimeForUserTimeZone(context,
                                    snapshot.data?[reversedIndex]['msg_time'])
                                .toString())),
                        style: Theme.of(context)
                            .textTheme
                            .tinySmall
                            .copyWith(color: AppColor.mediumBlack)),
                  ],
                )
              : Text(
                  DateFormat('HH:mm').format(DateTime.parse(
                      getTimeForUserTimeZone(context,
                              snapshot.data?[reversedIndex]['msg_time'])
                          .toString())),
                  style: Theme.of(context)
                      .textTheme
                      .tinySmall
                      .copyWith(color: AppColor.mediumBlack)),
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
