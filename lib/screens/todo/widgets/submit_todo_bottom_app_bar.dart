import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/todo/todo_bloc.dart';
import '../../../blocs/todo/todo_event.dart';
import '../../../blocs/todo/todo_states.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/android_pop_up.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/progress_bar.dart';

class SubmitToDoBottomAppBar extends StatelessWidget {
  final Map todoMap;

  const SubmitToDoBottomAppBar({Key? key, required this.todoMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: todoMap['isFromAdd'] == true,
      child: BottomAppBar(
        child: Row(
          children: [
            Expanded(
              child: PrimaryButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                textValue: DatabaseUtil.getText('buttonBack'),
              ),
            ),
            const SizedBox(width: xxTinierSpacing),
            BlocListener<TodoBloc, ToDoStates>(
              listener: (context, state) {
                if (state is SubmittingToDo) {
                  ProgressBar.show(context);
                } else if (state is ToDoSubmitted) {
                  ProgressBar.dismiss(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  context
                      .read<TodoBloc>()
                      .add(FetchTodoAssignedToMeAndByMeListEvent());
                } else if (state is ToDoNotSubmitted) {
                  ProgressBar.dismiss(context);
                  showCustomSnackBar(context, state.todoNotSubmitted, '');
                }
              },
              child: Expanded(
                child: PrimaryButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AndroidPopUp(
                            contentPadding: EdgeInsets.zero,
                            titleValue: StringConstants.kSubmitTodoPopUp,
                            contentValue: '',
                            onPressed: () {
                              context
                                  .read<TodoBloc>()
                                  .add(SubmitToDo(todoMap: todoMap));
                              Navigator.pop(context);
                            },
                          );
                        });
                  },
                  textValue: StringConstants.kSubmitTodo,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
