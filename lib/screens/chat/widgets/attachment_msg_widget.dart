import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_spacing.dart';
import '../../../di/app_module.dart';
import '../../../utils/chat/chat_database_util.dart';

class AttachmentMsgWidget extends StatelessWidget {
  final snapshot;
  final int reversedIndex;

  const AttachmentMsgWidget(
      {super.key, required this.snapshot, required this.reversedIndex});

  @override
  Widget build(BuildContext context) {
    print('snapshot data ${snapshot.toString()}');
    return Padding(
      padding: const EdgeInsets.only(
          right: kModuleImagePadding,
          left: kModuleImagePadding,
          bottom: kModuleImagePadding),
      child: Column(
        children: [
          (snapshot.data![reversedIndex]['isReceiver'] == 1)
              ? Align(
                  alignment: Alignment.centerLeft,
                  child: showDownloadedImage(snapshot.data![reversedIndex]
                          ['localImagePath']
                      .toString()))
              : Align(
                  alignment: Alignment.centerRight,
                  child: showDownloadedImage(
                      snapshot.data![reversedIndex]['pickedMedia'].toString())),
          Align(
            alignment: (snapshot.data![reversedIndex]['isReceiver'] == 1)
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(tiniestSpacing),
              child: Text(
                  DateFormat('h:mm a').format(DateTime.parse(
                      snapshot.data?[reversedIndex]['msg_time'])),
                  style: Theme.of(context).textTheme.smallTextBlack),
            ),
          ),
        ],
      ),
    );
  }

  Widget showDownloadedImage(String imagePath) {
    return (imagePath.toString() != 'null')
        ? SizedBox(
            width: 100,
            height: 100,
            child: Image.file(fit: BoxFit.cover, errorBuilder:
                (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
              return Text('Failed to load image: $exception');
            }, File(imagePath)),
          )
        : Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0), // Rounded corners
            ),
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.download),
                onPressed: () async {
                  String url =
                      "https://images.unsplash.com/photo-1706874505664-b0e5334e3add?q=80&w=2532&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
                  DateTime imageName = DateTime.now();
                  await downloadImage(url, "$imageName.jpg",
                      snapshot.data![reversedIndex]['msg_id']);
                },
              ),
            ),
          );
  }
}

Future<String> downloadImage(String url, String filename, msgId) async {
  await requestPermission();

  Directory directory = await getApplicationDocumentsDirectory();
  String path = directory.path;
  String filePath = '$path/$filename';
  Dio dio = Dio();

  try {
    await dio.download(url, filePath, onReceiveProgress: (received, total) {
      if (total != -1) {}
    });
    final DatabaseHelper databaseHelper = getIt<DatabaseHelper>();
    await databaseHelper.updateLocalImagePath(msgId, filePath);
  } catch (e) {
    rethrow;
  }

  return filePath;
}

Future<void> requestPermission() async {
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
}
