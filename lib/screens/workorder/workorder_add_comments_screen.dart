import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../blocs/imagePickerBloc/image_picker_bloc.dart';
import '../../blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import '../../blocs/pickAndUploadImage/pick_and_upload_image_events.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/generic_text_field.dart';
import '../checklist/workforce/widgets/upload_image_section.dart';
import 'widgets/workorder_save_comments_bottom_bar.dart';

class WorkOrderAddCommentsScreen extends StatelessWidget {
  static const routeName = 'WorkOrderAddCommentsScreen';
  static Map addCommentsMap = {};

  const WorkOrderAddCommentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PickAndUploadImageBloc>().isInitialUpload = true;
    context.read<PickAndUploadImageBloc>().add(UploadInitial());
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('AddComments')),
      bottomNavigationBar:
          WorkOrderSaveCommentsBottomBar(addCommentsMap: addCommentsMap),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DatabaseUtil.getText('Comments'),
                        style: Theme.of(context).textTheme.small.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: xxTinierSpacing),
                    TextFieldWidget(
                        textInputAction: TextInputAction.done,
                        maxLines: 2,
                        maxLength: 250,
                        onTextFieldChanged: (String textValue) {
                          addCommentsMap['comments'] = textValue;
                        }),
                    const SizedBox(height: xxTinierSpacing),
                    UploadImageMenu(
                      imagePickerBloc: ImagePickerBloc(),
                      isUpload: true,
                      onUploadImageResponse: (List uploadImageList) {
                        addCommentsMap['pickedImage'] = uploadImageList;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
