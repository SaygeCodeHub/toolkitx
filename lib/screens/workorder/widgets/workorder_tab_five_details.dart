import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/global.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/workorder/fetch_workorder_details_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_card.dart';
import 'workorder_view_network_image.dart';

class WorkOrderTabFiveDetails extends StatelessWidget {
  final WorkOrderDetailsData data;
  final int tabIndex;
  final String clientId;

  const WorkOrderTabFiveDetails(
      {Key? key,
      required this.data,
      required this.tabIndex,
      required this.clientId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (data.comments.isEmpty)
        ? Center(
            child: Text(StringConstants.kNoComment,
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w700, color: AppColor.mediumBlack)))
        : ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: data.comments.length,
            itemBuilder: (context, index) {
              print('comments photo list ${data.comments[index].toJson()}');
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
                      Text(data.comments[index].ownername,
                          style: Theme.of(context).textTheme.small.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColor.mediumBlack)),
                      Text(data.comments[index].created,
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(fontWeight: FontWeight.w500))
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: xxxTinierSpacing),
                      Text(data.comments[index].comments,
                          style: Theme.of(context).textTheme.xSmall),
                      const SizedBox(height: xxTinierSpacing),
                      Visibility(
                          visible: (data.comments[index].files != '' &&
                              isNetworkEstablished),
                          child: WorkOrderViewNetworkImage(
                              comment: data.comments[index],
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
