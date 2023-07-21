import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/checklist/workforce/widgets/upload_image_section.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import 'package:toolkit/widgets/primary_button.dart';
import '../../blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import '../../blocs/pickAndUploadImage/pick_and_upload_image_events.dart';
import '../../blocs/todo/todo_bloc.dart';
import '../../blocs/todo/todo_event.dart';
import '../../blocs/todo/todo_states.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/todo/fetch_todo_master_model.dart';
import '../../widgets/progress_bar.dart';
import 'widgets/todo_documnet_type_list_tile.dart';

class ToDoUploadDocumentScreen extends StatelessWidget {
  final List<List<ToDoMasterDatum>> todoMasterDatum;
  final Map todoMap;

  const ToDoUploadDocumentScreen(
      {Key? key, required this.todoMap, required this.todoMasterDatum})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<PickAndUploadImageBloc>().add(UploadInitial());
    return Scaffold(
        appBar: GenericAppBar(
          title: DatabaseUtil.getText('AddAction'),
        ),
        bottomNavigationBar: BlocListener<ToDoBloc, ToDoStates>(
          listener: (context, state) {
            if (state is UploadingToDoDocument) {
              ProgressBar.show(context);
            } else if (state is ToDoDocumentUploaded) {
              ProgressBar.dismiss(context);
              Navigator.pop(context);
              context.read<ToDoBloc>().add(FetchToDoDetailsAndDocumentDetails(
                  todoId: todoMap['todoId'], selectedIndex: 0));
            } else if (state is ToDoDocumentNotUploaded) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.documentNotUploaded, '');
            }
          },
          child: BottomAppBar(
            child: PrimaryButton(
                onPressed: () {
                  context
                      .read<ToDoBloc>()
                      .add(ToDoUploadDocument(todoMap: todoMap));
                },
                textValue: StringConstants.kSave),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing),
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${DatabaseUtil.getText('DocumentName')} *',
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: xxxTinierSpacing),
                      TextFieldWidget(
                          maxLength: 70,
                          onTextFieldChanged: (String textValue) {
                            todoMap['name'] = textValue;
                          }),
                      ToDoDocumentTypeListTile(
                          todoMasterDatum: todoMasterDatum,
                          todoMap: todoMap,
                          todoFilterMap: const {}),
                      const SizedBox(height: xxTinySpacing),
                      Text(DatabaseUtil.getText('UploadPhotos'),
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: xxxTinierSpacing),
                      UploadImageMenu(
                          onUploadImageResponse: (List uploadImageList) {
                        todoMap['files'] = uploadImageList
                            .toString()
                            .replaceAll("[", "")
                            .replaceAll("]", "");
                      })
                    ]))));
  }
}
