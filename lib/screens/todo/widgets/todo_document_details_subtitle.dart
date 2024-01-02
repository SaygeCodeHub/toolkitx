import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/todo/widgets/todo_view_document.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/todo/fetch_todo_document_details_model.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/generic_alphanumeric_generator_util.dart';
import '../../../utils/todo_view_document_util.dart';

class ToDoDocumentDetailsSubtitle extends StatelessWidget {
  final ToDoDocumentDetailsDatum documentDetailsDatum;
  final Map todoMap;

  const ToDoDocumentDetailsSubtitle(
      {Key? key, required this.documentDetailsDatum, required this.todoMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(documentDetailsDatum.doctypename),
          const SizedBox(height: tinierSpacing),
          (documentDetailsDatum.files == null)
              ? const SizedBox.shrink()
              : (documentDetailsDatum.files.toString().contains('.pdf') ||
                      documentDetailsDatum.files.toString().contains('.docx'))
                  ? InkWell(
                      onTap: () {
                        launchUrlString(
                            '${ApiConstants.viewDocBaseUrl}${ToDoViewDocumentUtil.viewImageList(documentDetailsDatum.files)[0]}&code=${RandomValueGeneratorUtil.generateRandomValue(todoMap['clientId'])}',
                            mode: LaunchMode.externalApplication);
                      },
                      child: Text(
                        documentDetailsDatum.files,
                        style: Theme.of(context)
                            .textTheme
                            .xxSmall
                            .copyWith(color: AppColor.deepBlue),
                      ),
                    )
                  : ToDoViewDocument(
                      documentDetailsDatum: documentDetailsDatum,
                      todoMap: todoMap),
          const SizedBox(height: tinierSpacing),
        ]);
  }
}
