import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/api_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/utils/generic_alphanumeric_generator_util.dart';
import 'package:toolkit/utils/incident_view_image_util.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../blocs/imagePickerBloc/image_picker_bloc.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/generic_text_field.dart';
import '../checklist/workforce/widgets/upload_image_section.dart';
import 'widgets/safety_notice_add_edit_bottom_app_bar.dart';

class AddAndEditSafetyNoticeScreen extends StatelessWidget {
  static const routeName = 'AddAndEditSafetyNoticeScreen';
  static Map manageSafetyNoticeMap = {};
  static bool isFromEditOption = true;

  const AddAndEditSafetyNoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    (isFromEditOption == false)
        ? manageSafetyNoticeMap.clear()
        : manageSafetyNoticeMap;
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('NewSafetyNotice')),
        bottomNavigationBar: SafetyNoticeAddAndEditBottomAppBar(
            manageSafetyNoticeMap: manageSafetyNoticeMap),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinySpacing),
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
                          value: manageSafetyNoticeMap['notice'] ?? '',
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
                          value: manageSafetyNoticeMap['validity'] ?? '',
                          maxLength: 10,
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.number,
                          onTextFieldChanged: (String textField) {
                            manageSafetyNoticeMap['validity'] = textField;
                          }),
                      const SizedBox(height: xxTinySpacing),
                      Text(DatabaseUtil.getText('viewimage'),
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: xxxTinierSpacing),
                      Visibility(
                        visible: manageSafetyNoticeMap['file_name'] != null,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: ViewImageUtil.viewImageList(
                                    manageSafetyNoticeMap['file_name'] ?? '')
                                .length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  splashColor: AppColor.transparent,
                                  highlightColor: AppColor.transparent,
                                  onTap: () {
                                    launchUrlString(
                                        '${ApiConstants.viewDocBaseUrl}${ViewImageUtil.viewImageList(manageSafetyNoticeMap['file_name'])[index]}&code=${RandomValueGeneratorUtil.generateRandomValue(manageSafetyNoticeMap['clientId'])}',
                                        mode: LaunchMode.externalApplication);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: xxxTinierSpacing),
                                    child: Text(
                                        ViewImageUtil.viewImageList(
                                            manageSafetyNoticeMap[
                                                'file_name'])[index],
                                        style: const TextStyle(
                                            color: AppColor.deepBlue)),
                                  ));
                            }),
                      ),
                      const SizedBox(height: xxTinySpacing),
                      UploadImageMenu(
                          imagePickerBloc: ImagePickerBloc(),
                          isUpload: false,
                          onUploadImageResponse: (List uploadImageList) {
                            manageSafetyNoticeMap['file_name'] =
                                uploadImageList;
                          })
                    ]))));
  }
}
