import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/api_constants.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../configs/app_color.dart';
import '../../../data/models/tickets2/fetch_ticket_two_details_model.dart';
import '../../../utils/generic_alphanumeric_generator_util.dart';
import '../../../widgets/text_button.dart';

class TicketTwoDocumentsTab extends StatelessWidget {
  const TicketTwoDocumentsTab(
      {super.key, required this.ticketTwoData, required this.clientId});

  final TicketTwoData ticketTwoData;
  final String clientId;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: ticketTwoData.documents.length,
      itemBuilder: (context, index) {
        return CustomCard(
          child: Padding(
            padding: const EdgeInsets.only(top: tiniestSpacing),
            child: ListTile(
              title: Text(ticketTwoData.documents[index].comment,
                  style: Theme.of(context).textTheme.xSmall.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColor.mediumBlack)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: tiniestSpacing),
                  Text(ticketTwoData.documents[index].author,
                      style: Theme.of(context).textTheme.xSmall.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColor.mediumBlack)),
                  CustomTextButton(
                      textValue: StringConstants.kViewDocument,
                      onPressed: () {
                        launchUrlString(
                            '${ApiConstants.viewDocBaseUrl}${ticketTwoData.documents[index].fileName}&code=${RandomValueGeneratorUtil.generateRandomValue(clientId)}',
                            mode: LaunchMode.externalApplication);
                      }),
                ],
              ),
              trailing: Text(ticketTwoData.documents[index].createddate),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: tiniestSpacing);
      },
    );
  }
}
