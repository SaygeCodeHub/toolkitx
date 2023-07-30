import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/LogBook/logbook_bloc.dart';
import 'package:toolkit/blocs/LogBook/logbook_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../blocs/LogBook/logbook_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../utils/database_utils.dart';

class LogBookPriorityExpansionTile extends StatelessWidget {
  final Map reportNewLogBookMap;

  const LogBookPriorityExpansionTile(
      {Key? key, required this.reportNewLogBookMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<LogbookBloc>().add(SelectLogBookPriority(priorityName: ''));
    return BlocBuilder<LogbookBloc, LogbookStates>(
        buildWhen: (previousState, currentState) =>
            currentState is LogBookPrioritySelected,
        builder: (context, state) {
          if (state is LogBookPrioritySelected) {
            return Theme(
              data: Theme.of(context)
                  .copyWith(dividerColor: AppColor.transparent),
              child: ExpansionTile(
                  maintainState: true,
                  key: GlobalKey(),
                  title: Text(
                      (state.priorityName == '')
                          ? DatabaseUtil.getText('select_item')
                          : state.priorityName,
                      style: Theme.of(context).textTheme.xSmall),
                  children: [
                    ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.priorityMap.length,
                        itemBuilder: (BuildContext context, int index) {
                          return RadioListTile(
                              contentPadding: const EdgeInsets.only(
                                  left: kExpansionTileMargin,
                                  right: kExpansionTileMargin),
                              activeColor: AppColor.deepBlue,
                              title: Text(
                                  state.priorityMap.values.elementAt(index),
                                  style: Theme.of(context).textTheme.xSmall),
                              controlAffinity: ListTileControlAffinity.trailing,
                              value: state.priorityMap.values.elementAt(index),
                              groupValue: state.priorityName,
                              onChanged: (value) {
                                reportNewLogBookMap['priority'] =
                                    state.priorityMap.keys.elementAt(index);
                                context.read<LogbookBloc>().add(
                                    SelectLogBookPriority(
                                        priorityName: state.priorityMap.values
                                            .elementAt(index)));
                              });
                        }),
                  ]),
            );
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
