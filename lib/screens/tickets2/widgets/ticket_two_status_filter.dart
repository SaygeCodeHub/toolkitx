import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/tickets2/tickets2_bloc.dart';
import '../../../blocs/tickets2/tickets2_event.dart';
import '../../../blocs/tickets2/tickets2_state.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/enums/ticketTwo/ticket_two_status_enum.dart';
import '../../../widgets/custom_choice_chip.dart';

class TicketTwoStatusFilter extends StatelessWidget {
  const TicketTwoStatusFilter({super.key, required this.ticketsFilterMap});

  final Map ticketsFilterMap;

  @override
  Widget build(BuildContext context) {
    context.read<Tickets2Bloc>().add(SelectTicket2StatusFilter(
        selected: true, selectedIndex: ticketsFilterMap['statusname'] ?? ''));
    return Wrap(spacing: kFilterTags, children: choiceChips());
  }

  List<Widget> choiceChips() {
    List<Widget> chips = [];
    for (int i = 0; i < TicketTwoStatusEnum.values.length; i++) {
      String id = TicketTwoStatusEnum.values[i].value.toString();
      Widget item = BlocBuilder<Tickets2Bloc, Tickets2States>(
          buildWhen: (previousState, currentState) =>
              currentState is Ticket2StatusFilterSelected,
          builder: (context, state) {
            if (state is Ticket2StatusFilterSelected) {
              ticketsFilterMap["statusname"] = state.selectedIndex;
              return CustomChoiceChip(
                label: TicketTwoStatusEnum.values[i].status,
                selected: (ticketsFilterMap['statusname'] == null)
                    ? state.selected
                    : state.selectedIndex == id,
                onSelected: (bool value) {
                  context.read<Tickets2Bloc>().add(SelectTicket2StatusFilter(
                      selected: value, selectedIndex: id));
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          });
      chips.add(item);
    }
    return chips;
  }
}
