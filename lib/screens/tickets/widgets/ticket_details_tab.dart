import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../../data/models/tickets/fetch_ticket_details_model.dart';

class TicketDetailsTab extends StatelessWidget {
  const TicketDetailsTab({
    super.key,
    required this.data,
  });

  final TicketData data;

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
        Text(data.ticketno),
        const SizedBox(height: xxxSmallestSpacing),
        Text(DatabaseUtil.getText('Status'),
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.statusname),
        const SizedBox(height: xxxSmallestSpacing),
        Text(DatabaseUtil.getText('ticket_header'),
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.header),
        const SizedBox(height: xxxSmallestSpacing),
        Text(DatabaseUtil.getText('Created'),
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.createddate),
        const SizedBox(height: xxxSmallestSpacing),
        Text(DatabaseUtil.getText('ticket_createdby'),
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.createdby),
        const SizedBox(height: xxxSmallestSpacing),
        Text(DatabaseUtil.getText('ticket_updated'),
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.updateddate),
        const SizedBox(height: xxxSmallestSpacing),
        Text(DatabaseUtil.getText('ticket_updatedby'),
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.updatedby),
        const SizedBox(height: xxxSmallestSpacing),
        Text(DatabaseUtil.getText('ticket_edt'),
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.etd),
        const SizedBox(height: xxxSmallestSpacing),
        Text(DatabaseUtil.getText('Priority'),
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.priority),
        const SizedBox(height: xxxSmallestSpacing),
        Text(DatabaseUtil.getText('Description'),
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.description),
        const SizedBox(height: xxxSmallestSpacing),
        Text(DatabaseUtil.getText('ticket_application'),
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: tiniestSpacing),
        Text(data.appname),
        const SizedBox(height: xxxSmallestSpacing),
      ]),
    );
  }
}
