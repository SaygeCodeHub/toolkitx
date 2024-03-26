import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/tickets/fetch_ticket_details_model.dart';
import '../../../widgets/custom_card.dart';

class TicketCommentsTab extends StatelessWidget {
  const TicketCommentsTab({super.key, required this.ticketData});
  final TicketData ticketData;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: ticketData.documents.length,
      itemBuilder: (context, index) {
        return CustomCard(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: tiniestSpacing),
            child: ListTile(
              title: Text(ticketData.comments[index].comment,
                  style: Theme.of(context).textTheme.xSmall.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColor.mediumBlack)),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: xxTinierSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(ticketData.comments[index].author,
                        style: Theme.of(context).textTheme.xSmall.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColor.mediumBlack)),
                    Text(ticketData.comments[index].createddate,
                        style: Theme.of(context).textTheme.xSmall.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColor.grey)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: xxTinierSpacing);
      },
    );
  }
}
