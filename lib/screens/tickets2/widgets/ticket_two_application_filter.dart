import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/tickets2/widgets/ticket_two_application_filter_list.dart';

import '../../../blocs/tickets2/tickets2_bloc.dart';
import '../../../blocs/tickets2/tickets2_event.dart';
import '../../../blocs/tickets2/tickets2_state.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';

class TicketTwoApplicationFilter extends StatelessWidget {
  const TicketTwoApplicationFilter({super.key, required this.ticketsFilterMap});

  final Map ticketsFilterMap;

  @override
  Widget build(BuildContext context) {
    context.read<Tickets2Bloc>().add(SelectTicket2Application(
        selectApplicationName: ticketsFilterMap['appname'] ?? 0));
    return BlocBuilder<Tickets2Bloc, Tickets2States>(
        buildWhen: (previousState, currentState) =>
            currentState is Ticket2ApplicationFilterSelected,
        builder: (context, state) {
          if (state is Ticket2ApplicationFilterSelected) {
            return Column(children: [
              ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () async {
                    await Navigator.pushNamed(
                        context, TicketTwoApplicationFilterList.routeName,
                        arguments: state.selectApplicationName);
                  },
                  title: Text(DatabaseUtil.getText('ticket_application'),
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(fontWeight: FontWeight.w600)),
                  subtitle:
                      (context.read<Tickets2Bloc>().selectApplicationName == '')
                          ? null
                          : Padding(
                              padding:
                                  const EdgeInsets.only(top: xxxTinierSpacing),
                              child: Text(
                                  context
                                      .read<Tickets2Bloc>()
                                      .selectApplicationName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .xSmall
                                      .copyWith(color: AppColor.black)),
                            ),
                  trailing:
                      const Icon(Icons.navigate_next_rounded, size: kIconSize)),
            ]);
          } else {
            return const SizedBox();
          }
        });
  }
}
