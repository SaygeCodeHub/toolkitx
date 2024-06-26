import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import '../../blocs/todo/todo_event.dart';
import '../../blocs/todo/todo_states.dart';
import '../../blocs/todo/todo_bloc.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../utils/todo_util.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/custom_tabbar_view.dart';
import '../../widgets/progress_bar.dart';
import 'widgets/todo_details_tab.dart';
import 'widgets/todo_document_details_tab.dart';
import 'widgets/todo_pop_up_menu.dart';

class ToDoDetailsAndDocumentDetailsScreen extends StatelessWidget {
  static const routeName = 'ToDoDetailsAndDocumentDetailsScreen';
  final String todoId;
  static Map todoMap = {};

  const ToDoDetailsAndDocumentDetailsScreen({Key? key, required this.todoId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    todoMap['todoId'] = todoId;
    context.read<ToDoBloc>().add(
        FetchToDoDetailsAndDocumentDetails(selectedIndex: 0, todoId: todoId));
    return Scaffold(
      appBar: GenericAppBar(
        actions: [ToDoPopUpMenu(todoMap: todoMap)],
      ),
      body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxTinierSpacing),
          child: Column(children: [
            Card(
                color: AppColor.white,
                elevation: kCardElevation,
                child: ListTile(
                    title: Padding(
                        padding: const EdgeInsets.only(top: xxTinierSpacing),
                        child: BlocBuilder<ToDoBloc, ToDoStates>(
                            buildWhen: (previousState, currentState) =>
                                currentState
                                    is TodoDetailsAndDocumentDetailsFetched,
                            builder: (context, state) {
                              if (state
                                  is TodoDetailsAndDocumentDetailsFetched) {
                                return Text(
                                    state.fetchToDoDetailsModel.data.todo,
                                    style: Theme.of(context).textTheme.medium);
                              } else {
                                return const SizedBox.shrink();
                              }
                            })))),
            const SizedBox(height: xxTinierSpacing),
            const Divider(height: kDividerHeight, thickness: kDividerWidth),
            BlocConsumer<ToDoBloc, ToDoStates>(
                listener: (context, state) {
                  if (state is PopUpMenuToDoMarkingAsDone) {
                    ProgressBar.show(context);
                  } else if (state is PopUpMenuToDoMarkedAsDone) {
                    ProgressBar.dismiss(context);
                    Navigator.pop(context);
                    context
                        .read<ToDoBloc>()
                        .add(FetchTodoAssignedToMeAndByMeListEvent());
                  } else if (state is PopUpMenuToDoCannotMarkAsDone) {
                    ProgressBar.dismiss(context);
                    showCustomSnackBar(context, state.cannotMarkAsDone, '');
                  }
                },
                buildWhen: (previousState, currentState) =>
                    currentState is FetchingTodoDetailsAndDocumentDetails ||
                    currentState is TodoDetailsAndDocumentDetailsFetched,
                builder: (context, state) {
                  if (state is FetchingTodoDetailsAndDocumentDetails) {
                    return Center(
                        child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 3.5),
                      child: const CircularProgressIndicator(),
                    ));
                  } else if (state is TodoDetailsAndDocumentDetailsFetched) {
                    todoMap['clientId'] = state.clientId;
                    return CustomTabBarView(
                        lengthOfTabs: 2,
                        tabBarViewIcons: ToDoUtil().tabBarViewIcons,
                        initialIndex: context.read<ToDoBloc>().initialIndex,
                        tabBarViewWidgets: [
                          ToDoDetailsTab(
                              initialIndex: 0,
                              todoDetails: state.fetchToDoDetailsModel.data,
                              todoMap: todoMap),
                          ToDoDocumentDetailsTab(
                              initialIndex: 1,
                              documentDetailsDatum: state
                                  .fetchToDoDocumentDetailsModel
                                  .documentDetailsDatum,
                              todoMap: todoMap)
                        ]);
                  } else {
                    return const SizedBox();
                  }
                })
          ])),
    );
  }
}
