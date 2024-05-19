import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/loto/loto_details_model.dart';
import '../../../utils/database_utils.dart';
import 'loto_details_asset_documents.dart';
import 'loto_details_comments_list.dart';
import 'loto_details_location_documents.dart';

class LotoDetails extends StatelessWidget {
  const LotoDetails(
      {super.key,
      required this.fetchLotoDetailsModel,
      required this.lotoTabIndex,
      required this.clientId});

  final FetchLotoDetailsModel fetchLotoDetailsModel;
  final int lotoTabIndex;
  final String clientId;

  @override
  Widget build(BuildContext context) {
    var data = fetchLotoDetailsModel.data;
    return Padding(
      padding: const EdgeInsets.only(
        left: leftRightMargin,
        right: leftRightMargin,
        top: xxTinierSpacing,
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(DatabaseUtil.getText('Date'),
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(data.lotodate),
          const SizedBox(height: xxxSmallestSpacing),
          Text(DatabaseUtil.getText('Status'),
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(data.statustext),
          const SizedBox(height: xxxSmallestSpacing),
          Text(DatabaseUtil.getText('Location'),
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(data.locname,
              style: Theme.of(context)
                  .textTheme
                  .xSmall
                  .copyWith(color: AppColor.grey, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.maplinks.length,
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return const SizedBox(height: xxTinierSpacing);
              },
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      launchUrlString(data.maplinks[index].link,
                          mode: LaunchMode.inAppWebView);
                    },
                    child: RichText(
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        textDirection: TextDirection.rtl,
                        softWrap: true,
                        maxLines: 2,
                        text: TextSpan(
                            text: "${data.maplinks[index].name} : ",
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                  text: data.maplinks[index].link,
                                  style: Theme.of(context)
                                      .textTheme
                                      .xSmall
                                      .copyWith(
                                        color: AppColor.deepBlue,
                                      ))
                            ]),
                        textScaler: const TextScaler.linear(1)));
              }),
          const SizedBox(height: xxxSmallestSpacing),
          Text(DatabaseUtil.getText("confirm_location_with_QR"),
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          data.confirmqrcode == '0'
              ? const Text(StringConstants.kNo)
              : const Text(StringConstants.kYes),
          const SizedBox(height: xxxSmallestSpacing),
          Text(DatabaseUtil.getText('Assets'),
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kConfirmAssetWithQR,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          data.confirmassetqrcode == '0'
              ? const Text(StringConstants.kNo)
              : const Text(StringConstants.kYes),
          const SizedBox(height: xxxSmallestSpacing),
          Text(DatabaseUtil.getText("DistributionList"),
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(data.distributionlist),
          const SizedBox(height: xxxSmallestSpacing),
          Text(DatabaseUtil.getText("Purpose"),
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(data.purposenames),
          LotoDetailsLocationDocuments(data: data, clientId: clientId),
          const SizedBox(height: xxxSmallestSpacing),
          LotoDetailsAssetDocuments(data: data, clientId: clientId),
          Text(DatabaseUtil.getText("safelock_number"),
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(data.safelockno),
          const SizedBox(height: xxxSmallestSpacing),
          Text(DatabaseUtil.getText("contractor"),
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: xxxSmallestSpacing),
          Text(DatabaseUtil.getText("additional_info"),
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          Text(data.additionalinfo),
          const SizedBox(height: xxxSmallestSpacing),
          Text(StringConstants.kComments,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          LotoDetailsCommentsList(data: data),
          const SizedBox(height: xxxSmallestSpacing),
        ]),
      ),
    );
  }
}
