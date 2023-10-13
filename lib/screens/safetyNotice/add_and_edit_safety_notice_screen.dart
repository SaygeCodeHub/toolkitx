import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import '../../blocs/pickAndUploadImage/pick_and_upload_image_events.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/generic_text_field.dart';
import '../checklist/workforce/widgets/upload_image_section.dart';
import 'widgets/safety_notice_add_edit_bottom_app_bar.dart';
import 'widgets/safety_notice_image_count.dart';

class AddAndEditSafetyNoticeScreen extends StatelessWidget {
  static const routeName = 'AddAndEditSafetyNoticeScreen';
  final Map manageSafetyNoticeMap = {};

  AddAndEditSafetyNoticeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<PickAndUploadImageBloc>().isInitialUpload = true;
    context.read<PickAndUploadImageBloc>().add(UploadInitial());
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('NewSafetyNotice')),
      bottomNavigationBar: SafetyNoticeAddAndEditBottomAppBar(
          manageSafetyNoticeMap: manageSafetyNoticeMap),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin, right: leftRightMargin, top: xxTinySpacing),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DatabaseUtil.getText('Notice'),
                  style: Theme.of(context)
                      .textTheme
                      .xSmall
                      .copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: xxxTinierSpacing),
              TextFieldWidget(
                  maxLength: 250,
                  maxLines: 3,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                  onTextFieldChanged: (String textField) {
                    manageSafetyNoticeMap['notice'] = textField;
                  }),
              const SizedBox(height: xxTinySpacing),
              Text(DatabaseUtil.getText('Validitydays'),
                  style: Theme.of(context)
                      .textTheme
                      .xSmall
                      .copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: xxxTinierSpacing),
              TextFieldWidget(
                  maxLength: 10,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.number,
                  onTextFieldChanged: (String textField) {
                    manageSafetyNoticeMap['validity'] = textField;
                  }),
              const SizedBox(height: xxTinySpacing),
              const SafetyNoticeImageCount(),
              const SizedBox(height: xxTinierSpacing),
              UploadImageMenu(
                isUpload: true,
                onUploadImageResponse: (List uploadImageList) {
                  manageSafetyNoticeMap['file_name'] = uploadImageList
                      .toString()
                      .replaceAll('[', '')
                      .replaceAll(']', '');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
