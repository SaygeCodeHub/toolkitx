import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/documents/documents_details_models.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/custom_grid_images.dart';
import '../documents_details_screen.dart';

class DocumentDetailsComments extends StatelessWidget {
  final DocumentDetailsModel documentDetailsModel;
  final String clientId;

  const DocumentDetailsComments(
      {Key? key, required this.documentDetailsModel, required this.clientId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DocumentsDetailsScreen.defaultIndex = 4;
    return (documentDetailsModel.data.comments.isEmpty)
        ? Center(
            child: Text(StringConstants.kNoComment,
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w700, color: AppColor.mediumBlack)))
        : ListView.separated(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: documentDetailsModel.data.comments.length,
            itemBuilder: (context, index) {
              return CustomCard(
              child: Padding(
                  padding: const EdgeInsets.only(top: xxTinierSpacing),
                  child: ListTile(
                      title: Text(
                          documentDetailsModel
                              .data.comments[index].ownername,
                          style: Theme.of(context).textTheme.small.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColor.mediumBlack)),
                      subtitle: Padding(
                          padding:
                          const EdgeInsets.only(top: xxTinierSpacing),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(documentDetailsModel
                                    .data.comments[index].comments),
                                const SizedBox(height: xxTinierSpacing),
                                Text(
                                    documentDetailsModel
                                        .data.comments[index].created,
                                    style: Theme.of(context)
                                        .textTheme
                                        .xxSmall
                                        .copyWith(
                                        color: AppColor.deepBlue)),
                                const SizedBox(height: xxTiniestSpacing),
                                CustomGridImages(
                                    files: documentDetailsModel
                                        .data.comments[index].files,
                                    clientId: clientId)
                              ])))));
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: xxTinierSpacing);
        });
  }
}
