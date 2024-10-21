import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/todo/todo_bloc.dart';
import '../../../blocs/todo/todo_event.dart';
import '../../../blocs/todo/todo_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/status_tag_model.dart';
import '../../../data/models/todo/fetch_assign_todo_by_me_list_model.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/android_pop_up.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/icon_and_text_row.dart';
import '../../../widgets/progress_bar.dart';
import '../../../widgets/status_tag.dart';

class ToDoAssignedByMeSubtitle extends StatelessWidget {
  final AssignByMeListDatum assignedByMeListDatum;
  final Map todoMap;

  const ToDoAssignedByMeSubtitle(
      {super.key, required this.assignedByMeListDatum, required this.todoMap});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: tinierSpacing),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(assignedByMeListDatum.description, maxLines: 3),
              const SizedBox(height: tinierSpacing),
              Text(assignedByMeListDatum.category),
              const SizedBox(height: tinierSpacing),
              Row(children: [
                Image.asset('assets/icons/calendar.png',
                    height: kImageHeight, width: kImageWidth),
                const SizedBox(width: tiniestSpacing),
                Text(assignedByMeListDatum.duedate)
              ]),
              const SizedBox(height: tinierSpacing),
              IconAndTextRow(
                  title: assignedByMeListDatum.createdfor,
                  icon: 'human_avatar_three'),
              const SizedBox(height: tinierSpacing),
              Row(
                children: [
                  BlocListener<ToDoBloc, ToDoStates>(
                    listener: (context, state) {
                      if (state is ToDoMarkingAsDone) {
                        ProgressBar.show(context);
                      } else if (state is ToDoMarkedAsDone) {
                        ProgressBar.dismiss(context);
                        context
                            .read<ToDoBloc>()
                            .add(FetchTodoAssignedToMeAndByMeListEvent());
                      } else if (state is ToDoCannotMarkAsDone) {
                        ProgressBar.dismiss(context);
                        showCustomSnackBar(
                            context,
                            DatabaseUtil.getText(
                                'some_unknown_error_please_try_again'),
                            '');
                      }
                    },
                    child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AndroidPopUp(
                                    contentPadding: EdgeInsets.zero,
                                    titleValue: DatabaseUtil.getText(
                                        'todoConfirmMsgDone'),
                                    onPrimaryButton: () {
                                      todoMap['todoId'] =
                                          assignedByMeListDatum.id;
                                      context.read<ToDoBloc>().add(
                                          ToDoMarkAsDone(todoMap: todoMap));
                                      Navigator.pop(context);
                                    },
                                    contentValue: '');
                              });
                        },
                        icon: const Icon(Icons.check_circle,
                            color: AppColor.green, size: kIconSize)),
                  ),
                  const SizedBox(width: tinierSpacing),
                  BlocListener<ToDoBloc, ToDoStates>(
                    listener: (context, state) {
                      if (state is SendingReminderForToDo) {
                        ProgressBar.show(context);
                      } else if (state is ReminderSendForToDo) {
                        ProgressBar.dismiss(context);
                        context
                            .read<ToDoBloc>()
                            .add(FetchTodoAssignedToMeAndByMeListEvent());
                      } else if (state is ReminderCannotSendForToDo) {
                        ProgressBar.dismiss(context);
                        showCustomSnackBar(
                            context, state.cannotSendReminder, '');
                      }
                    },
                    child: Visibility(
                      visible: assignedByMeListDatum.istododue == 1,
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            todoMap['todoId'] = assignedByMeListDatum.id;
                            context
                                .read<ToDoBloc>()
                                .add(ToDoSendReminder(todoMap: todoMap));
                            showCustomSnackBar(context,
                                DatabaseUtil.getText('remindersent'), '');
                          },
                          icon: const Icon(Icons.alarm_on_sharp,
                              color: AppColor.green, size: kIconSize)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: tinierSpacing),
              StatusTag(tags: [
                StatusTagModel(
                    title: (assignedByMeListDatum.istododue == 1)
                        ? DatabaseUtil.getText('Overdue')
                        : '',
                    bgColor: AppColor.errorRed),
              ])
            ]));
  }
}
