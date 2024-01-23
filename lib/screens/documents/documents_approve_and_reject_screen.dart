import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../checklist/workforce/widgets/upload_image_section.dart';

class DocumentsApproveAndRejectScreen extends StatelessWidget {
  const DocumentsApproveAndRejectScreen({super.key});

  static const routeName = 'DocumentsAddCommentsScreen';
  static bool isFromReject = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(
          title: isFromReject == true
              ? DatabaseUtil.getText("dms_rejectdocument")
              : DatabaseUtil.getText("dms_approvedocument")),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(StringConstants.kComments,
                style: Theme.of(context).textTheme.xSmall.copyWith(
                    fontWeight: FontWeight.w500, color: AppColor.black)),
            const SizedBox(height: xxTinierSpacing),
            TextFieldWidget(
              maxLines: 2,
              onTextFieldChanged: (textField) {},
            ),
            const SizedBox(height: xxxTinySpacing),
            UploadImageMenu(
              onUploadImageResponse: (uploadImageList) {},
            ),
            PrimaryButton(
                onPressed: () {},
                textValue: isFromReject == true
                    ? DatabaseUtil.getText('Reject')
                    : DatabaseUtil.getText('approve')),
          ],
        ),
      ),
    );
  }
}
