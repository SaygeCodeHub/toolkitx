import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/todo/todo_bloc.dart';

import '../../../blocs/todo/todo_event.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/todo/fetch_todo_master_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/generic_app_bar.dart';

class ToDoDocumentTypeList extends StatelessWidget {
  final List<List<ToDoMasterDatum>> todoMasterDatum;
  final int documentTypeId;
  final Map todoFilterMap;

  const ToDoDocumentTypeList(
      {Key? key,
      required this.todoMasterDatum,
      required this.documentTypeId,
      required this.todoFilterMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kSelectLocation),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.only(
                  left: leftRightMargin, right: leftRightMargin),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: todoMasterDatum[0].length,
                        itemBuilder: (context, index) {
                          return RadioListTile(
                              contentPadding: EdgeInsets.zero,
                              activeColor: AppColor.deepBlue,
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Text(todoMasterDatum[0][index].name),
                              value: todoMasterDatum[0][index].id,
                              groupValue: documentTypeId,
                              onChanged: (value) {
                                value = todoMasterDatum[0][index].id;
                                context.read<ToDoBloc>().add(
                                    SelectToDoDocumentType(
                                        documentTypeId: value,
                                        documentTypeName:
                                            todoMasterDatum[0][index].name));
                                Navigator.pop(context);
                              });
                        }),
                    const SizedBox(height: xxxSmallerSpacing)
                  ])),
        ));
  }
}
