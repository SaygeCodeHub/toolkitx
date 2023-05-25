import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../configs/app_dimensions.dart';

class GenericAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GenericAppBar(
      {Key? key, this.textValue = '', this.leading, this.actions})
      : super(key: key);
  final String textValue;
  final Widget? leading;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(textValue),
        titleTextStyle: Theme.of(context).textTheme.mediumLarge,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back,
                color: Colors.black, size: kIconSize),
            onPressed: () => Navigator.of(context).pop()),
        actions: actions);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kAppBarHeight);
}
