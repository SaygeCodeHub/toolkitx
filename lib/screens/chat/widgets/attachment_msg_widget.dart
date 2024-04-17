import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/api_constants.dart';

import '../../../configs/app_spacing.dart';
import '../../../data/cache/cache_keys.dart';
import '../../../data/cache/customer_cache.dart';
import '../../../di/app_module.dart';

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

  Widget showDownloadedImage(String attachmentPath) {
    return (attachmentPath.toString() != 'null')
        ? SizedBox(
            width: 100,
            height: 100,
            child: Image.file(fit: BoxFit.cover, errorBuilder:
                (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
              return Text('Failed to load image: $exception');
            }, File(attachmentPath)),
          )
        : Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10.0), // Rounded corners
            ),
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.download, color: Colors.black45),
                onPressed: () async {
                  final CustomerCache customerCache = getIt<CustomerCache>();
                  String? hashCode =
                      await customerCache.getHashCode(CacheKeys.hashcode);
                  String url =
                      '${ApiConstants.baseUrl}${ApiConstants.chatDocBaseUrl}${snapshot.data![reversedIndex]['msg'].toString()}&hashcode=$hashCode';
                  DateTime imageName = DateTime.now();
                  await downloadFileFromUrl(url, "$imageName.jpg");
                  //  snapshot.data![reversedIndex]['msg_id']);
                },
              ),
            ),
          );
  }
}

Future<void> downloadFileFromUrl(String url, imageName) async {
  try {
    final Dio dio = Dio();

    final Response response = await dio.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = response.data;
      dynamic messageValue = jsonResponse['Message'];

      if (messageValue is String) {
        String downloadUrl = messageValue;
        String finalUrl = '${ApiConstants.baseDocUrl}$downloadUrl';
        await _downloadFile(finalUrl, imageName);
      } else {
        throw Exception('Invalid message value: $messageValue');
      }
    } else {
      throw Exception('Failed to fetch download URL');
    }
  } catch (e) {
    print('Error: $e');
    throw e;
  }
}

Future<void> _downloadFile(String downloadUrl, imageName) async {
  try {
    HttpClient httpClient = HttpClient();
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(downloadUrl));
    HttpClientResponse response = await request.close();
    if (response.statusCode == 200) {
      File file = File(imageName);
      IOSink sink = file.openWrite();
      await response.pipe(sink);
      await sink.close();
      print('File downloaded successfully.');
    } else {
      throw Exception('Failed to download file');
    }
  } catch (e) {
    print('Error downloading file: $e');
    throw e;
  }
}
