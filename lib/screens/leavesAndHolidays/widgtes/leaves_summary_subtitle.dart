import 'package:flutter/material.dart';

import '../../../configs/app_spacing.dart';
import '../../../data/models/leavesAndHolidays/fetch_leaves_summary_model.dart';
import '../../../utils/database_utils.dart';

class LeavesSummarySubtitle extends StatelessWidget {
  final LeavesSummaryDatum data;

  const LeavesSummarySubtitle({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: tinierSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(DatabaseUtil.getText('Total')),
              Text(data.totalleaves.toString()),
            ],
          ),
          const SizedBox(height: tinierSpacing),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(DatabaseUtil.getText('leave_balanced')),
              Text(data.balanceleave.toString()),
            ],
          ),
          const SizedBox(height: tinierSpacing),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(DatabaseUtil.getText('Approved')),
              Text(data.leavesapprovedbynottaken.toString()),
            ],
          ),
          const SizedBox(height: tinierSpacing),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(DatabaseUtil.getText('leave_taken')),
              Text(data.leavetaken.toString()),
            ],
          ),
          const SizedBox(height: tinierSpacing),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(DatabaseUtil.getText('leave_requested')),
              Text(data.leaverequested.toString()),
            ],
          ),
          const SizedBox(height: tinierSpacing),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(DatabaseUtil.getText('Rejected')),
              Text(data.leavesrejected.toString()),
            ],
          ),
          const SizedBox(height: tinierSpacing)
        ],
      ),
    );
  }
}
