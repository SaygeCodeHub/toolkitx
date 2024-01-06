import 'package:flutter/material.dart';

import '../configs/app_color.dart';
import '../configs/app_dimensions.dart';

class ExpansionTileBorder {
  OutlineInputBorder buildOutlineInputBorder() {
    return const OutlineInputBorder(
        borderSide: BorderSide(
      color: AppColor.grey,
      width: kExpansionBorderWidth,
    ));
  }
}
