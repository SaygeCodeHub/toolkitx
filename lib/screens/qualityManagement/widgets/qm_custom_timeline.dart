import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/qualityManagement/fetch_qm_details_model.dart';

class QualityManagementCustomTimeline extends StatelessWidget {
  final QMDetailsData data;
  final int initialIndex;

  const QualityManagementCustomTimeline(
      {super.key, required this.data, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: xxxSmallerSpacing, bottom: xxxSmallerSpacing),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: data.logs.length,
        itemBuilder: (context, index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildDateAndTime(index),
              const SizedBox(width: xxTinySpacing),
              _buildVerticalTimelinePath(index, context),
              const SizedBox(width: xxTinySpacing),
              _buildContent(index, context)
            ],
          );
        },
      ),
    );
  }

  Widget _buildVerticalTimelinePath(int index, context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.035,
          height: MediaQuery.of(context).size.width * 0.035,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.lightGrey,
          ),
        ),
        Visibility(
          visible: index != data.logs.length - 1,
          child: Container(
            width: 1,
            height: MediaQuery.of(context).size.height * 0.13,
            color: AppColor.lightGrey,
          ),
        ),
      ],
    );
  }

  Widget _buildDateAndTime(int index) {
    List<String> dateTime = data.logs[index].createdAt.split(' ');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/icons/calendar.png',
                height: kImageMediumHeight, width: kImageMediumWidth),
            const SizedBox(width: xxTiniestSpacing),
            Text(dateTime[0])
          ],
        ),
        const SizedBox(height: xxTinierSpacing),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/icons/clock.png',
                height: kImageMediumHeight, width: kImageMediumWidth),
            const SizedBox(width: xxTiniestSpacing),
            Text(dateTime[1])
          ],
        )
      ],
    );
  }

  Widget _buildContent(int index, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.logs[index].createdBy,
          style: Theme.of(context).textTheme.small.copyWith(
              fontWeight: FontWeight.w700, color: AppColor.mediumBlack),
        ),
        const SizedBox(height: xxTiniestSpacing),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.490,
            child: Text(
              data.logs[index].action,
              style: Theme.of(context)
                  .textTheme
                  .xSmall
                  .copyWith(color: AppColor.grey),
              maxLines: 7,
            )),
      ],
    );
  }
}
