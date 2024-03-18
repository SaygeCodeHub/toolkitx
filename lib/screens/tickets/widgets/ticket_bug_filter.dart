import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/tickets/tickets_bloc.dart';
import 'package:toolkit/data/enums/ticket_Bug_enum.dart';
import '../../../configs/app_dimensions.dart';
import '../../../widgets/custom_choice_chip.dart';

class TicketBugFilter extends StatelessWidget {
  const TicketBugFilter({super.key, required this.ticketsFilterMap});

  final Map ticketsFilterMap;

  @override
  Widget build(BuildContext context) {
    context.read<TicketsBloc>().add(SelectTicketBugFilter(
        selected: true, selectedIndex: ticketsFilterMap['isbug'] ?? ''));
    return Wrap(spacing: kFilterTags, children: choiceChips());
  }

  List<Widget> choiceChips() {
    List<Widget> chips = [];
    for (int i = 0; i < TicketBugEnum.values.length; i++) {
      String id = TicketBugEnum.values[i].value.toString();
      Widget item = BlocBuilder<TicketsBloc, TicketsStates>(
          buildWhen: (previousState, currentState) =>
              currentState is TicketBugFilterSelected,
          builder: (context, state) {
            if (state is TicketBugFilterSelected) {
              ticketsFilterMap["isbug"] = state.selectedIndex;
              return CustomChoiceChip(
                label: TicketBugEnum.values[i].option,
                selected: (ticketsFilterMap['isbug'] == null)
                    ? state.selected
                    : state.selectedIndex == id,
                onSelected: (bool value) {
                  context.read<TicketsBloc>().add(SelectTicketBugFilter(
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
