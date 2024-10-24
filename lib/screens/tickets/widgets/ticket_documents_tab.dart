import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/api_constants.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/models/tickets/fetch_ticket_details_model.dart';
import '../../../utils/generic_alphanumeric_generator_util.dart';
import '../../tickets2/widgets/ticket_two_view_document.dart';

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
                  GridView.builder(
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: tinierSpacing,
                              mainAxisSpacing: tinierSpacing),
                      itemCount: ticketData.documents[index].fileName
                          .toString()
                          .split(',')
                          .length,
                      itemBuilder: (context, docIndex) {
                        return InkWell(
                            splashColor: AppColor.transparent,
                            highlightColor: AppColor.transparent,
                            onTap: () {
                              launchUrlString(
                                  '${ApiConstants.viewDocBaseUrl}${ticketData.documents[index].fileName.toString().split(',')[docIndex]}&code=${RandomValueGeneratorUtil.generateRandomValue(clientId)}',
                                  mode: LaunchMode.externalApplication);
                            },
                            child: (ticketData.documents[index].fileName
                                        .toString()
                                        .split(',')[docIndex]
                                        .contains('.jpg') ||
                                    ticketData.documents[index].fileName
                                        .toString()
                                        .split(',')[docIndex]
                                        .contains('.png'))
                                ? CachedNetworkImage(
                                    height: kCachedNetworkImageHeight,
                                    imageUrl:
                                        '${ApiConstants.viewDocBaseUrl}${ticketData.documents[index].fileName.toString().split(',')[docIndex]}&code=${RandomValueGeneratorUtil.generateRandomValue(clientId)}',
                                    placeholder: (context, url) => Shimmer.fromColors(
                                        baseColor: AppColor.paleGrey,
                                        highlightColor: AppColor.white,
                                        child: Container(
                                            height:
                                                kNetworkImageContainerTogether,
                                            width:
                                                kNetworkImageContainerTogether,
                                            decoration: BoxDecoration(
                                                color: AppColor.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        kCardRadius)))),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error_outline_sharp, size: kIconSize))
                                : viewDocument(ticketData.documents[index].fileName.toString().split(',')[docIndex]));
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
