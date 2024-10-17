import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';

import '../../../chat/file_viewer.dart';
import '../../../chat/widgets/view_attached_image_widget.dart';

Future<void> onFileTapped(
    BuildContext context, String filename, FileViewer fileViewer) async {
  Directory directory = await getApplicationCacheDirectory();
  String path = directory.path;
  String filePath = '$path/$filename';

  File file = File(filePath);
  bool fileExists = await file.exists();

  if (!fileExists) {
    if (context.mounted) {
      showCustomSnackBar(context, 'File not accessible in offline mode.', '');
    }
    return;
  }

  if (filename.toLowerCase().endsWith('.png') ||
      filename.toLowerCase().endsWith('.jpg') ||
      filename.toLowerCase().endsWith('.jpeg') ||
      filename.toLowerCase().endsWith('.bmp') ||
      filename.toLowerCase().endsWith('.gif')) {
    if (context.mounted) {
      Navigator.pushNamed(context, ViewAttachedImageWidget.routeName,
          arguments: filePath);
    }
  } else if (filename.toLowerCase().endsWith('.pdf')) {
    await OpenFile.open(filePath);
  } else {
    if (context.mounted) {
      await fileViewer.viewFile(context, filePath);
    }
  }
}
