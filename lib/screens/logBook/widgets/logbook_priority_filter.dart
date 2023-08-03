import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/LogBook/logbook_bloc.dart';
import 'package:toolkit/blocs/LogBook/logbook_states.dart';
import '../../../blocs/LogBook/logbook_events.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/enums/logbook_priority_enum.dart';
import '../../../utils/logbook_priotity_filter_util.dart';
import '../../../widgets/custom_choice_chip.dart';

class LogbookPriorityFilter extends StatelessWidget {
  final Map logbookFilterMap;

  const LogbookPriorityFilter({Key? key, required this.logbookFilterMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<LogbookBloc>().add(SelectLogBookPriorityFilter(
        selectedIndex: LogBookPriorityFilterUtil().priorityFilter(
            (logbookFilterMap['pri'] == null) ? '' : logbookFilterMap['pri'])));
    return Wrap(spacing: kFilterTags, children: choiceChips());
  }

  List<Widget> choiceChips() {
    List<Widget> chips = [];
    for (int i = 0; i < LogbookPriorityEnum.values.length; i++) {
      Widget item = BlocBuilder<LogbookBloc, LogbookStates>(
          buildWhen: (previousState, currentState) =>
              currentState is LogBookFilterPrioritySelected,
          builder: (context, state) {
            if (state is LogBookFilterPrioritySelected) {
              return CustomChoiceChip(
                label: LogbookPriorityEnum.values[i].priority,
                selected: (logbookFilterMap['pri'] == null)
                    ? false
                    : state.selectIndex == i,
                onSelected: (bool value) {
                  state.selectIndex;
                  logbookFilterMap['pri'] =
                      LogbookPriorityEnum.values[i].value.toString();
                  context
                      .read<LogbookBloc>()
                      .add(SelectLogBookPriorityFilter(selectedIndex: i));
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
