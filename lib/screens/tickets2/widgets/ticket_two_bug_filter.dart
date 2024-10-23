import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/tickets2/tickets2_bloc.dart';
import '../../../blocs/tickets2/tickets2_event.dart';
import '../../../blocs/tickets2/tickets2_state.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/enums/ticketTwo/ticket_two_bug_enum.dart';
import '../../../widgets/custom_choice_chip.dart';

class TicketTwoBugFilter extends StatelessWidget {
  const TicketTwoBugFilter({super.key, required this.ticketsFilterMap});

  final Map ticketsFilterMap;

  @override
  Widget build(BuildContext context) {
    context.read<Tickets2Bloc>().add(SelectTicket2BugFilter(
        selected: true, selectedIndex: ticketsFilterMap['isbug'] ?? ''));
    return Wrap(spacing: kFilterTags, children: choiceChips());
  }

  List<Widget> choiceChips() {
    List<Widget> chips = [];
    for (int i = 0; i < TicketTwoBugEnum.values.length; i++) {
      String id = TicketTwoBugEnum.values[i].value.toString();
      Widget item = BlocBuilder<Tickets2Bloc, Tickets2States>(
          buildWhen: (previousState, currentState) =>
              currentState is Ticket2BugFilterSelected,
          builder: (context, state) {
            if (state is Ticket2BugFilterSelected) {
              ticketsFilterMap["isbug"] = state.selectedIndex;
              return CustomChoiceChip(
                label: TicketTwoBugEnum.values[i].option,
                selected: (ticketsFilterMap['isbug'] == null)
                    ? state.selected
                    : state.selectedIndex == id,
                onSelected: (bool value) {
                  context.read<Tickets2Bloc>().add(SelectTicket2BugFilter(
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
