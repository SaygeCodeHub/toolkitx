import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/qualityManagement/fetch_qm_list_model.dart';

class QualityManagementListTileTitle extends StatelessWidget {
  final QMListDatum data;

  const QualityManagementListTileTitle({Key? key, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: xxTinierSpacing),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(data.refno,
                  style: Theme.of(context).textTheme.small.copyWith(
                      color: AppColor.black, fontWeight: FontWeight.w600)),
              const SizedBox(width: tinierSpacing),
              Text(data.status,
                  style: Theme.of(context)
                      .textTheme
                      .xxSmall
                      .copyWith(color: AppColor.deepBlue))
            ]));
  }
}
