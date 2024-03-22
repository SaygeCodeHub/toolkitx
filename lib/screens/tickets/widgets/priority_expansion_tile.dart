import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/tickets/tickets_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../../blocs/login/login_bloc.dart';
import '../../../blocs/login/login_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/enums/user_type_emun.dart';
import '../../../data/models/tickets/fetch_ticket_master_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/expansion_tile_border.dart';

class PriorityExpansionTile extends StatelessWidget {
  const PriorityExpansionTile(
      {Key? key, required this.ticketMasterDatum, required this.saveTicketMap})
      : super(key: key);
  final List<List<TicketMasterDatum>> ticketMasterDatum;
  final Map saveTicketMap;

  @override
  Widget build(BuildContext context) {
    String selectedValue = "";
    log("${ticketMasterDatum[0][1].priorityname}");
    context
        .read<TicketsBloc>()
        .add(SelectPriority(priorityId: 0, priorityName: ''));
    return BlocBuilder<TicketsBloc, TicketsStates>(
      buildWhen: (previousState, currentState) =>
          currentState is PrioritySelected,
      builder: (context, state) {
        if (state is PrioritySelected) {
          return Theme(
            data:
                Theme.of(context).copyWith(dividerColor: AppColor.transparent),
            child: ExpansionTile(
                key: GlobalKey(),
                collapsedBackgroundColor: AppColor.white,
                backgroundColor: AppColor.white,
                title: Text(selectedValue),
                children: [
                  MediaQuery(
                      data:
                          MediaQuery.of(context).removePadding(removeTop: true),
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: ticketMasterDatum[1].length,
                          itemBuilder: (context, listIndex) {
                            return ListTile(
                                contentPadding: const EdgeInsets.only(
                                    left: xxTinierSpacing),
                                title: Text(ticketMasterDatum[1][listIndex]
                                    .priorityname),
                                onTap: () {
                                  saveTicketMap['priority'] =
                                      ticketMasterDatum[1][listIndex].id;
                                  selectedValue = ticketMasterDatum[1]
                                          [listIndex]
                                      .priorityname;
                                  context.read<TicketsBloc>().add(
                                      SelectPriority(
                                          priorityId: ticketMasterDatum[1]
                                                  [listIndex]
                                              .id,
                                          priorityName: ticketMasterDatum[1]
                                                  [listIndex]
                                              .priorityname));
                                });
                          }))
                ]),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
