import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/qualityManagement/fetch_qm_details_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_card.dart';
import 'qm_comment_view_network_image.dart';

class QualityManagementComment extends StatelessWidget {
  final QMDetailsData data;
  final int initialIndex;
  final String clientId;

  const QualityManagementComment(
      {Key? key,
      required this.data,
      required this.initialIndex,
      required this.clientId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (data.commentslist.isEmpty)
        ? Center(
            child: Text(StringConstants.kNoComment,
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w700, color: AppColor.mediumBlack)))
        : ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: data.commentslist.length,
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
                      Text(data.commentslist[index].ownername,
                          style: Theme.of(context).textTheme.small.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColor.mediumBlack)),
                      Text(data.commentslist[index].created,
                          style: Theme.of(context).textTheme.xSmall.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColor.mediumBlack))
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: xxxTinierSpacing),
                      Text(data.commentslist[index].comments,
                          style: Theme.of(context).textTheme.xSmall),
                      const SizedBox(height: xxTinierSpacing),
                      Visibility(
                          visible: data.commentslist[index].files != null,
                          child: QualityManagementViewNetworkImage(
                              commentsList: data.commentslist[index],
                              clientId: clientId)),
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
