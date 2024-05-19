import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
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
  final dynamic snapShot;
  final int reversedIndex;

  const AttachmentMsgWidget(
      {super.key, required this.snapShot, required this.reversedIndex});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          right: kModuleImagePadding,
          left: kModuleImagePadding,
          bottom: kModuleImagePadding),
      child: Column(
        children: [
          (snapShot.data![reversedIndex]['isReceiver'] == 1)
              ? Align(
                  alignment: Alignment.centerLeft,
                  child: showDownloadedImage(
                      snapShot.data![reversedIndex]['localImagePath']
                          .toString(),
                      context,
                      snapShot.data![reversedIndex]['msg_type'] ?? '',
                      snapShot.data![reversedIndex]['isReceiver']))
              : Align(
                  alignment: Alignment.centerRight,
                  child: showDownloadedImage(
                      snapShot.data![reversedIndex]['pickedMedia'].toString(),
                      context,
                      snapShot.data![reversedIndex]['msg_type'],
                      snapShot.data![reversedIndex]['isReceiver'])),
          Align(
            alignment: (snapShot.data![reversedIndex]['isReceiver'] == 1)
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(tiniestSpacing),
              child: Text(
                  DateFormat('h:mm a').format(DateTime.parse(
                      getTimeForUserTimeZone(context,
                              snapShot.data?[reversedIndex]['msg_time'])
                          .toString())),
                  style: Theme.of(context).textTheme.smallTextBlack),
            ),
          ),
        ],
      ),
    );
  }

  DateTime getTimeForUserTimeZone(BuildContext context, String time) {
    DateTime dateTime = DateTime.parse(time);
    List offset = context
        .read<ChatBloc>()
        .timeZoneFormat
        .replaceAll('+', '')
        .replaceAll('-', '')
        .split(':');
    if (context.read<ChatBloc>().timeZoneFormat.contains('+')) {
      dateTime = dateTime.toUtc().add(Duration(
          hours: int.parse(offset[0]), minutes: int.parse(offset[1].trim())));
      return dateTime;
    } else {
      dateTime = dateTime.toUtc().subtract(Duration(
          hours: int.parse(offset[0]), minutes: int.parse(offset[1].trim())));
      return dateTime;
    }
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
                icon: const Center(child: Icon(Icons.download)),
                onPressed: () async {
                  ProgressBar.show(context);
                  final CustomerCache customerCache = getIt<CustomerCache>();
                  String? hashCode =
                      await customerCache.getHashCode(CacheKeys.hashcode);
                  String url =
                      '${ApiConstants.baseUrl}${ApiConstants.chatDocBaseUrl}${snapShot.data![reversedIndex]['msg'].toString()}&hashcode=$hashCode';
                  DateTime imageName = DateTime.now();
                  bool downloadProcessComplete = await downloadFileFromUrl(
                      url,
                      (snapShot.data![reversedIndex]['msg_type'] == '4')
                          ? "$imageName.${snapShot.data![reversedIndex]['attachementExtension']}"
                          : "$imageName.jpg",
                      snapShot.data![reversedIndex]['msg_id'],
                      snapShot.data![reversedIndex]['msg_type']);
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
