import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/LogBook/logbook_bloc.dart';
import 'package:toolkit/blocs/LogBook/logbook_states.dart';
import '../../../blocs/LogBook/logbook_events.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/models/LogBook/fetch_logbook_master_model.dart';
import '../../../utils/logbook_filter_util.dart';
import '../../../widgets/custom_choice_chip.dart';

class LogbookFilter extends StatelessWidget {
  final List<List<LogBokFetchMaster>> data;
  final Map logbookFilterMap;

  const LogbookFilter(
      {Key? key, required this.data, required this.logbookFilterMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<LogbookBloc>().add(SelectLogBookFilter(
        selectedIndex: LogBookFilterUtil().filter(
            (logbookFilterMap['lgbooks'] == null)
                ? ''
                : logbookFilterMap['lgbooks'])));
    return Wrap(spacing: kFilterTags, children: choiceChips());
  }

  List<Widget> choiceChips() {
    List<Widget> chips = [];
    for (int i = 0; i < data[0].length; i++) {
      Widget item = BlocBuilder<LogbookBloc, LogbookStates>(
          buildWhen: (previousState, currentState) =>
              currentState is LogBookFilterSelected,
          builder: (context, state) {
            if (state is LogBookFilterSelected) {
              return CustomChoiceChip(
                label: data[0][i].name,
                selected: (logbookFilterMap['lgbooks'] == null)
                    ? false
                    : state.selectIndex == i,
                onSelected: (bool value) {
                  state.selectIndex;
                  logbookFilterMap['lgbooks'] = data[0][i].id.toString();
                  context
                      .read<LogbookBloc>()
                      .add(SelectLogBookFilter(selectedIndex: i));
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
