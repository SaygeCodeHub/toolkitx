import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/tickets2/fetch_ticket_two_details_model.dart';
import '../../../widgets/custom_card.dart';

class TicketTwoCommentsTab extends StatelessWidget {
  const TicketTwoCommentsTab({super.key, required this.ticketTwoData});

  final TicketTwoData ticketTwoData;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: ticketTwoData.comments.length,
      itemBuilder: (context, index) {
        return CustomCard(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: tiniestSpacing),
            child: ListTile(
              title: Text(ticketTwoData.comments[index].comment,
                  style: Theme.of(context).textTheme.xSmall.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColor.mediumBlack)),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: xxTinierSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(ticketTwoData.comments[index].author,
                        style: Theme.of(context).textTheme.xSmall.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColor.mediumBlack)),
                    Text(ticketTwoData.comments[index].createddate,
                        style: Theme.of(context).textTheme.xSmall.copyWith(
                            fontWeight: FontWeight.w400, color: AppColor.grey)),
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
