import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/chat/widgets/view_attached_image_widget.dart';
import 'package:toolkit/utils/chat/attachement_msg_type_util.dart';
import 'package:toolkit/utils/constants/api_constants.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../../blocs/chat/chat_bloc.dart';
import '../../../blocs/chat/chat_event.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/cache/cache_keys.dart';
import '../../../data/cache/customer_cache.dart';
import '../../../di/app_module.dart';
import '../../../utils/database/database_util.dart';

class AttachmentMsgWidget extends StatelessWidget {
  final snapshot;
  final int reversedIndex;

  const AttachmentMsgWidget(
      {super.key, required this.snapshot, required this.reversedIndex});

  @override
  Widget build(BuildContext context) {
    print('receiver ${snapshot.data![reversedIndex]['isReceiver']}');
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
                  child: showDownloadedImage(
                      snapshot.data![reversedIndex]['localImagePath']
                          .toString(),
                      context,
                      snapshot.data![reversedIndex]['msg_type'],
                      snapshot.data![reversedIndex]['isReceiver']))
              : Align(
                  alignment: Alignment.centerRight,
                  child: showDownloadedImage(
                      snapshot.data![reversedIndex]['pickedMedia'].toString(),
                      context,
                      snapshot.data![reversedIndex]['msg_type'],
                      snapshot.data![reversedIndex]['isReceiver'])),
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

  Widget showDownloadedImage(String attachmentPath, BuildContext context,
      String type, int isReceiver) {
    return (attachmentPath.toString() != 'null')
        ? SizedBox(
            width: 100,
            height: 100,
            child: AttachementMsgTypeUtil()
                .renderWidget(type, attachmentPath, context, isReceiver))
        : Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10.0), // Rounded corners
            ),
            child: Center(
              child: IconButton(
                icon: showIconForSender(isReceiver, type),
                onPressed: () async {
                  ProgressBar.show(context);
                  final CustomerCache customerCache = getIt<CustomerCache>();
                  String? hashCode =
                      await customerCache.getHashCode(CacheKeys.hashcode);
                  String url =
                      '${ApiConstants.baseUrl}${ApiConstants.chatDocBaseUrl}${snapshot.data![reversedIndex]['msg'].toString()}&hashcode=$hashCode';
                  DateTime imageName = DateTime.now();
                  bool downloadProcessComplete = await downloadFileFromUrl(
                      url,
                      "$imageName.jpg",
                      snapshot.data![reversedIndex]['msg_id'],
                      snapshot.data![reversedIndex]['msg_type']);
                  if (downloadProcessComplete) {
                    if (!context.mounted) return;
                    ProgressBar.dismiss(context);
                    context.read<ChatBloc>().add(RebuildChatMessagingScreen(
                        employeeDetailsMap:
                            context.read<ChatBloc>().chatDetailsMap));
                  }
                },
              ),
            ),
          );
  }
}

Widget showIconForSender(int isReceiver, String msgType) {
  switch (msgType) {
    case '3':
      return const Center(child: Icon(Icons.video_collection));
    case '4':
      return const Center(child: Icon(Icons.folder));
    default:
      return const Center(child: Icon(Icons.download));
  }
}

Future<bool> downloadFileFromUrl(String url, imageName, msgId, msgType) async {
  try {
    final Dio dio = Dio();

    final Response response = await dio.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = response.data;
      dynamic messageValue = jsonResponse['Message'];
      if (messageValue is String) {
        String downloadUrl = messageValue;
        String finalUrl = '${ApiConstants.baseDocUrl}$downloadUrl';
        print('file url $finalUrl');
        await downloadImage(finalUrl, imageName, msgId, msgType);
      } else {
        throw Exception('Invalid message value: $messageValue');
      }
    } else {
      throw Exception('Failed to fetch download URL');
    }
  } catch (e) {
    rethrow;
  }
  return true;
}

Future<String> downloadImage(
    String url, String filename, msgId, msgType) async {
  Directory directory = await getApplicationDocumentsDirectory();
  String path = directory.path;
  String filePath = '$path/$filename';
  print('msg type $msgType');
  Dio dio = Dio();

  try {
    await dio.download(url, filePath, onReceiveProgress: (received, total) {
      if (total != -1) {}
    });
    final DatabaseHelper databaseHelper = getIt<DatabaseHelper>();
    switch (msgType) {
      case '2':
        await databaseHelper.updateLocalImagePath(msgId, filePath);
        break;
      case '3':
        filePath = url;
        await databaseHelper.updateLocalImagePath(msgId, filePath);
        break;
      case '4':
        filePath = url;
        await databaseHelper.updateLocalImagePath(msgId, filePath);
        break;
    }
    print('file path $filePath');
  } catch (e) {
    rethrow;
  }

  return filePath;
}
