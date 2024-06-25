import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/todo/todo_bloc.dart';
import '../../../blocs/todo/todo_event.dart';
import '../../../blocs/todo/todo_states.dart';
import '../../../data/models/todo/fetch_todo_details_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/android_pop_up.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/progress_bar.dart';

class SubmitToDoButton extends StatelessWidget {
  final Map todoMap;
  final ToDoDetailsData todoDetails;

  const SubmitToDoButton(
      {Key? key, required this.todoMap, required this.todoDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: todoDetails.isdraft == '1',
      child: BottomAppBar(
        child: BlocListener<ToDoBloc, ToDoStates>(
          listener: (context, state) {
            if (state is SubmittingToDo) {
              ProgressBar.show(context);
            } else if (state is ToDoSubmitted) {
              ProgressBar.dismiss(context);
              Navigator.pop(context);
              Navigator.pop(context);
              context
                  .read<ToDoBloc>()
                  .add(FetchTodoAssignedToMeAndByMeListEvent());
            } else if (state is ToDoNotSubmitted) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.todoNotSubmitted, '');
            }
          },
          child: PrimaryButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AndroidPopUp(
                      contentPadding: EdgeInsets.zero,
                      titleValue: StringConstants.kSubmitTodoPopUp,
                      contentValue: '',
                      onPrimaryButton: () {
                        context
                            .read<ToDoBloc>()
                            .add(SubmitToDo(todoMap: todoMap));
                        Navigator.pop(context);
                      },
                    );
                  });
            },
            textValue: StringConstants.kSubmitTodo,
          ),
        ),
      ),
    );
  }
}
