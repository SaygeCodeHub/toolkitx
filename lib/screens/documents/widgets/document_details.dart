import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

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
          // const SizedBox(height: tinySpacing),
          // Text(DatabaseUtil.getText('dms_documentid'),
          //     style: Theme.of(context).textTheme.medium.copyWith(
          //         color: AppColor.black, fontWeight: FontWeight.bold)),
          // const SizedBox(height: xxTinierSpacing),
          // Text(documentDetailsModel.data.id,
          //     style: Theme.of(context).textTheme.small),
          // const SizedBox(height: tinySpacing),
          // Text(DatabaseUtil.getText('Status'),
          //     style: Theme.of(context).textTheme.medium.copyWith(
          //         color: AppColor.black, fontWeight: FontWeight.bold)),
          // const SizedBox(height: xxTinierSpacing),
          // Text(documentDetailsModel.data.status,
          //     style: Theme.of(context).textTheme.small),
          // const SizedBox(height: tinySpacing),
          // Text(DatabaseUtil.getText('Author'),
          //     style: Theme.of(context).textTheme.medium.copyWith(
          //         color: AppColor.black, fontWeight: FontWeight.bold)),
          // const SizedBox(height: xxTinierSpacing),
          // Text(documentDetailsModel.data.author,
          //     style: Theme.of(context).textTheme.small),
          // const SizedBox(height: tinySpacing),
          // Text(DatabaseUtil.getText('DistributionList'),
          //     style: Theme.of(context).textTheme.medium.copyWith(
          //         color: AppColor.black, fontWeight: FontWeight.bold)),
          // const SizedBox(height: xxTinierSpacing),
          // Text(documentDetailsModel.data.dis,
          //     style: Theme.of(context).textTheme.small),
          // const SizedBox(height: tinySpacing),
          // Text(DatabaseUtil.getText('Location'),
          //     style: Theme.of(context).textTheme.medium.copyWith(
          //         color: AppColor.black, fontWeight: FontWeight.bold)),
          // const SizedBox(height: xxTinierSpacing),
          // Text(documentDetailsModel.data.status,
          //     style: Theme.of(context).textTheme.small),
          // const SizedBox(height: xxTinierSpacing),
          // ListView.separated(
          //     itemCount: permitDetailsModel.data.tab1.maplinks.length,
          //     shrinkWrap: true,
          //     separatorBuilder: (context, index) {
          //       return const SizedBox(height: xxTinierSpacing);
          //     },
          //     itemBuilder: (context, index) {
          //       return InkWell(
          //           onTap: () {
          //             launchUrlString(
          //                 permitDetailsModel.data.tab1.maplinks[index].link,
          //                 mode: LaunchMode.inAppWebView);
          //           },
          //           child: RichText(
          //               overflow: TextOverflow.ellipsis,
          //               textAlign: TextAlign.end,
          //               textDirection: TextDirection.rtl,
          //               softWrap: true,
          //               maxLines: 2,
          //               textScaleFactor: 1,
          //               text: TextSpan(
          //                   text:
          //                   "${permitDetailsModel.data.tab1.maplinks[index].name} : ",
          //                   style: DefaultTextStyle.of(context).style,
          //                   children: <TextSpan>[
          //                     TextSpan(
          //                         text: permitDetailsModel
          //                             .data.tab1.maplinks[index].link,
          //                         style: Theme.of(context)
          //                             .textTheme
          //                             .xSmall
          //                             .copyWith(
          //                           color: AppColor.deepBlue,
          //                         ))
          //                   ])));
          //     }),
          // const SizedBox(height: tinySpacing),
          // Text(DatabaseUtil.getText('Company'),
          //     style: Theme.of(context).textTheme.medium.copyWith(
          //         color: AppColor.black, fontWeight: FontWeight.bold)),
          // const SizedBox(height: xxTinierSpacing),
          // Text(permitDetailsModel.data.tab1.pcompany,
          //     style: Theme.of(context).textTheme.small)
        ]));
  }
}
