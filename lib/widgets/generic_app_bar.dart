import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../configs/app_dimensions.dart';

class GenericAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GenericAppBar(
      {super.key, this.title = '', this.leading, this.actions, this.onPressed});
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(title),
        titleTextStyle: Theme.of(context).textTheme.mediumLarge,
        leading: BackButton(
          onPressed: onPressed,
        ),
        actions: actions);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kAppBarHeight);
}
