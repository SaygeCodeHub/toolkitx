import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/documents/documents_details_models.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_card.dart';
import '../documents_details_screen.dart';

class DocumentDetailsCustomFields extends StatelessWidget {
  final DocumentDetailsModel documentDetailsModel;

  const DocumentDetailsCustomFields(
      {super.key, required this.documentDetailsModel});

  @override
  Widget build(BuildContext context) {
    DocumentsDetailsScreen.defaultIndex = 2;
    return (documentDetailsModel.data.customfields.isEmpty)
        ? Center(
            child: Text(StringConstants.kNoCustomFields,
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w700, color: AppColor.mediumBlack)))
        : ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: documentDetailsModel.data.customfields.length,
            itemBuilder: (context, index) {
              return CustomCard(
                  child: ListTile(
                      contentPadding: const EdgeInsets.only(
                          left: tinierSpacing,
                          right: tinierSpacing,
                          top: tiniestSpacing,
                          bottom: tiniestSpacing),
                      title: Text(
                          '${documentDetailsModel.data.customfields[index].title}?',
                          style: Theme.of(context).textTheme.small.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColor.mediumBlack)),
                      subtitle: Padding(
                          padding: const EdgeInsets.only(top: xxTinierSpacing),
                          child: Text(
                              (documentDetailsModel
                                          .data.customfields[index].fieldvalue
                                          .toString() ==
                                      "null")
                                  ? ''
                                  : documentDetailsModel
                                      .data.customfields[index].fieldvalue,
                              style: Theme.of(context).textTheme.xSmall))));
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: xxTinierSpacing);
            });
  }
}
