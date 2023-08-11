import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/LogBook/logbook_bloc.dart';
import 'package:toolkit/blocs/LogBook/logbook_states.dart';
import '../../../blocs/LogBook/logbook_events.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/enums/logbook_priority_enum.dart';
import '../../../widgets/custom_choice_chip.dart';

class LogbookPriorityFilter extends StatelessWidget {
  final Map logbookFilterMap;

  const LogbookPriorityFilter({Key? key, required this.logbookFilterMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<LogbookBloc>().add(SelectLogBookPriorityFilter(
        selectedIndex: logbookFilterMap['pri'] ?? ''));
    return Wrap(spacing: kFilterTags, children: choiceChips());
  }

  List<Widget> choiceChips() {
    List<Widget> chips = [];
    for (int i = 0; i < LogbookPriorityEnum.values.length; i++) {
      String id = LogbookPriorityEnum.values[i].value.toString();
      Widget item = BlocBuilder<LogbookBloc, LogbookStates>(
          buildWhen: (previousState, currentState) =>
              currentState is LogBookFilterPrioritySelected,
          builder: (context, state) {
            if (state is LogBookFilterPrioritySelected) {
              logbookFilterMap['pri'] = state.selectIndex;
              return CustomChoiceChip(
                label: LogbookPriorityEnum.values[i].priority,
                selected: (logbookFilterMap['pri'] == null)
                    ? false
                    : state.selectIndex == id,
                onSelected: (bool value) {
                  context
                      .read<LogbookBloc>()
                      .add(SelectLogBookPriorityFilter(selectedIndex: id));
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
