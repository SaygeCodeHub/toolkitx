import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/incident/incident_details_model.dart';
import 'package:toolkit/screens/incident/widgets/view_incident_details_network_image.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_card.dart';

class PermitDetailsComment extends StatelessWidget {
  final IncidentDetailsModel incidentDetailsModel;
  final String clientId;
  final int initialIndex;

  const PermitDetailsComment(
      {super.key,
      required this.incidentDetailsModel,
      required this.clientId,
      required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return (incidentDetailsModel.data!.commentslist!.isEmpty)
        ? Center(
            child: Text(StringConstants.kNoComment,
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w700, color: AppColor.mediumBlack)))
        : ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: incidentDetailsModel.data!.commentslist!.length,
            itemBuilder: (context, index) {
              return CustomCard(
                child: ListTile(
                  contentPadding: const EdgeInsets.only(
                      left: tinierSpacing,
                      right: tinierSpacing,
                      top: tiniestSpacing,
                      bottom: tiniestSpacing),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          incidentDetailsModel
                              .data!.commentslist![index].ownername,
                          style: Theme.of(context).textTheme.small.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColor.mediumBlack)),
                      Text(
                          incidentDetailsModel
                              .data!.commentslist![index].created,
                          style: Theme.of(context).textTheme.xSmall.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColor.mediumBlack))
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: xxxTinierSpacing),
                      Text(
                          incidentDetailsModel
                              .data!.commentslist![index].comments,
                          style: Theme.of(context).textTheme.xSmall),
                      const SizedBox(height: xxTinierSpacing),
                      Visibility(
                        visible: incidentDetailsModel
                                .data!.commentslist![index].files !=
                            null,
                        child: IncidentCommentViewNetworkImage(
                            commentsList:
                                incidentDetailsModel.data!.commentslist![index],
                            clientId: clientId),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: xxTinierSpacing);
            },
          );
  }
}
