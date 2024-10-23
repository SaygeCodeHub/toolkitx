import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../../data/models/tickets2/fetch_ticket_two_details_model.dart';

class TicketTwoDetailsTab extends StatelessWidget {
  const TicketTwoDetailsTab({
    super.key,
    required this.ticketTwoData,
  });

  final TicketTwoData ticketTwoData;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(DatabaseUtil.getText('ticket_ticketno'),
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(ticketTwoData.ticketno),
        const SizedBox(height: xxxSmallestSpacing),
        Text(DatabaseUtil.getText('Status'),
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(ticketTwoData.statusname),
        const SizedBox(height: xxxSmallestSpacing),
        Text(DatabaseUtil.getText('ticket_header'),
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(ticketTwoData.header),
        const SizedBox(height: xxxSmallestSpacing),
        Text(DatabaseUtil.getText('Created'),
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(ticketTwoData.createddate),
        const SizedBox(height: xxxSmallestSpacing),
        Text(DatabaseUtil.getText('ticket_createdby'),
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(ticketTwoData.author),
        const SizedBox(height: xxxSmallestSpacing),
        Text(DatabaseUtil.getText('ticket_updated'),
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(ticketTwoData.updateddate),
        const SizedBox(height: xxxSmallestSpacing),
        Text(DatabaseUtil.getText('ticket_updatedby'),
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(ticketTwoData.updatedbyauthor),
        const SizedBox(height: xxxSmallestSpacing),
        Text(DatabaseUtil.getText('ticket_edt'),
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(ticketTwoData.etd),
        const SizedBox(height: xxxSmallestSpacing),
        Text(DatabaseUtil.getText('Priority'),
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(ticketTwoData.priority),
        const SizedBox(height: xxxSmallestSpacing),
        Text(DatabaseUtil.getText('Description'),
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(ticketTwoData.description),
        const SizedBox(height: xxxSmallestSpacing),
        Text(DatabaseUtil.getText('ticket_application'),
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(ticketTwoData.appname),
        const SizedBox(height: xxxSmallestSpacing),
      ]),
    );
  }
}
