import 'package:flutter/material.dart';

import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/permit/all_permits_model.dart';
import '../../../utils/date_util.dart';

class DateTimeRow extends StatelessWidget {
  final AllPermitDatum allPermitDatum;

  const DateTimeRow({Key? key, required this.allPermitDatum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('assets/icons/calendar.png',
                    height: kImageHeight, width: kImageWidth),
                const SizedBox(width: tiniestSpacing),
                Text((allPermitDatum.enddate == '')
                    ? DateUtil.splitDateTime(allPermitDatum.startdate!)[0]
                    : '${DateUtil.splitDateTime(allPermitDatum.startdate!)[0]} - ${DateUtil.splitDateTime(allPermitDatum.enddate!)[0]}')
              ]),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('assets/icons/clock.png',
                    height: kImageHeight, width: kImageWidth),
                const SizedBox(width: tiniestSpacing),
                Text((allPermitDatum.enddate == '')
                    ? DateUtil.splitDateTime(allPermitDatum.startdate!)[1]
                    : '${DateUtil.splitDateTime(allPermitDatum.startdate!)[1]} - ${DateUtil.splitDateTime(allPermitDatum.enddate!)[1]}')
              ])
        ]);
  }
}
