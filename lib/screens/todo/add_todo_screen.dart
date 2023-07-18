import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/todo/todo_bloc.dart';
import 'package:toolkit/blocs/todo/todo_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/incident/widgets/date_picker.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/error_section.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import '../../blocs/todo/todo_event.dart';
import '../../configs/app_spacing.dart';
import 'todo_details_and_document_details_screen.dart';
import 'widgets/todo_category_expnasion_tile.dart';
import 'widgets/todo_created_for_list_tile.dart';

class AddToDoScreen extends StatelessWidget {
  static const routeName = 'AddToDoScreen';
  final Map todoMap;

  const AddToDoScreen({Key? key, required this.todoMap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<TodoBloc>().add(ToDoFetchMaster());
    todoMap['createdfor'] = null;
    todoMap['categoryid'] = null;
    todoMap['duedate'] = null;
    todoMap['heading'] = null;
    todoMap['description'] = null;
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('AddToDo')),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
              child: PrimaryButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  textValue: DatabaseUtil.getText('buttonBack')),
            ),
            const SizedBox(width: xxxTinierSpacing),
            BlocListener<TodoBloc, ToDoStates>(
              listener: (context, state) {
                if (state is AddingToDo) {
                  ProgressBar.show(context);
                } else if (state is ToDoAdded) {
                  ProgressBar.dismiss(context);
                  Navigator.pushNamed(
                      context, ToDoDetailsAndDocumentDetailsScreen.routeName,
                      arguments: state.todoMap);
                } else if (state is ToDoNotAdded) {
                  ProgressBar.dismiss(context);
                  showCustomSnackBar(context, state.todoNotAdded, '');
                }
              },
              child: Expanded(
                  child: PrimaryButton(
                      onPressed: () {
                        context.read<TodoBloc>().add(AddToDo(todoMap: todoMap));
                      },
                      textValue: DatabaseUtil.getText('nextButtonText'))),
            )
          ],
        ),
      ),
      body: BlocBuilder<TodoBloc, ToDoStates>(
          buildWhen: (previousState, currentState) =>
              currentState is ToDoFetchingMaster ||
              currentState is ToDoMasterFetched ||
              currentState is ToDoMasterNotFetched,
          builder: (context, state) {
            if (state is ToDoFetchingMaster) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ToDoMasterFetched) {
              return Padding(
                padding: const EdgeInsets.only(
                    left: leftRightMargin,
                    right: leftRightMargin,
                    top: xxTinierSpacing),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ToDoCreatedForListTile(
                        todoMap: todoMap,
                        data: state.fetchToDoMasterModel.data![0]),
                    const SizedBox(height: xxTinySpacing),
                    Text(DatabaseUtil.getText('Category'),
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: xxxTinierSpacing),
                    ToDoCategoryExpansionTile(
                        todoMap: todoMap,
                        data: state.fetchToDoMasterModel.data![1]),
                    const SizedBox(height: xxTinySpacing),
                    Text(DatabaseUtil.getText('Duedate'),
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: xxxTinierSpacing),
                    DatePickerTextField(onDateChanged: (String date) {
                      todoMap['duedate'] = date;
                    }),
                    const SizedBox(height: xxTinySpacing),
                    Text(DatabaseUtil.getText('Heading'),
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: xxxTinierSpacing),
                    TextFieldWidget(
                        maxLength: 70,
                        onTextFieldChanged: (String textValue) {
                          todoMap['heading'] = textValue;
                        }),
                    const SizedBox(height: xxTinySpacing),
                    Text('Description',
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: xxxTinierSpacing),
                    TextFieldWidget(
                        maxLength: 250,
                        onTextFieldChanged: (String textValue) {
                          todoMap['description'] = textValue;
                        }),
                  ],
                ),
              );
            } else if (state is ToDoMasterNotFetched) {
              return GenericReloadButton(
                  onPressed: () {}, textValue: StringConstants.kReload);
            } else {
              return const SizedBox();
            }
          }),
    );
  }
}
