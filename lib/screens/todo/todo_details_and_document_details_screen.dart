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
import '../../widgets/custom_tabbar_view.dart';
import 'widgets/todo_details_tab.dart';
import 'widgets/todo_document_details_tab.dart';

class ToDoDetailsAndDocumentDetailsScreen extends StatelessWidget {
  static const routeName = 'ToDoDetailsAndDocumentDetailsScreen';
  final Map todoMap;

  const ToDoDetailsAndDocumentDetailsScreen({Key? key, required this.todoMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<TodoBloc>().add(FetchToDoDetailsAndDocumentDetails(
        selectedIndex: 0, todoId: todoMap['todoId']));
    return Scaffold(
      appBar: const GenericAppBar(),
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
            BlocBuilder<TodoBloc, ToDoStates>(
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
                        initialIndex: context.read<TodoBloc>().initialIndex,
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
