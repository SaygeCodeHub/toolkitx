import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/api_constants.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../configs/app_color.dart';
import '../../../data/models/tickets/fetch_ticket_details_model.dart';
import '../../../utils/generic_alphanumeric_generator_util.dart';
import '../../../widgets/text_button.dart';

class TicketDocumentsTab extends StatelessWidget {
  const TicketDocumentsTab(
      {super.key, required this.ticketData, required this.clientId});

  final TicketData ticketData;
  final String clientId;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: ticketData.documents.length,
      itemBuilder: (context, index) {
        return CustomCard(
          child: Padding(
            padding: const EdgeInsets.only(top: tiniestSpacing),
            child: ListTile(
              title: Text(ticketData.documents[index].comment,
                  style: Theme.of(context).textTheme.xSmall.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColor.mediumBlack)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: tiniestSpacing),
                  Text(ticketData.documents[index].author,
                      style: Theme.of(context).textTheme.xSmall.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColor.mediumBlack)),
                  CustomTextButton(
                      textValue: StringConstants.kViewDocument,
                      onPressed: () {
                        launchUrlString(
                            '${ApiConstants.viewDocBaseUrl}${ticketData.documents[index].fileName}&code=${RandomValueGeneratorUtil.generateRandomValue(clientId)}',
                            mode: LaunchMode.externalApplication);
                      }),
                ],
              ),
              trailing: Text(ticketData.documents[index].createddate),
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
