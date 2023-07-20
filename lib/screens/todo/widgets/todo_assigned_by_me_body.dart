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
import '../../../data/models/todo/fetch_assign_todo_by_me_list_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/android_pop_up.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/progress_bar.dart';
import '../todo_details_and_document_details_screen.dart';
import 'todo_assigned_by_me_subtitle.dart';

class TodoAssignedByMeBody extends StatelessWidget {
  final List<AssignByMeListDatum> assignedByMeListDatum;
  final Map todoMap;

  const TodoAssignedByMeBody(
      {Key? key, required this.assignedByMeListDatum, required this.todoMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (assignedByMeListDatum.isEmpty)
        ? Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 3.5),
            child: Center(
                child: Text(StringConstants.kNoToDoAssignedBy,
                    style: Theme.of(context).textTheme.small.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColor.mediumBlack))),
          )
        : Expanded(
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: assignedByMeListDatum.length,
                itemBuilder: (context, index) {
                  return CustomCard(
                      child: Padding(
                          padding: const EdgeInsets.only(top: tinierSpacing),
                          child: ListTile(
                              onTap: () {
                                todoMap['todoId'] =
                                    assignedByMeListDatum[index].id;
                                todoMap['todoName'] =
                                    assignedByMeListDatum[index].todoname;
                                Navigator.pushNamed(
                                    context,
                                    ToDoDetailsAndDocumentDetailsScreen
                                        .routeName,
                                    arguments: todoMap);
                              },
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(assignedByMeListDatum[index].todoname,
                                      style: Theme.of(context)
                                          .textTheme
                                          .small
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.black)),
                                  BlocListener<ToDoBloc, ToDoStates>(
                                    listener: (context, state) {
                                      if (state is ToDoMarkingAsDone) {
                                        ProgressBar.show(context);
                                      } else if (state is ToDoMarkedAsDone) {
                                        ProgressBar.dismiss(context);
                                        context.read<ToDoBloc>().add(
                                            FetchTodoAssignedToMeAndByMeListEvent());
                                      } else if (state
                                          is ToDoCannotMarkAsDone) {
                                        ProgressBar.dismiss(context);
                                        showCustomSnackBar(context,
                                            state.cannotMarkAsDone, '');
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
                                                    titleValue:
                                                        DatabaseUtil.getText(
                                                            'DeleteRecord'),
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    onPressed: () {
                                                      todoMap['todoId'] =
                                                          assignedByMeListDatum[
                                                                  index]
                                                              .id;
                                                      context
                                                          .read<ToDoBloc>()
                                                          .add(ToDoMarkAsDone(
                                                              todoMap:
                                                                  todoMap));
                                                      Navigator.pop(context);
                                                    },
                                                    contentValue: '');
                                              });
                                        },
                                        icon: const Icon(Icons.check_circle,
                                            color: AppColor.green,
                                            size: kIconSize)),
                                  )
                                ],
                              ),
                              subtitle: ToDoAssignedByMeSubtitle(
                                  assignedByMeListDatum:
                                      assignedByMeListDatum[index]))));
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: tinierSpacing);
                }),
          );
  }
}
