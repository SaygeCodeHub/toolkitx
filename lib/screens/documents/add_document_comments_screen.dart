import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/documents/documents_events.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../blocs/documents/documents_bloc.dart';
import '../../blocs/documents/documents_states.dart';
import '../../blocs/imagePickerBloc/image_picker_bloc.dart';
import '../../blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import '../../blocs/pickAndUploadImage/pick_and_upload_image_events.dart';
import '../../blocs/pickAndUploadImage/pick_and_upload_image_states.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/generic_text_field.dart';
import '../../widgets/progress_bar.dart';
import '../checklist/workforce/widgets/upload_image_section.dart';

class AddDocumentCommentsScreen extends StatelessWidget {
  static const routeName = 'AddDocumentCommentsScreen';
  static Map saveDocumentCommentsMap = {};

  const AddDocumentCommentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    saveDocumentCommentsMap.clear();
    context.read<PickAndUploadImageBloc>().isInitialUpload = true;
    context.read<PickAndUploadImageBloc>().add(UploadInitial());
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('AddComment')),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: topBottomPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(DatabaseUtil.getText('Comments'),
                style: Theme.of(context)
                    .textTheme
                    .xSmall
                    .copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: tiniestSpacing),
            TextFieldWidget(
              onTextFieldChanged: (textField) {
                saveDocumentCommentsMap['comments'] = textField;
              },
            ),
            const SizedBox(height: xxTinySpacing),
            Text(DatabaseUtil.getText('dms_refno'),
                style: Theme.of(context)
                    .textTheme
                    .xSmall
                    .copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: tiniestSpacing),
            TextFieldWidget(
              onTextFieldChanged: (textField) {
                saveDocumentCommentsMap['refno'] = textField;
              },
            ),
            const SizedBox(height: xxTinySpacing),
            BlocBuilder<PickAndUploadImageBloc, PickAndUploadImageStates>(
                buildWhen: (previousState, currentState) =>
                    currentState is ImagePickerLoaded,
                builder: (context, state) {
                  if (state is ImagePickerLoaded) {
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(StringConstants.kUploadPhoto,
                              style: Theme.of(context).textTheme.small.copyWith(
                                  color: AppColor.black,
                                  fontWeight: FontWeight.w500)),
                          Text(
                              '${(context.read<PickAndUploadImageBloc>().isInitialUpload == true) ? 0 : state.incrementNumber}/6',
                              style: Theme.of(context).textTheme.small.copyWith(
                                  color: AppColor.black,
                                  fontWeight: FontWeight.w500)),
                        ]);
                  } else {
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(StringConstants.kUploadPhoto,
                              style: Theme.of(context).textTheme.small.copyWith(
                                  color: AppColor.black,
                                  fontWeight: FontWeight.w500)),
                          Text('0/6',
                              style: Theme.of(context).textTheme.small.copyWith(
                                  color: AppColor.black,
                                  fontWeight: FontWeight.w500)),
                        ]);
                  }
                }),
            const SizedBox(height: tinySpacing),
            UploadImageMenu(
              imagePickerBloc: ImagePickerBloc(),
              isUpload: true,
              onUploadImageResponse: (List uploadLotoPhotosList) {
                saveDocumentCommentsMap['files'] = uploadLotoPhotosList
                    .toString()
                    .replaceAll("[", "")
                    .replaceAll("]", "");
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxTinierSpacing),
        child: BlocListener<DocumentsBloc, DocumentsStates>(
          listener: (context, state) {
            if (state is SavingDocumentComments) {
              ProgressBar.show(context);
            }
            if (state is DocumentCommentsSaved) {
              ProgressBar.dismiss(context);
              Navigator.pop(context);
            }
            if (state is SaveDocumentCommentsError) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.errorMessage, '');
            }
          },
          child: PrimaryButton(
              onPressed: () {
                context.read<DocumentsBloc>().add(SaveDocumentComments(
                    saveDocumentsCommentsMap: saveDocumentCommentsMap));
              },
              textValue: StringConstants.kSave),
        ),
      ),
    );
  }
}
