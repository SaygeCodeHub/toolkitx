import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../../blocs/todo/todo_bloc.dart';
import '../../../blocs/todo/todo_event.dart';
import '../../../blocs/todo/todo_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';

class ToDoSettingsSendNotificationExpansionTile extends StatelessWidget {
  final Map todoMap;

  const ToDoSettingsSendNotificationExpansionTile(
      {Key? key, required this.todoMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ToDoBloc>().add(SelectToDoSendNotificationOption(
        optionId: '1', optionName: DatabaseUtil.getText('Yes')));
    return BlocBuilder<ToDoBloc, ToDoStates>(
        buildWhen: (previousState, currentState) =>
            currentState is ToDoSendNotificationOptionSelected,
        builder: (context, state) {
          if (state is ToDoSendNotificationOptionSelected) {
            todoMap['completed'] = state.optionId;
            return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: AppColor.transparent),
                child: ExpansionTile(
                    collapsedShape: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: AppColor.grey,
                      width: kExpansionBorderWidth,
                    )),
                    collapsedBackgroundColor: AppColor.white,
                    backgroundColor: AppColor.white,
                    shape: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: AppColor.grey,
                      width: kExpansionBorderWidth,
                    )),
                    maintainState: true,
                    key: GlobalKey(),
                    title: Text(state.optionName,
                        style: Theme.of(context).textTheme.xSmall),
                    children: [
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.notificationOptionsMap.length,
                          itemBuilder: (BuildContext context, int index) {
                            return RadioListTile(
                                contentPadding: const EdgeInsets.only(
                                    left: xxxTinierSpacing),
                                activeColor: AppColor.deepBlue,
                                title: Text(
                                    state.notificationOptionsMap.values
                                        .elementAt(index),
                                    style: Theme.of(context).textTheme.xSmall),
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                value: state.notificationOptionsMap.keys
                                    .elementAt(index),
                                groupValue: state.optionId,
                                onChanged: (value) {
                                  value = state.notificationOptionsMap.keys
                                      .elementAt(index);
                                  context.read<ToDoBloc>().add(
                                      SelectToDoSendNotificationOption(
                                          optionId: value,
                                          optionName: state
                                              .notificationOptionsMap.values
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
