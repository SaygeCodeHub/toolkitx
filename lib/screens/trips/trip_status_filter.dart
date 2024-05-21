import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../configs/app_dimensions.dart';
import '../../../widgets/custom_choice_chip.dart';
import '../../blocs/trips/trip_bloc.dart';
import '../../data/enums/trip_status_enum.dart';

class TripStatusFilter extends StatelessWidget {
  const TripStatusFilter({super.key, required this.tripFilterMap});

  final Map tripFilterMap;

  @override
  Widget build(BuildContext context) {
    context.read<TripBloc>().add(SelectTripStatusFilter(
        selected: true, selectedIndex: tripFilterMap['status'] ?? ''));
    return Wrap(spacing: kFilterTags, children: choiceChips());
  }

  List<Widget> choiceChips() {
    List<Widget> chips = [];
    for (int i = 0; i < TripStatusEnum.values.length; i++) {
      String id = TripStatusEnum.values[i].value.toString();
      Widget item = BlocBuilder<TripBloc, TripState>(
          buildWhen: (previousState, currentState) =>
              currentState is TripsStatusFilterSelected,
          builder: (context, state) {
            if (state is TripsStatusFilterSelected) {
              tripFilterMap["status"] = state.selectedIndex;
              return CustomChoiceChip(
                label: TripStatusEnum.values[i].status,
                selected: (tripFilterMap["status"] == null)
                    ? state.selected
                    : state.selectedIndex == id,
                onSelected: (bool value) {
                  context.read<TripBloc>().add(SelectTripStatusFilter(
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
