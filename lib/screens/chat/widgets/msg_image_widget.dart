import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_spacing.dart';

class MsgImageWidget extends StatelessWidget {
  final snapshot;
  final int reversedIndex;

  const MsgImageWidget(
      {super.key, required this.snapshot, required this.reversedIndex});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: kModuleImagePadding, bottom: kModuleImagePadding),
      child: Column(
        children: [
          Align(
            alignment: (snapshot.data![reversedIndex]['isReceiver'] == 1)
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0), // Rounded corners
              ),
              child: const Center(
                child: Icon(Icons.download),
              ),
            ),
          ),
          Align(
            alignment: (snapshot.data![reversedIndex]['isReceiver'] == 1)
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(tiniestSpacing),
              child: Text(
                  DateFormat('h:mm a').format(DateTime.parse(
                      snapshot.data?[reversedIndex]['msg_time'])),
                  style: Theme.of(context).textTheme.smallTextBlack),
            ),
          ),
        ],
      ),
    );
  }
}
