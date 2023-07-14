import 'dart:developer';

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
import '../../utils/database_utils.dart';
import '../../utils/todo_util.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/custom_tabbar_view.dart';
import '../../widgets/progress_bar.dart';
import 'widgets/todo_details_tab.dart';
import 'widgets/todo_document_details_tab.dart';
import 'widgets/todo_pop_up_menu.dart';

class ToDoDetailsAndDocumentDetailsScreen extends StatelessWidget {
  static const routeName = 'ToDoDetailsAndDocumentDetailsScreen';
  final Map todoMap;

  const ToDoDetailsAndDocumentDetailsScreen({Key? key, required this.todoMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ToDoBloc>().add(FetchToDoDetailsAndDocumentDetails(
        selectedIndex: 0, todoId: todoMap['todoId']));
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
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(todoMap['todoName'],
                                  style: Theme.of(context).textTheme.medium)
                            ])))),
            const SizedBox(height: xxTinierSpacing),
            const Divider(height: kDividerHeight, thickness: kDividerWidth),
            BlocConsumer<ToDoBloc, ToDoStates>(
                listener: (context, state) {
                  if (state is ToDoMarkingAsDone) {
                    ProgressBar.show(context);
                  } else if (state is ToDoMarkedAsDone) {
                    log("fetched=====>");
                    ProgressBar.dismiss(context);
                    Navigator.pop(context, true);
                    Navigator.pop(context, true);
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
                              todoDetails: state.fetchToDoDetailsModel.data),
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
