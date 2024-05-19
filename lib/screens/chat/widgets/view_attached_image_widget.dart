import 'dart:io';

import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

class ViewAttachedImageWidget extends StatelessWidget {
  static const routeName = 'ViewAttachedImageWidget';
  final String attachmentPath;

  const ViewAttachedImageWidget({super.key, required this.attachmentPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(leftRightMargin),
        child: Center(
          child: Image.file(
            File(attachmentPath),
            fit: BoxFit.cover,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return Text('Failed to load image: $exception');
            },
          ),
        ),
      ),
    );
  }
}
