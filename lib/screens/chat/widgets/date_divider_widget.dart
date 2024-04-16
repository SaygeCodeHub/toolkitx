import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateDividerWidget extends StatelessWidget {
  final snapshot;
  final int reversedIndex;

  const DateDividerWidget(
      {super.key, required this.snapshot, required this.reversedIndex});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
          DateFormat('MMMM d').format(
              DateTime.parse(snapshot.data?[reversedIndex]['msg_time'])),
          style: const TextStyle(fontSize: 12, color: Colors.grey)),
    );
  }
}
