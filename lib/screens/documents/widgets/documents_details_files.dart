import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/custom_card.dart';

import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/documents/documents_details_models.dart';
import '../../../utils/document_files_menu_util.dart';
import 'document_files_menu.dart';

class DocumentDetailsFiles extends StatelessWidget {
  final DocumentDetailsModel documentDetailsModel;

  const DocumentDetailsFiles({super.key, required this.documentDetailsModel});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: documentDetailsModel.data.fileList.length,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return CustomCard(
              child: Padding(
                  padding: const EdgeInsets.only(top: tinierSpacing),
                  child: ListTile(
                      title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset('assets/icons/calendar.png',
                                      height: kImageHeight, width: kImageWidth),
                                  const SizedBox(width: tiniestSpacing),
                                  Text(
                                      documentDetailsModel
                                          .data.fileList[index].date,
                                      style: Theme.of(context)
                                          .textTheme
                                          .xSmall
                                          .copyWith(
                                              fontWeight: FontWeight.w500))
                                ]),
                            const SizedBox(height: xxTinierSpacing),
                            Text(documentDetailsModel
                                .data.fileList[index].filename)
                          ]),
                      trailing: DocumentsFilesMenu(
                          popUpMenuItems: DocumentsFileMenuUtil.fileMenuOptions(
                              documentDetailsModel.data.fileList[index])))));
        });
  }
}
