import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/LogBook/logbook_bloc.dart';
import '../../../blocs/LogBook/logbook_events.dart';
import '../../../blocs/LogBook/logbook_states.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/models/LogBook/fetch_logbook_master_model.dart';
import '../../../utils/logbook_acitivity_util.dart';
import '../../../widgets/custom_choice_chip.dart';

class LogBookActivityFilter extends StatelessWidget {
  final List<List<LogBokFetchMaster>> data;
  final Map logbookFilterMap;

  const LogBookActivityFilter(
      {Key? key, required this.data, required this.logbookFilterMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<LogbookBloc>().add(SelectLogBookActivityFilter(
        selectedIndex: LogBookActivityFilterUtil().activityFilter(
            (logbookFilterMap['activity'] == null)
                ? ''
                : logbookFilterMap['activity'])));
    return Wrap(spacing: kFilterTags, children: choiceChips());
  }

  List<Widget> choiceChips() {
    List<Widget> chips = [];
    for (int i = 0; i < data[3].length; i++) {
      Widget item = BlocBuilder<LogbookBloc, LogbookStates>(
          buildWhen: (previousState, currentState) =>
              currentState is LogBookActivityFilterSelected,
          builder: (context, state) {
            if (state is LogBookActivityFilterSelected) {
              return CustomChoiceChip(
                label: data[3][i].activityname,
                selected: (logbookFilterMap['activity'] == null)
                    ? false
                    : state.selectIndex == i,
                onSelected: (bool value) {
                  state.selectIndex;
                  logbookFilterMap['activity'] = data[3][i].id.toString();
                  context
                      .read<LogbookBloc>()
                      .add(SelectLogBookActivityFilter(selectedIndex: i));
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
