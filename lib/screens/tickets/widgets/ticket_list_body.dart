import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/tickets/fetch_tickets_model.dart';
import '../../../widgets/custom_card.dart';

class TicketListBody extends StatelessWidget {
  const TicketListBody({super.key, required this.ticketListDatum});

  final List<TicketListDatum> ticketListDatum;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: ticketListDatum.length,
        itemBuilder: (context, index) {
          return CustomCard(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: xxTinierSpacing),
            child: ListTile(
              title: Text(ticketListDatum[index].ticketNo,
                  style: Theme.of(context).textTheme.small.copyWith(
                      fontWeight: FontWeight.w600, color: AppColor.black)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: tinierSpacing),
                  Text(ticketListDatum[index].header,
                      style: Theme.of(context).textTheme.xSmall.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColor.mediumBlack)),
                  const SizedBox(height: tiniestSpacing),
                  Text(
                      "${ticketListDatum[index].priority} ${StringConstants.kpriority}",
                      style: Theme.of(context).textTheme.xSmall.copyWith(
                          fontWeight: FontWeight.w400, color: AppColor.grey)),
                  const SizedBox(height: tiniestSpacing),
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                            text:
                                '${ticketListDatum[index].commentscount} ${StringConstants.kcomments},',
                            style: Theme.of(context).textTheme.xSmall.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColor.grey)),
                        TextSpan(
                            text:
                                ' ${ticketListDatum[index].doccount} ${StringConstants.kdocuments}',
                            style: Theme.of(context).textTheme.xSmall.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColor.grey)),
                      ],
                    ),
                  )
                ],
              ),
              trailing: SizedBox(
                width: kSmallSizedBoxWidth,
                child: Text(ticketListDatum[index].statusname,
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        fontWeight: FontWeight.w500, color: AppColor.deepBlue)),
              ),
            ),
          ));
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: xxTinierSpacing);
        });
  }
}
