import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/chat/chat_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';

class ChatSubtitle extends StatelessWidget {
  final Map messageData;

  const ChatSubtitle({
    super.key,
    required this.messageData,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: (messageData['isReceiver'] == 1)
            ? Alignment.centerLeft
            : Alignment.centerRight,
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: tiniestSpacing),
            child: (messageData['isReceiver'] == 1)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Text(
                            (messageData['isReceiver'] == 1)
                                ? '${messageData['sender_name']} // '
                                : '',
                            style: Theme.of(context).textTheme.smallTextBlack,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1),
                        Text(
                            DateFormat('HH:mm').format(DateTime.parse(
                                getTimeForUserTimeZone(
                                        context, messageData['msg_time'])
                                    .toString())),
                            style: Theme.of(context)
                                .textTheme
                                .tinySmall
                                .copyWith(color: AppColor.mediumBlack))
                      ])
                : Text(
                    DateFormat('HH:mm').format(DateTime.parse(
                        getTimeForUserTimeZone(context, messageData['msg_time'])
                            .toString())),
                    style: Theme.of(context)
                        .textTheme
                        .tinySmall
                        .copyWith(color: AppColor.mediumBlack))));
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
}
