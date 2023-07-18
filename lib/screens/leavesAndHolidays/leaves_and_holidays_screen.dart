import 'package:flutter/material.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/secondary_button.dart';

import '../../configs/app_spacing.dart';
import 'leaves_details_screen.dart';
import 'leaves_summary_screen.dart';

class LeavesAndHolidaysScreen extends StatelessWidget {
  static const routeName = 'LeavesAndHolidaysScreen';

  const LeavesAndHolidaysScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('TimeAndVacation')),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: SecondaryButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, LeavesDetailsScreen.routeName);
                    },
                    textValue: StringConstants.kLeaveDetails)),
            const SizedBox(width: xxTinierSpacing),
            Expanded(
                child: SecondaryButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, LeavesSummaryScreen.routeName);
                    },
                    textValue: DatabaseUtil.getText('leave_summary')))
          ],
        ),
      ),
    );
  }
}
