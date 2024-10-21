import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/LogBook/logbook_bloc.dart';
import 'package:toolkit/blocs/LogBook/logbook_states.dart';
import '../../../blocs/LogBook/logbook_events.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/models/LogBook/fetch_logbook_master_model.dart';
import '../../../widgets/custom_choice_chip.dart';

class LogbookFilter extends StatelessWidget {
  final List<List<LogBokFetchMaster>> data;
  final Map logbookFilterMap;

  const LogbookFilter(
      {super.key, required this.data, required this.logbookFilterMap});

  @override
  Widget build(BuildContext context) {
    context.read<LogbookBloc>().add(
        SelectLogBookFilter(selectedIndex: logbookFilterMap['lgbooks'] ?? ''));
    return Wrap(spacing: kFilterTags, children: choiceChips());
  }

  List<Widget> choiceChips() {
    List<Widget> chips = [];
    for (int i = 0; i < data[0].length; i++) {
      String id = data[0][i].id.toString();
      Widget item = BlocBuilder<LogbookBloc, LogbookStates>(
          buildWhen: (previousState, currentState) =>
              currentState is LogBookFilterSelected,
          builder: (context, state) {
            if (state is LogBookFilterSelected) {
              logbookFilterMap['lgbooks'] = state.selectIndex;
              return CustomChoiceChip(
                label: data[0][i].name,
                selected: (logbookFilterMap['lgbooks'] == null)
                    ? false
                    : state.selectIndex == id,
                onSelected: (bool value) {
                  context
                      .read<LogbookBloc>()
                      .add(SelectLogBookFilter(selectedIndex: id));
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
