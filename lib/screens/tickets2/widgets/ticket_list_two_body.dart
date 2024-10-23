import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../blocs/tickets2/tickets2_bloc.dart';
import '../../../blocs/tickets2/tickets2_event.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/custom_card.dart';
import '../../tickets2/ticket_two_details_screen.dart';
import '../../tickets2/ticket_two_list_screen.dart';

class TicketListTwoBody extends StatelessWidget {
  const TicketListTwoBody({super.key, required this.ticketListDatum});

  final List ticketListDatum;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: (context.read<Tickets2Bloc>().hasReachedMax)
            ? ticketListDatum.length
            : ticketListDatum.length + 1,
        itemBuilder: (context, index) {
          if (index < ticketListDatum.length) {
            return CustomCard(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: xxTinierSpacing),
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, TicketTwoDetailsScreen.routeName,
                          arguments: ticketListDatum[index].id)
                      .then((_) => Navigator.pushReplacementNamed(
                          context, TicketTwoListScreen.routeName,
                          arguments: true));
                },
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
                              style: Theme.of(context)
                                  .textTheme
                                  .xSmall
                                  .copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.grey)),
                          TextSpan(
                              text:
                                  ' ${ticketListDatum[index].doccount} ${StringConstants.kdocuments}',
                              style: Theme.of(context)
                                  .textTheme
                                  .xSmall
                                  .copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.grey)),
                        ],
                      ),
                    )
                  ],
                ),
                trailing: Text(ticketListDatum[index].statusname,
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        fontWeight: FontWeight.w500, color: AppColor.deepBlue)),
              ),
            ));
          } else {
            TicketTwoListScreen.pageNo++;
            context.read<Tickets2Bloc>().add(FetchTickets2(
                pageNo: TicketTwoListScreen.pageNo, isFromHome: false));
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: xxTinierSpacing);
        });
  }
}
