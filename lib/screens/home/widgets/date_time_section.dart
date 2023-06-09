import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';

import '../../../blocs/home/home_bloc.dart';
import '../../../blocs/home/home_states.dart';
import '../../../configs/app_dimensions.dart';
import '../../../utils/date_util.dart';

class DateAndTimeSection extends StatelessWidget {
  const DateAndTimeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeStates>(builder: (context, state) {
      if (state is DateAndTimeLoaded) {
        return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          CachedNetworkImage(
              height: kHomeScreenImageHeight,
              imageUrl: state.image,
              placeholder: (context, url) => const Center(
                  child: SizedBox(
                      height: kImageCircularProgressIndicatorSize,
                      width: kImageCircularProgressIndicatorSize,
                      child: CircularProgressIndicator(
                          strokeWidth: kCircularIndicatorStrokeWidth))),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.error_outline_sharp, size: kIconSize)),
          const SizedBox(height: xxxSmallerSpacing),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/calendar.png',
                    height: kImageHeight, width: kImageWidth),
                const SizedBox(width: xxTiniestSpacing),
                Text(DateUtil.formatDate(state.dateTime, state.dateFormat)),
                const SizedBox(width: xxxTinierSpacing),
                Image.asset('assets/icons/clock.png',
                    height: kImageHeight, width: kImageWidth),
                const SizedBox(width: xxTiniestSpacing),
                Text(DateUtil.formatTime(state.dateTime))
              ]),
          const SizedBox(height: xxxTinierSpacing),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: xxxTinierSpacing),
                Image.asset('assets/icons/time_zone.png',
                    height: kImageHeight, width: kImageWidth),
                const SizedBox(width: xxTiniestSpacing),
                Text(state.timeZoneName)
              ])
        ]);
      } else {
        return const SizedBox();
      }
    });
  }
}
