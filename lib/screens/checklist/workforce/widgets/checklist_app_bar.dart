import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../../configs/app_dimensions.dart';

class ChecklistAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChecklistAppBar(
      {super.key,
      required this.title,
      this.leading,
      this.actions,
      this.onPressed});
  final Widget title;
  final Widget? leading;
  final List<Widget>? actions;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: title,
        titleTextStyle: Theme.of(context).textTheme.mediumLarge,
        leading: BackButton(
          onPressed: onPressed,
        ),
        actions: actions);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kAppBarHeight);
}
