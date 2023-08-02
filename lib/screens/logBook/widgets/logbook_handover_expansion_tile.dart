import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/LogBook/logbook_bloc.dart';
import 'package:toolkit/blocs/LogBook/logbook_events.dart';
import 'package:toolkit/blocs/LogBook/logbook_states.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../utils/database_utils.dart';

class LogBookHandoverExpansionTile extends StatelessWidget {
  final Map reportNewLogBookMap;

  const LogBookHandoverExpansionTile(
      {Key? key, required this.reportNewLogBookMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<LogbookBloc>().add(
        SelectLogBookHandoverLog(handoverValue: DatabaseUtil.getText('No')));
    return BlocBuilder<LogbookBloc, LogbookStates>(
        buildWhen: (previousState, currentState) =>
            currentState is LogBookHandoverSelected,
        builder: (context, state) {
          if (state is LogBookHandoverSelected) {
            return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: AppColor.transparent),
                child: ExpansionTile(
                    maintainState: true,
                    key: GlobalKey(),
                    title: Text((state.handoverValue == '')
                        ? DatabaseUtil.getText('select_item')
                        : state.handoverValue),
                    children: [
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.handoverMap.length,
                          itemBuilder: (BuildContext context, int index) {
                            return RadioListTile(
                                contentPadding: const EdgeInsets.only(
                                    left: kExpansionTileMargin,
                                    right: kExpansionTileMargin),
                                activeColor: AppColor.deepBlue,
                                title: Text(
                                    state.handoverMap.values.elementAt(index),
                                    style: Theme.of(context).textTheme.xSmall),
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                value:
                                    state.handoverMap.values.elementAt(index),
                                groupValue: state.handoverValue,
                                onChanged: (value) {
                                  value =
                                      state.handoverMap.values.elementAt(index);
                                  reportNewLogBookMap['handover'] =
                                      state.handoverMap.keys.elementAt(index);
                                  context.read<LogbookBloc>().add(
                                      SelectLogBookHandoverLog(
                                          handoverValue: value));
                                });
                          })
                    ]));
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
