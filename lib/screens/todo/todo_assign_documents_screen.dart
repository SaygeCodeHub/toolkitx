import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/custom_icon_button_row.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import '../../blocs/todo/todo_bloc.dart';
import '../../blocs/todo/todo_event.dart';
import '../../blocs/todo/todo_states.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/todo/fetch_todo_master_model.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/generic_no_records_text.dart';
import '../../widgets/primary_button.dart';
import 'todo_assign_documents_filter_screen.dart';

class ToDoAssignDocumentsScreen extends StatelessWidget {
  final Map todoMap;
  final List<List<ToDoMasterDatum>> todoMasterDatum;
  final bool isFromPopUpMenu;
  static Map addFiltersDataMap = {};

  const ToDoAssignDocumentsScreen(
      {Key? key,
      required this.todoMap,
      required this.todoMasterDatum,
      this.isFromPopUpMenu = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    todoMap['documents'] = '';
    context.read<ToDoBloc>().add(FetchDocumentForToDo(
        todoMap: todoMap, isFromPopUpMenu: isFromPopUpMenu));
    addFiltersDataMap.clear();
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('AssignDocuments')),
        bottomNavigationBar: BottomAppBar(
            child: BlocListener<ToDoBloc, ToDoStates>(
          listener: (context, state) {
            if (state is SavingToDoDocuments) {
              ProgressBar.show(context);
            } else if (state is ToDoDocumentsSaved) {
              ProgressBar.dismiss(context);
              Navigator.pop(context);
              context.read<ToDoBloc>().add(FetchToDoDetailsAndDocumentDetails(
                  todoId: todoMap['todoId'], selectedIndex: 0));
            } else if (state is ToDoDocumentsNotSaved) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.documentsNotSaved, '');
            }
          },
          child: PrimaryButton(
              onPressed: () {
                context
                    .read<ToDoBloc>()
                    .add(SaveToDoDocuments(todoMap: todoMap));
              },
              textValue: DatabaseUtil.getText('buttonDone')),
        )),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.only(
                  left: leftRightMargin, right: leftRightMargin),
              child: Column(
                children: [
                  BlocBuilder<ToDoBloc, ToDoStates>(
                      buildWhen: (previousState, currentState) =>
                          currentState is DocumentForToDoFetched,
                      builder: (context, state) {
                        if (state is DocumentForToDoFetched) {
                          return CustomIconButtonRow(
                              secondaryVisible: false,
                              clearVisible: state.filterMap.isNotEmpty,
                              primaryOnPress: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        ToDoAssignDocumentsFilterScreen(
                                            todoMasterDatum: todoMasterDatum,
                                            todoMap: todoMap,
                                            addFiltersDataMap:
                                                addFiltersDataMap)));
                              },
                              secondaryOnPress: () {},
                              clearOnPress: () {
                                context.read<ToDoBloc>().add(ClearToDoFilter());
                                addFiltersDataMap.clear();
                                context.read<ToDoBloc>().add(
                                    FetchDocumentForToDo(
                                        todoMap: todoMap,
                                        isFromPopUpMenu: isFromPopUpMenu));
                              });
                        } else {
                          return const SizedBox();
                        }
                      }),
                  BlocBuilder<ToDoBloc, ToDoStates>(
                      buildWhen: (previousState, currentState) =>
                      currentState is FetchingDocumentForToDo ||
                          currentState is DocumentForToDoFetched,
                      builder: (context, state) {
                        if (state is FetchingDocumentForToDo) {
                          return Center(
                              child: Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 3.5),
                            child: const CircularProgressIndicator(),
                          ));
                        } else if (state is DocumentForToDoFetched) {
                          addFiltersDataMap.addAll(state.filterMap);
                          todoMap['documents'] = state.selectDocumentList
                              .toString()
                              .replaceAll("[", "")
                              .replaceAll("]", "");
                          if (state.fetchDocumentForToDoModel
                              .fetchDocumentDatum!.isNotEmpty) {
                            return ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.fetchDocumentForToDoModel
                                    .fetchDocumentDatum!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return CheckboxListTile(
                                      checkColor: AppColor.white,
                                      activeColor: AppColor.deepBlue,
                                      contentPadding: EdgeInsets.zero,
                                      value: state.selectDocumentList.contains(
                                          state
                                              .fetchDocumentForToDoModel
                                              .fetchDocumentDatum![index]
                                              .docid),
                                      title: Text(
                                          state
                                              .fetchDocumentForToDoModel
                                              .fetchDocumentDatum![index]
                                              .docname,
                                          style: Theme.of(context)
                                              .textTheme
                                              .xSmall
                                              .copyWith(
                                                  fontWeight: FontWeight.w600)),
                                      subtitle: Text(state
                                          .fetchDocumentForToDoModel
                                          .fetchDocumentDatum![index]
                                          .doctypename),
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                      onChanged: (isChecked) {
                                        context.read<ToDoBloc>().add(
                                            SelectDocumentForToDo(
                                                documentList:
                                                    state.selectDocumentList,
                                                selectedDocument: state
                                                    .fetchDocumentForToDoModel
                                                    .fetchDocumentDatum![index]
                                                    .docid,
                                                filtersMap: {}));
                                      });
                                });
                          } else {
                            if (state.fetchDocumentForToDoModel.status == 204) {
                              if (state.filterMap.isEmpty) {
                                return const NoRecordsText(
                                    text: StringConstants.kNoRecordsFilter);
                              } else {
                                return NoRecordsText(
                                    text: DatabaseUtil.getText(
                                        'no_records_found'));
                              }
                            } else {
                              return const SizedBox();
                            }
                          }
                        } else {
                          return const SizedBox();
                        }
                      }),
                ],
              )),
        ));
  }
}
