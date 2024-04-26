import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/documents/widgets/document_view_image_widget.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/documents/documents_details_models.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/documents_util.dart';
import '../../../widgets/custom_card.dart';
import '../documents_details_screen.dart';
import 'document_files_menu.dart';

class DocumentDetailsFiles extends StatelessWidget {
  final DocumentDetailsModel documentDetailsModel;
  final String clientId;

  const DocumentDetailsFiles(
      {super.key, required this.documentDetailsModel, required this.clientId});

  @override
  Widget build(BuildContext context) {
    DocumentsDetailsScreen.defaultIndex = 1;
    return (documentDetailsModel.data.fileList.isEmpty)
        ? Center(
            child: Text(StringConstants.kNoFiles,
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w700, color: AppColor.mediumBlack)))
        : ListView.separated(
            itemCount: documentDetailsModel.data.fileList.length,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              Map documentMap = {
                'name': documentDetailsModel.data.fileList[index].filename,
                'version': documentDetailsModel.data.fileList[index].version,
                'fileid': documentDetailsModel.data.fileList[index].fileid,
              };
              DocumentsFilesMenu.documentFileMap = documentMap;
              return CustomCard(
                  child: Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: xxTinierSpacing),
                      child: ListTile(
                          title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DocumentViewImageWidget(
                                    fileName: documentDetailsModel
                                        .data.fileList[index].filename,
                                    clientId: clientId),
                                const SizedBox(height: xxTinierSpacing),
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset('assets/icons/calendar.png',
                                          height: kImageHeight,
                                          width: kImageWidth),
                                      const SizedBox(width: tiniestSpacing),
                                      Text(
                                          documentDetailsModel
                                              .data.fileList[index].date,
                                          style: Theme.of(context)
                                              .textTheme
                                              .xSmall)
                                    ])
                              ]),
                          trailing: Visibility(
                            visible: documentDetailsModel
                                        .data.fileList[index].candelete ==
                                    '1' ||
                                documentDetailsModel.data.fileList[index]
                                        .canuploadnewversion ==
                                    '1',
                            child: DocumentsFilesMenu(
                              popUpMenuItems: DocumentsUtil.fileMenuOptions(
                                  documentDetailsModel.data.fileList[index]),
                              fileData:
                                  documentDetailsModel.data.fileList[index],
                              documentDetailsModel: documentDetailsModel,
                            ),
                          ))));
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: tinierSpacing);
            });
  }
}
