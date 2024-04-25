import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';

class MsgTextWidget extends StatelessWidget {
  final snapshot;
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
          padding: const EdgeInsets.all(8.0),
          color: (snapshot.data![reversedIndex]['isReceiver'] == 1)
              ? AppColor.blueGrey
              : Colors.grey[300],
          child: Text(snapshot.data![reversedIndex]['msg']),
        ),
      ),
      subtitle: Align(
        alignment: (snapshot.data![reversedIndex]['isReceiver'] == 1)
            ? Alignment.centerLeft
            : Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.all(tiniestSpacing),
          child: Text(
              DateFormat('h:mm a').format(
                  DateTime.parse(snapshot.data?[reversedIndex]['msg_time'])),
              style: Theme.of(context).textTheme.smallTextBlack),
        ),
      ),
    );
  }
}
