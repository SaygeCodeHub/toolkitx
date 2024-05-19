import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/loto/loto_details_model.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/generic_alphanumeric_generator_util.dart';

class LotoDetailsAssetDocuments extends StatelessWidget {
  const LotoDetailsAssetDocuments({
    super.key,
    required this.data,
    required this.clientId,
  });

  final LotoData data;
  final String clientId;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: data.assetdocs.isNotEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(StringConstants.kAssetDocuments,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: tiniestSpacing),
          ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.assetdocs.length,
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return const SizedBox(height: xxTinierSpacing);
              },
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      launchUrlString(
                          '${ApiConstants.viewDocBaseUrl}${data.assetdocs[index].filename}&code=${RandomValueGeneratorUtil.generateRandomValue(clientId)}',
                          mode: LaunchMode.externalApplication);
                    },
                    child: RichText(
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        textDirection: TextDirection.rtl,
                        softWrap: true,
                        maxLines: 2,
                        text: TextSpan(
                            text: "${data.assetdocs[index].name} : ",
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                  text: data.assetdocs[index].filename,
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
        ],
      ),
    );
  }
}
