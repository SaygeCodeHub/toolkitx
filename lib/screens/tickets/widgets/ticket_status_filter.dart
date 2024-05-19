import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/tickets/tickets_bloc.dart';
import 'package:toolkit/data/enums/ticket_status_enum.dart';
import '../../../configs/app_dimensions.dart';
import '../../../widgets/custom_choice_chip.dart';

class TicketStatusFilter extends StatelessWidget {
  const TicketStatusFilter({super.key, required this.ticketsFilterMap});

  final Map ticketsFilterMap;

  @override
  Widget build(BuildContext context) {
    context.read<TicketsBloc>().add(SelectTicketStatusFilter(
        selected: true, selectedIndex: ticketsFilterMap['statusname'] ?? ''));
    return Wrap(spacing: kFilterTags, children: choiceChips());
  }

  List<Widget> choiceChips() {
    List<Widget> chips = [];
    for (int i = 0; i < TicketStatusEnum.values.length; i++) {
      String id = TicketStatusEnum.values[i].value.toString();
      Widget item = BlocBuilder<TicketsBloc, TicketsStates>(
          buildWhen: (previousState, currentState) =>
              currentState is TicketStatusFilterSelected,
          builder: (context, state) {
            if (state is TicketStatusFilterSelected) {
              ticketsFilterMap["statusname"] = state.selectedIndex;
              return CustomChoiceChip(
                label: TicketStatusEnum.values[i].status,
                selected: (ticketsFilterMap['statusname'] == null)
                    ? state.selected
                    : state.selectedIndex == id,
                onSelected: (bool value) {
                  context.read<TicketsBloc>().add(SelectTicketStatusFilter(
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
