import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/incident/fetch_incidents_list_model.dart';

class IncidentListTitle extends StatelessWidget {
  final IncidentListDatum incidentListDatum;

  const IncidentListTitle({super.key, required this.incidentListDatum});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: xxTinierSpacing),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(incidentListDatum.refno,
                  style: Theme.of(context).textTheme.small.copyWith(
                      color: AppColor.black, fontWeight: FontWeight.w600)),
              const SizedBox(width: tinierSpacing),
              Text(incidentListDatum.status,
                  style: Theme.of(context)
                      .textTheme
                      .xxSmall
                      .copyWith(color: AppColor.deepBlue))
            ]));
  }
}
