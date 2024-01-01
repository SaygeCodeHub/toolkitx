import 'package:flutter/material.dart';

import '../../configs/app_spacing.dart';

class EquipmentDetailsTabTwo extends StatelessWidget {
  final int tabIndex;

  const EquipmentDetailsTabTwo({super.key, required this.tabIndex});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
        ),
      ),
    );
  }
}
