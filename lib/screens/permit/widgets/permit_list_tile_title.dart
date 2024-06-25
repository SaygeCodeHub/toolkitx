import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/permit/all_permits_model.dart';

class PermitListTileTitle extends StatelessWidget {
  final AllPermitDatum allPermitDatum;

  const PermitListTileTitle({super.key, required this.allPermitDatum});

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Text(allPermitDatum.permit!,
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.bold, color: AppColor.black)),
            const SizedBox(width: tinierSpacing),
            (allPermitDatum.emergency == 1)
                ? Image.asset('assets/icons/warning.png',
                    height: kImageHeight, width: kImageWidth)
                : const SizedBox.shrink(),
            const SizedBox(width: tinierSpacing),
            (allPermitDatum.actionCount > 0)
                ? const Icon(Icons.pending_actions_rounded,
                    size: kImageHeight, color: AppColor.orange)
                : const SizedBox.shrink()
          ]),
          Text(allPermitDatum.status!,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  fontWeight: FontWeight.w500, color: AppColor.deepBlue))
        ]);
  }
}
