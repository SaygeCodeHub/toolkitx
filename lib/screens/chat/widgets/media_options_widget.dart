import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';

class MediaOptionsWidget extends StatelessWidget {
  final void Function() onMediaSelected;
  final Map mediaDataMap;

  const MediaOptionsWidget(
      {super.key, required this.onMediaSelected, required this.mediaDataMap});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      InkWell(
          onTap: onMediaSelected,
          child: Container(
              padding: const EdgeInsets.all(xxTinierSpacing),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(kMediaContainerBorderRadius),
                color: mediaDataMap['color'],
              ),
              child: Icon(mediaDataMap['icon'], color: AppColor.white))),
      const SizedBox(height: xxTiniestSpacing),
      Text(mediaDataMap['media'],
          style: Theme.of(context)
              .textTheme
              .xxSmall
              .copyWith(fontWeight: FontWeight.w500))
    ]);
  }
}
