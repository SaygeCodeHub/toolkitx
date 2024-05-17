// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

class FileViewer {
  Future<void> viewFile(BuildContext context, String filePath) async {
    final file = File(filePath);
    final extension = file.path.split('.').last;

    await _openFile(context, file, extension);
  }

  Future<void> _openFile(
      BuildContext context, File file, String extension) async {
    switch (extension.toLowerCase()) {
      case 'csv':
        _viewCsvFile(context, file);
        break;
      case 'doc':
      case 'docx':
      case 'ppt':
      case 'pptx':
      case 'xlsx':
        _viewDocumentFile(context, file);
        break;
      default:
        throw UnsupportedError('Unsupported file type');
    }
  }

  Widget viewDocumentIcons(String filePath) {
    final file = File(filePath);
    final extension = file.path.split('.').last;
    switch (extension.toLowerCase()) {
      case 'doc':
        return Image.asset(
          'assets/icons/docx.png',
          height: 40,
          width: 40,
        );
      case 'docx':
        return Image.asset('assets/icons/docx.png', height: 40, width: 40);
      case 'ppt':
        return Image.asset('assets/icons/ppt.png', height: 40, width: 40);
      case 'pptx':
        return Image.asset('assets/icons/ppt.png', height: 40, width: 40);
      case 'xlsx':
        return Image.asset('assets/icons/xlxs.png', height: 40, width: 40);
      default:
        return const Icon(Icons.folder);
    }
  }

  void _viewCsvFile(BuildContext context, File file) async {
    final content = await file.readAsString();
    final rows = const CsvToListConverter().convert(content);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('CSV Content'),
          content: SingleChildScrollView(
            child: Column(
              children: rows.map((row) {
                return Text(row.join(', '));
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _viewDocumentFile(BuildContext context, File file) async {
    final result = await OpenFile.open(file.path);

    if (result.type == ResultType.noAppToOpen) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Alert'),
            content: const Text('No app available to open this file type.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }
}
