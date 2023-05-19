import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';

class DetailsLabelSection extends StatelessWidget {
  const DetailsLabelSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
          padding: const EdgeInsets.all(tiniestSpacing),
          decoration: BoxDecoration(
              color: AppColor.lightGreen,
              borderRadius: BorderRadius.circular(kCardRadius)),
          height: kLabelHeight,
          child: Text('Responded',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .xSmall
                  .copyWith(color: AppColor.white))),
      const SizedBox(width: tiniestSpacing),
      const Icon(Icons.question_mark_outlined,
          color: AppColor.errorRed, size: kIconSize)
    ]);
  }
}
