import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/certificates/certificate_list_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_card.dart';
import 'certificate_button_row.dart';

class CertificateListCard extends StatelessWidget {
  const CertificateListCard({super.key, required this.data, required this.clientId});

  final CertificateListDatum data;
  final String clientId;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        elevation: 2,
        child: Padding(
            padding: const EdgeInsets.only(top: tinierSpacing),
            child: Column(children: [
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: xxxTinierSpacing),
                  child: Text(data.name,
                      style: Theme.of(context).textTheme.small.copyWith(
                          fontWeight: FontWeight.w500, color: AppColor.black)),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    data.actualDates.isNotEmpty
                        ? Text(data.actualDates)
                        : const Text(StringConstants.kNotAvailable),
                    const SizedBox(height: xxxTinierSpacing),
                    buildVisibility(
                        context,
                        data.status == 1,
                        AppColor.lightestGrey,
                        StringConstants.kApprovalPending,
                        AppColor.black),
                    buildVisibility(
                        context,
                        data.status == 3,
                        AppColor.errorRed,
                        DatabaseUtil.getText('Rejected'),
                        AppColor.white),
                    buildVisibility(
                        context,
                        data.expired == '0',
                        AppColor.errorRed,
                        DatabaseUtil.getText('Expired'),
                        AppColor.white),
                    buildVisibility(
                        context,
                        data.expired == '1',
                        AppColor.yellow,
                        DatabaseUtil.getText('about_to_expire'),
                        AppColor.white),
                    buildVisibility(context, data.expired == '2',
                        AppColor.green, StringConstants.kValid, AppColor.white),
                  ],
                ),
                trailing: Image.asset('assets/icons/certificate.png',
                    height: kImageHeight, width: kImageWidth),
              ),
              const Divider(color: AppColor.lightestGrey),
              CertificateButtonRow(data: data, clientId: clientId,)
            ])));
  }

  Visibility buildVisibility(BuildContext context, bool visible, Color color,
      String title, Color textColor) {
    return Visibility(
        visible: visible,
        child: Card(
            color: color,
            child: Padding(
                padding: const EdgeInsets.all(tiniestSpacing),
                child: Text(title,
                    style: Theme.of(context).textTheme.xxSmall.copyWith(
                        fontWeight: FontWeight.w500, color: textColor)))));
  }
}
