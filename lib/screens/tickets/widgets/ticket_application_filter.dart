import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/tickets/tickets_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/tickets/widgets/ticket_application_filter_list.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';

class TicketApplicationFilter extends StatelessWidget {
  const TicketApplicationFilter({super.key, required this.ticketsFilterMap});

  final Map ticketsFilterMap;

  @override
  Widget build(BuildContext context) {
    context.read<TicketsBloc>().add(SelectTicketApplication(
        selectApplicationName: ticketsFilterMap['appname'] ?? 0));
    return BlocBuilder<TicketsBloc, TicketsStates>(
        buildWhen: (previousState, currentState) =>
            currentState is TicketApplicationFilterSelected,
        builder: (context, state) {
          if (state is TicketApplicationFilterSelected) {
            return Column(children: [
              ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () async {
                    await Navigator.pushNamed(
                        context, TicketApplicationFilterList.routeName,
                        arguments: state.selectApplicationName);
                  },
                  title: Text(DatabaseUtil.getText('ticket_application'),
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(fontWeight: FontWeight.w600)),
                  subtitle: (context
                              .read<TicketsBloc>()
                              .selectApplicationName ==
                          '')
                      ? null
                      : Padding(
                          padding: const EdgeInsets.only(top: xxxTinierSpacing),
                          child: Text(
                              context.read<TicketsBloc>().selectApplicationName,
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
