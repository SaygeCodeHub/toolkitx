import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/todo/todo_bloc.dart';
import 'package:toolkit/blocs/todo/todo_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../../blocs/todo/todo_event.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/expansion_tile_border.dart';

class ToDoSettingsSendMailExpansionTile extends StatelessWidget {
  final Map todoMap;

  const ToDoSettingsSendMailExpansionTile({Key? key, required this.todoMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ToDoBloc>().add(SelectToDoSendEmailOption(
        optionId: '1', optionName: DatabaseUtil.getText('Yes')));
    return BlocBuilder<ToDoBloc, ToDoStates>(
        buildWhen: (previousState, currentState) =>
            currentState is ToDoSendEmailOptionSelected,
        builder: (context, state) {
          if (state is ToDoSendEmailOptionSelected) {
            todoMap['assigned'] = state.optionId;
            return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: AppColor.transparent),
                child: ExpansionTile(
                    collapsedShape:
                        ExpansionTileBorder().buildOutlineInputBorder(),
                    collapsedBackgroundColor: AppColor.white,
                    backgroundColor: AppColor.white,
                    shape: ExpansionTileBorder().buildOutlineInputBorder(),
                    maintainState: true,
                    key: GlobalKey(),
                    title: Text(state.optionName,
                        style: Theme.of(context).textTheme.xSmall),
                    children: [
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.emailOptionsMap.length,
                          itemBuilder: (BuildContext context, int index) {
                            return RadioListTile(
                                contentPadding: const EdgeInsets.only(
                                    left: xxxTinierSpacing),
                                activeColor: AppColor.deepBlue,
                                title: Text(
                                    state.emailOptionsMap.values
                                        .elementAt(index),
                                    style: Theme.of(context).textTheme.xSmall),
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                value:
                                    state.emailOptionsMap.keys.elementAt(index),
                                groupValue: state.optionId,
                                onChanged: (value) {
                                  value = state.emailOptionsMap.keys
                                      .elementAt(index);
                                  context.read<ToDoBloc>().add(
                                      SelectToDoSendEmailOption(
                                          optionId: value,
                                          optionName: state
                                              .emailOptionsMap.values
                                              .elementAt(index)));
                                });
                          })
                    ]));
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
