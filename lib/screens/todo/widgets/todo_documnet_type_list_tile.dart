import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../blocs/todo/todo_bloc.dart';
import '../../../blocs/todo/todo_event.dart';
import '../../../blocs/todo/todo_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/todo/fetch_todo_document_master_model.dart';
import '../../../utils/database_utils.dart';
import 'todo_document_type_list.dart';

class ToDoDocumentTypeListTile extends StatelessWidget {
  final List<List<ToDoDocumentMasterDatum>> data;
  final Map todoMap;
  final Map todoFilterMap;

  const ToDoDocumentTypeListTile(
      {super.key,
      required this.data,
      required this.todoMap,
      required this.todoFilterMap});

  @override
  Widget build(BuildContext context) {
    context.read<ToDoBloc>().add(SelectToDoDocumentType(
        documentTypeId: (todoFilterMap['type'] != null)
            ? int.parse(todoFilterMap['type'])
            : 0,
        documentTypeName:
            (todoFilterMap['type'] != null) ? todoMap['docName'] : ''));
    return BlocBuilder<ToDoBloc, ToDoStates>(
        buildWhen: (previousState, currentState) =>
            currentState is ToDoDocumentTypeSelected,
        builder: (context, state) {
          if (state is ToDoDocumentTypeSelected) {
            todoMap['type'] = state.documentTypeId.toString();
            todoMap['docName'] = state.documentTypeName;
            todoFilterMap['type'] = state.documentTypeId.toString();
            return Column(
              children: [
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ToDoDocumentTypeList(
                                  data: data,
                                  documentTypeId: state.documentTypeId,
                                  todoFilterMap: todoFilterMap)));
                    },
                    title: Text(DatabaseUtil.getText('type'),
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    subtitle: (state.documentTypeName == '')
                        ? null
                        : Padding(
                            padding:
                                const EdgeInsets.only(top: xxxTinierSpacing),
                            child: Text(state.documentTypeName,
                                style: Theme.of(context)
                                    .textTheme
                                    .xSmall
                                    .copyWith(color: AppColor.black)),
                          ),
                    trailing: const Icon(Icons.navigate_next_rounded,
                        size: kIconSize)),
              ],
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
