import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_spacing.dart';

class AttachmentMsgWidget extends StatelessWidget {
  final snapshot;
  final int reversedIndex;

  const AttachmentMsgWidget(
      {super.key, required this.snapshot, required this.reversedIndex});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          right: kModuleImagePadding,
          left: kModuleImagePadding,
          bottom: kModuleImagePadding),
      child: Column(
        children: [
          Align(
              alignment: (snapshot.data![reversedIndex]['isReceiver'] == 1)
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: showDownloadedImage(snapshot.data![reversedIndex]['msg'])),
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
    print('imagePath $imagePath');
    return (imagePath.isNotEmpty)
        ? SizedBox(
            width: 100,
            height: 100,
            child: Image.file(fit: BoxFit.cover, errorBuilder:
                (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
              return Text('Failed to load image: $exception');
            }, File('/data/user/0/com.example.toolkitx/app_flutter/2024-04-16 23:10:21.406681.jpg')),
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
                  print('${snapshot.data![reversedIndex]['isReceiver']}');
                  String url =
                      "https://images.unsplash.com/photo-1706874505664-b0e5334e3add?q=80&w=2532&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
                  print('image url $url');
                  DateTime imageName = DateTime.now();
                  String filePath = await downloadImage(url, "$imageName.jpg");
                  print("Image downloaded to $filePath");
                },
              ),
            ),
          );
  }
}

Future<String> downloadImage(String url, String filename) async {
  await requestPermission();

  Directory directory = await getApplicationDocumentsDirectory();
  String path = directory.path;
  String filePath = '$path/$filename';
  Dio dio = Dio();

  try {
    await dio.download(url, filePath, onReceiveProgress: (received, total) {
      if (total != -1) {
        print(
            "Received: $received, Total: $total, Progress: ${((received / total) * 100).toStringAsFixed(0)}%");
      }
    });
    print("Download completed: $filePath");
  } catch (e) {
    print("Error downloading the file: $e");
    throw e;
  }

  return filePath;
}

Future<void> requestPermission() async {
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
}
