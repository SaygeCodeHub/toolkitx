import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/generic_text_field.dart';
import '../../widgets/primary_button.dart';
import '../checklist/workforce/widgets/upload_image_section.dart';

class IncidentAddCommentsScreen extends StatelessWidget {
  static const routeName = 'IncidentAddCommentsScreen';

  const IncidentAddCommentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(),
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(StringConstants.kComments,
                style: Theme.of(context).textTheme.small.copyWith(
                    color: AppColor.deepBlue, fontWeight: FontWeight.w500)),
            const SizedBox(height: xxTinierSpacing),
            TextFieldWidget(
                textInputAction: TextInputAction.done,
                maxLines: 6,
                maxLength: 250,
                onTextFieldChanged: (String textValue) {}),
            const SizedBox(height: xxTinierSpacing),
            Text(StringConstants.kFiles,
                style: Theme.of(context).textTheme.small.copyWith(
                    color: AppColor.deepBlue, fontWeight: FontWeight.w500)),
            const SizedBox(height: xxTinierSpacing),
            Text('', style: Theme.of(context).textTheme.xSmall),
            const SizedBox(height: xxTinierSpacing),
            Text(StringConstants.kUploadPhoto,
                style: Theme.of(context).textTheme.small.copyWith(
                    color: AppColor.deepBlue, fontWeight: FontWeight.w500)),
            const SizedBox(height: xxTinierSpacing),
            UploadImageMenu(
              onUploadImageResponse: (List uploadImageList) {},
            ),
            const SizedBox(height: xxTinySpacing),
            PrimaryButton(onPressed: () {}, textValue: StringConstants.kSave),
          ])),
    );
  }
}
