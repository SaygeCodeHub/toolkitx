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
import '../../blocs/imagePickerBloc/image_picker_bloc.dart';
import '../../blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import '../../blocs/pickAndUploadImage/pick_and_upload_image_events.dart';
import '../../blocs/todo/todo_bloc.dart';
import '../../blocs/todo/todo_event.dart';
import '../../blocs/todo/todo_states.dart';
import '../../blocs/uploadImage/upload_image_bloc.dart';
import '../../blocs/uploadImage/upload_image_event.dart';
import '../../blocs/uploadImage/upload_image_state.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/todo/fetch_todo_document_master_model.dart';
import '../../widgets/generic_loading_popup.dart';
import '../../widgets/progress_bar.dart';
import 'widgets/todo_documnet_type_list_tile.dart';

class ToDoUploadDocumentScreen extends StatelessWidget {
  final List<List<ToDoDocumentMasterDatum>> data;
  final Map todoMap;
  final Map? todoFilterMap;

  const ToDoUploadDocumentScreen(
      {Key? key, required this.todoMap, required this.data, this.todoFilterMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    todoMap['name'] = '';
    todoMap['files'] = '';
    context.read<PickAndUploadImageBloc>().add(UploadInitial());
    return Scaffold(
        appBar: GenericAppBar(
          title: DatabaseUtil.getText('AddAction'),
        ),
        bottomNavigationBar: MultiBlocListener(
          listeners: [
            BlocListener<ToDoBloc, ToDoStates>(
              listener: (context, state) {
                if (state is UploadingToDoDocument) {
                  ProgressBar.show(context);
                } else if (state is ToDoDocumentUploaded) {
                  ProgressBar.dismiss(context);
                  Navigator.pop(context);
                  context.read<ToDoBloc>().add(
                      FetchToDoDetailsAndDocumentDetails(
                          todoId: todoMap['todoId'], selectedIndex: 0));
                } else if (state is ToDoDocumentNotUploaded) {
                  ProgressBar.dismiss(context);
                  showCustomSnackBar(context, state.documentNotUploaded, '');
                }
              },
            ),
            BlocListener<UploadImageBloc, UploadImageState>(
              listener: (context, state) {
                if (state is UploadingImage) {
                  GenericLoadingPopUp.show(
                      context, StringConstants.kUploadFiles);
                } else if (state is ImageUploaded) {
                  GenericLoadingPopUp.dismiss(context);
                  todoMap['files'] = state.images
                      .toString()
                      .replaceAll('[', '')
                      .replaceAll(']', '')
                      .replaceAll(' ', '');
                  context
                      .read<ToDoBloc>()
                      .add(ToDoUploadDocument(todoMap: todoMap));
                } else if (state is ImageCouldNotUpload) {
                  GenericLoadingPopUp.dismiss(context);
                  showCustomSnackBar(context, state.errorMessage, '');
                }
              },
            ),
          ],
          child: BottomAppBar(
            child: PrimaryButton(
                onPressed: () {
                  if (todoMap['pickedImage'] != null &&
                      todoMap['pickedImage'].isNotEmpty) {
                    context.read<UploadImageBloc>().add(UploadImage(
                        images: todoMap['pickedImage'],
                        imageLength:
                            context.read<ImagePickerBloc>().lengthOfImageList));
                  } else {
                    context
                        .read<ToDoBloc>()
                        .add(ToDoUploadDocument(todoMap: todoMap));
                  }
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
                          data: data,
                          todoMap: todoMap,
                          todoFilterMap: todoFilterMap ?? {}),
                      const SizedBox(height: xxTinySpacing),
                      UploadImageMenu(
                          imagePickerBloc: ImagePickerBloc(),
                          onUploadImageResponse: (List uploadImageList) {
                            todoMap['pickedImage'] = uploadImageList;
                          })
                    ]))));
  }
}
