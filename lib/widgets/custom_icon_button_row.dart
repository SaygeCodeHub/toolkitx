import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

class CustomIconButtonRow extends StatelessWidget {
  final IconData primaryIcon;
  final IconData secondaryIcon;
  final bool primaryVisible;
  final bool downloadVisible;
  final bool clearVisible;
  final bool secondaryVisible;
  final bool isEnabled;
  final String textValue;
  final void Function() primaryOnPress;
  final void Function() clearOnPress;
  final void Function() secondaryOnPress;
  final void Function()? onDownloadPress;

  const CustomIconButtonRow(
      {super.key,
      this.primaryIcon = Icons.filter_alt_outlined,
      this.secondaryIcon = Icons.settings_outlined,
      required this.primaryOnPress,
      required this.secondaryOnPress,
      this.downloadVisible = false,
      this.isEnabled = true,
      this.primaryVisible = true,
      this.secondaryVisible = true,
      this.clearVisible = false,
      required this.clearOnPress,
      this.onDownloadPress,
      this.textValue = StringConstants.kClearFilter});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Visibility(
        visible: downloadVisible,
        child: IconButton(
            constraints: const BoxConstraints(),
            onPressed: onDownloadPress,
            icon: const Icon(Icons.download_rounded, color: AppColor.grey)),
      ),
      Visibility(
          visible: clearVisible,
          child: TextButton(onPressed: clearOnPress, child: Text(textValue))),
      Visibility(
          visible: primaryVisible,
          child: IconButton(
              constraints: const BoxConstraints(),
              onPressed: isEnabled ? primaryOnPress : null,
              icon: Icon(primaryIcon, color: AppColor.grey))),
      Visibility(
          visible: secondaryVisible,
          child: IconButton(
              constraints: const BoxConstraints(),
              onPressed: isEnabled ? secondaryOnPress : null,
              icon: Icon(secondaryIcon, color: AppColor.grey)))
    ]);
  }
}
