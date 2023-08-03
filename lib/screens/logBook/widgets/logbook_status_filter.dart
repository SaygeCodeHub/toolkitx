import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/LogBook/logbook_bloc.dart';

import '../../../blocs/LogBook/logbook_events.dart';
import '../../../blocs/LogBook/logbook_states.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/enums/logbook_status_enum.dart';
import '../../../widgets/custom_choice_chip.dart';

class LogbookStatusFilter extends StatelessWidget {
  final Map logbookFilterMap;

  const LogbookStatusFilter({Key? key, required this.logbookFilterMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<LogbookBloc>().add(SelectLogBookStatusFilter(
        selectedIndex: logbookFilterMap['status'] == "1" ? 0 : 1));
    return Wrap(spacing: kFilterTags, children: choiceChips());
  }

  List<Widget> choiceChips() {
    List<Widget> chips = [];
    for (int i = 0; i < LogbookStatusEnum.values.length; i++) {
      Widget item = BlocBuilder<LogbookBloc, LogbookStates>(
          buildWhen: (previousState, currentState) =>
              currentState is LogBookFilterStatusSelected,
          builder: (context, state) {
            if (state is LogBookFilterStatusSelected) {
              return CustomChoiceChip(
                label: LogbookStatusEnum.values[i].status,
                selected: (logbookFilterMap['status'] == null)
                    ? false
                    : state.selectIndex == i,
                onSelected: (bool value) {
                  state.selectIndex;
                  logbookFilterMap['status'] =
                      LogbookStatusEnum.values[i].value.toString();
                  context
                      .read<LogbookBloc>()
                      .add(SelectLogBookStatusFilter(selectedIndex: i));
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
