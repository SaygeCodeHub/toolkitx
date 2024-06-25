import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/todo/fetch_todo_document_details_model.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/generic_alphanumeric_generator_util.dart';
import '../../../utils/todo_view_document_util.dart';

class ToDoViewDocument extends StatelessWidget {
  final ToDoDocumentDetailsDatum documentDetailsDatum;
  final Map todoMap;

  const ToDoViewDocument(
      {super.key, required this.documentDetailsDatum, required this.todoMap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount:
            ToDoViewDocumentUtil.viewImageList(documentDetailsDatum.files)
                .length,
        itemBuilder: (context, index) {
          return InkWell(
              splashColor: AppColor.transparent,
              highlightColor: AppColor.transparent,
              onTap: () {
                launchUrlString(
                    '${ApiConstants.viewDocBaseUrl}${ToDoViewDocumentUtil.viewImageList(documentDetailsDatum.files)[index]}&code=${RandomValueGeneratorUtil.generateRandomValue(todoMap['clientId'])}',
                    mode: LaunchMode.inAppBrowserView);
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: xxxTinierSpacing),
                child: Text(
                    ToDoViewDocumentUtil.viewImageList(
                        documentDetailsDatum.files)[index],
                    style: const TextStyle(color: AppColor.deepBlue)),
              ));
        });
  }
}
