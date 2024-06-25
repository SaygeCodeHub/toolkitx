import 'package:flutter/material.dart';

import '../configs/app_dimensions.dart';
import '../configs/app_spacing.dart';

class IconAndTextRow extends StatelessWidget {
  final String? title;
  final String? icon;

  const IconAndTextRow({super.key, this.title = '', this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/icons/$icon.png',
            height: kImageHeight, width: kImageWidth),
        const SizedBox(width: tiniestSpacing),
        Text(title!)
      ],
    );
  }
}
