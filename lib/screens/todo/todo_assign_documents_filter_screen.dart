import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/todo/widgets/todo_documnet_type_list_tile.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import '../../blocs/todo/todo_bloc.dart';
import '../../blocs/todo/todo_event.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/todo/fetch_todo_document_master_model.dart';
import '../../utils/database_utils.dart';
import '../../widgets/generic_text_field.dart';
import 'widgets/todo_assign_documents_filter_status.dart';

class ToDoAssignDocumentsFilterScreen extends StatelessWidget {
  final List<List<ToDoDocumentMasterDatum>> data;
  final Map todoMap;
  final Map addFiltersDataMap;

  const ToDoAssignDocumentsFilterScreen(
      {super.key,
      required this.data,
      required this.todoMap,
      required this.addFiltersDataMap});
  static Map todoFilterMap = {};

  @override
  Widget build(BuildContext context) {
    todoFilterMap = addFiltersDataMap;
    return Scaffold(
      appBar: const GenericAppBar(title: StringConstants.kApplyFilter),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
              child: PrimaryButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  textValue: DatabaseUtil.getText('Close')),
            ),
            const SizedBox(width: xxTinySpacing),
            Expanded(
                child: PrimaryButton(
                    onPressed: () {
                      context
                          .read<ToDoBloc>()
                          .add(ApplyToDoFilter(todoFilterMap: todoFilterMap));
                      Navigator.pop(context);
                      context.read<ToDoBloc>().add(FetchDocumentForToDo(
                          todoMap: todoMap, isFromPopUpMenu: false));
                    },
                    textValue: DatabaseUtil.getText('buttonSave'))),
          ],
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxTinierSpacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DatabaseUtil.getText('DocumentName'),
                  style: Theme.of(context)
                      .textTheme
                      .xSmall
                      .copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: xxxTinierSpacing),
              TextFieldWidget(
                  value: todoFilterMap['name'] ?? '',
                  maxLength: 70,
                  onTextFieldChanged: (String textValue) {
                    todoFilterMap['name'] = textValue;
                  }),
              ToDoDocumentTypeListTile(
                  data: data, todoMap: todoMap, todoFilterMap: todoFilterMap),
              const SizedBox(height: xxTinySpacing),
              Text(DatabaseUtil.getText('Status'),
                  style: Theme.of(context)
                      .textTheme
                      .xSmall
                      .copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: xxxTinierSpacing),
              ToDoStatusFilter(todoFilterMap: todoFilterMap),
              const SizedBox(height: xxTinySpacing),
              Text(DatabaseUtil.getText('owner'),
                  style: Theme.of(context)
                      .textTheme
                      .xSmall
                      .copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: xxxTinierSpacing),
              TextFieldWidget(
                  value: todoFilterMap['author'] ?? '',
                  maxLength: 70,
                  onTextFieldChanged: (String textValue) {
                    todoFilterMap['author'] = textValue;
                  }),
            ],
          )),
    );
  }
}
