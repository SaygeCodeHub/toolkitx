import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/tickets2/tickets2_bloc.dart';
import '../../../blocs/tickets2/tickets2_event.dart';
import '../../../blocs/tickets2/tickets2_state.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';

class Ticket2PriorityTile extends StatefulWidget {
  const Ticket2PriorityTile(
      {super.key, required this.priorityList, required this.saveTicketMap});

  final List priorityList;
  final Map saveTicketMap;

  @override
  State<Ticket2PriorityTile> createState() => _Ticket2PriorityTileState();
}

class _Ticket2PriorityTileState extends State<Ticket2PriorityTile> {
  String priorityName = '';

  @override
  Widget build(BuildContext context) {
    context
        .read<Tickets2Bloc>()
        .add(SelectTicketTwoPriority(priorityId: 0, priorityName: ''));
    return BlocBuilder<Tickets2Bloc, Tickets2States>(
      buildWhen: (previousState, currentState) =>
          currentState is TicketTwoPrioritySelected,
      builder: (context, state) {
        if (state is TicketTwoPrioritySelected) {
          return Theme(
            data:
                Theme.of(context).copyWith(dividerColor: AppColor.transparent),
            child: ExpansionTile(
                key: GlobalKey(),
                collapsedBackgroundColor: AppColor.white,
                backgroundColor: AppColor.white,
                title: Text(priorityName),
                children: [
                  SizedBox(
                    height: kPermitEditSwitchingExpansionTileHeight,
                    child: MediaQuery(
                        data: MediaQuery.of(context)
                            .removePadding(removeTop: true),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: widget.priorityList.length,
                            itemBuilder: (context, listIndex) {
                              return ListTile(
                                  contentPadding: const EdgeInsets.only(
                                      left: xxTinierSpacing),
                                  title: Text(widget
                                      .priorityList[listIndex].priorityname),
                                  onTap: () {
                                    setState(() {
                                      widget.saveTicketMap['priority'] =
                                          widget.priorityList[listIndex].id;
                                      priorityName = widget
                                          .priorityList[listIndex].priorityname;
                                    });
                                  });
                            })),
                  )
                ]),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
