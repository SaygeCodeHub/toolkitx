import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:toolkit/blocs/todo/todo_bloc.dart';
import 'package:toolkit/blocs/todo/todo_states.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_icon_button_row.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import '../../blocs/todo/todo_event.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import 'todo_history_list_screen.dart';
import 'todo_settings_screen.dart';
import 'add_todo_screen.dart';
import 'widgets/todo_assigned_by_me_body.dart';
import 'widgets/todo_assigned_to_me_body.dart';

class TodoAssignedByMeAndToMeListScreen extends StatelessWidget {
  static const routeName = 'TodoAssignedByMeAndToMeListScreen';
  static int indexSelected = 0;
  final Map todoMap = {};

  TodoAssignedByMeAndToMeListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ToDoBloc>().add(FetchTodoAssignedToMeAndByMeListEvent());
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('ToDo')),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, AddToDoScreen.routeName,
                  arguments: todoMap);
            },
            child: const Icon(Icons.add)),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing),
            child: Column(
              children: [
                CustomIconButtonRow(
                    clearVisible: true,
                    textValue: StringConstants.kViewAll,
                    primaryVisible: false,
                    isEnabled: true,
                    primaryOnPress: () {},
                    secondaryOnPress: () {
                      Navigator.pushNamed(context, ToDoSettingsScreen.routeName,
                          arguments: todoMap);
                    },
                    clearOnPress: () {
                      Navigator.of(context)
                          .pushNamed(ToDoHistoryListScreen.routeName);
                    }),
                const SizedBox(height: xxTinySpacing),
                BlocBuilder<ToDoBloc, ToDoStates>(
                    buildWhen: (previousState, currentState) =>
                        currentState is TodoAssignedToMeAndByMeListFetched,
                    builder: (context, state) {
                      if (state is TodoAssignedToMeAndByMeListFetched) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ToggleSwitch(
                              animate: true,
                              minWidth: kToggleSwitchMinWidth,
                              initialLabelIndex: indexSelected,
                              cornerRadius: kToggleSwitchCornerRadius,
                              activeFgColor: AppColor.white,
                              inactiveBgColor: AppColor.grey,
                              inactiveFgColor: AppColor.white,
                              totalSwitches: 2,
                              labels: [
                                DatabaseUtil.getText('assignto'),
                                DatabaseUtil.getText('assignby')
                              ],
                              activeBgColors: const [
                                [AppColor.deepBlue],
                                [AppColor.deepBlue]
                              ],
                              onToggle: (index) {
                                indexSelected = index!;
                                context.read<ToDoBloc>().add(ToDoToggleIndex(
                                    selectedIndex: indexSelected,
                                    fetchToDoAssignToByListModel:
                                        state.fetchToDoAssignToByListModel,
                                    fetchToDoAssignToMeListModel:
                                        state.fetchToDoAssignToMeListModel));
                              },
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox();
                      }
                    }),
                const SizedBox(height: xxTinySpacing),
                BlocBuilder<ToDoBloc, ToDoStates>(
                    buildWhen: (previousState, currentState) =>
                        currentState is FetchingTodoAssignedToMeAndByMeList ||
                        currentState is TodoAssignedToMeAndByMeListFetched,
                    builder: (context, state) {
                      if (state is FetchingTodoAssignedToMeAndByMeList) {
                        return Center(
                          child: Padding(
                              padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height / 3.5),
                              child: const CircularProgressIndicator()),
                        );
                      } else if (state is TodoAssignedToMeAndByMeListFetched) {
                        if (indexSelected == 0) {
                          return TodoAssignedToMeBody(
                              assignToMeListDatum: state
                                  .fetchToDoAssignToMeListModel
                                  .assignToMeListDatum,
                              todoMap: todoMap);
                        } else {
                          return TodoAssignedByMeBody(
                              assignedByMeListDatum: state
                                  .fetchToDoAssignToByListModel
                                  .assignedByMeListDatum,
                              todoMap: todoMap);
                        }
                      } else {
                        return const SizedBox();
                      }
                    }),
              ],
            )));
  }
}
