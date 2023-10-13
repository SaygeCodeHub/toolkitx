import 'package:flutter/material.dart';
import '../../../configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/documents/documents_details_models.dart';
import '../../../utils/database_utils.dart';

class DocumentDetails extends StatelessWidget {
  final DocumentDetailsModel documentDetailsModel;

  const DocumentDetails({super.key, required this.documentDetailsModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: tinySpacing),
          Text(DatabaseUtil.getText('dms_documentid'),
              style: Theme.of(context).textTheme.medium.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: xxTinierSpacing),
          Text(documentDetailsModel.data.id,
              style: Theme.of(context).textTheme.small),
          const SizedBox(height: tinySpacing),
          Text(DatabaseUtil.getText('Status'),
              style: Theme.of(context).textTheme.medium.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: xxTinierSpacing),
          Text(documentDetailsModel.data.status,
              style: Theme.of(context).textTheme.small),
          const SizedBox(height: tinySpacing),
          Text(DatabaseUtil.getText('Author'),
              style: Theme.of(context).textTheme.medium.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: xxTinierSpacing),
          Text(documentDetailsModel.data.author,
              style: Theme.of(context).textTheme.small),
          const SizedBox(height: tinySpacing),
          Text(DatabaseUtil.getText('DistributionList'),
              style: Theme.of(context).textTheme.medium.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: xxTinierSpacing),
          Text(documentDetailsModel.data.distributionnames,
              style: Theme.of(context).textTheme.small),
          const SizedBox(height: tinySpacing),
          Text(DatabaseUtil.getText('type'),
              style: Theme.of(context).textTheme.medium.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: xxTinierSpacing),
          Text(documentDetailsModel.data.doctypename,
              style: Theme.of(context).textTheme.small),
          const SizedBox(height: xxTinierSpacing),
          ListView.separated(
              itemCount: documentDetailsModel.data.approvelist.length,
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return const SizedBox(height: xxTinierSpacing);
              },
              itemBuilder: (context, index) {
                return Text(
                    '${documentDetailsModel.data.approvelist[index].group}  ${(documentDetailsModel.data.approvelist[index].remark == "Approved") ? documentDetailsModel.data.approvelist[index].remark : ''}',
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        color: AppColor.black, fontWeight: FontWeight.w500));
              }),
          const SizedBox(height: xxTinierSpacing)
        ]));
  }
}
