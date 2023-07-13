import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../blocs/todo/todo_bloc.dart';
import '../../../blocs/todo/todo_event.dart';
import '../../../blocs/todo/todo_states.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/android_pop_up.dart';
import '../todo_assign_documents_screen.dart';
import '../todo_upload_document_screen.dart';

class ToDoPopUpMenu extends StatelessWidget {
  final Map todoMap;

  const ToDoPopUpMenu({Key? key, required this.todoMap}) : super(key: key);

  PopupMenuItem _buildPopupMenuItem(context, String title, String position) {
    return PopupMenuItem(
        value: position,
        child: Text(title, style: Theme.of(context).textTheme.xSmall));
  }

  @override
  Widget build(BuildContext context) {
    context.read<ToDoBloc>().add(FetchToDoMaster());
    return BlocBuilder<ToDoBloc, ToDoStates>(
        buildWhen: (previousState, currentState) =>
            currentState is ToDoMasterFetched,
        builder: (context, state) {
          if (state is ToDoMasterFetched) {
            return PopupMenuButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kCardRadius)),
                iconSize: kIconSize,
                icon: const Icon(Icons.more_vert_outlined),
                offset: const Offset(0, xxTinierSpacing),
                onSelected: (value) {
                  if (value == DatabaseUtil.getText('MarkasDone')) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AndroidPopUp(
                              contentPadding: EdgeInsets.zero,
                              titleValue: DatabaseUtil.getText('DeleteRecord'),
                              onPressed: () {
                                context
                                    .read<ToDoBloc>()
                                    .add(ToDoMarkAsDone(todoMap: todoMap));
                                Navigator.pop(context);
                              },
                              contentValue: '');
                        });
                  }
                  if (value == DatabaseUtil.getText('AssignDocuments')) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ToDoAssignDocumentsScreen(
                              todoMap: todoMap,
                              todoMasterDatum:
                                  state.fetchToDoMasterModel.todoMasterDatum,
                              isFromPopUpMenu: true,
                            )));
                  }
                  if (value == DatabaseUtil.getText('dms_uploaddocuments')) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ToDoUploadDocumentScreen(
                            todoMap: todoMap,
                            todoMasterDatum:
                                state.fetchToDoMasterModel.todoMasterDatum)));
                  }
                },
                position: PopupMenuPosition.under,
                itemBuilder: (BuildContext context) => [
                      for (int i = 0; i < state.todoPopUpMenuList.length; i++)
                        _buildPopupMenuItem(context, state.todoPopUpMenuList[i],
                            state.todoPopUpMenuList[i])
                    ]);
          } else {
            return const SizedBox();
          }
        });
  }
}
