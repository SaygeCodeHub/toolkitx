import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';

class AttachementDocumentWidget extends StatelessWidget {
  final String docPath;

  const AttachementDocumentWidget({super.key, required this.docPath});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Container(
            color: AppColor.lightGrey,
            height: 100,
            width: 100,
            child: const Icon(Icons.folder)));
  }
}
