import 'dart:io';
import 'dart:ui' as ui;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/chat/widgets/quote_message_reply_container.dart';
import 'package:toolkit/utils/chat/attachement_msg_type_util.dart';
import 'package:toolkit/utils/constants/api_constants.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../../blocs/chat/chat_bloc.dart';
import '../../../blocs/chat/chat_event.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/cache/cache_keys.dart';
import '../../../data/cache/customer_cache.dart';
import '../../../di/app_module.dart';
import '../../../utils/database/database_util.dart';
import 'chat_subtitle.dart';

class AttachmentMsgWidget extends StatelessWidget {
  final Map messageData;

  const AttachmentMsgWidget({super.key, required this.messageData});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double margin = 0.0;
      if (messageData['quotemsg'] != "") {
        double textWidth = getTextWidth(
            context,
            (messageData['quotemsg'].toString().length >
                    messageData['msg'].toString().length)
                ? messageData['quotemsg'].toString()
                : messageData['msg'].toString());
        margin = (constraints.maxWidth - textWidth) / 2;
      }
      return Padding(
          padding: const EdgeInsets.only(
              right: kModuleImagePadding,
              left: kModuleImagePadding,
              bottom: kModuleImagePadding),
          child: Visibility(
              visible: (messageData['quotemsg'] != ""),
              replacement: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    (messageData['isReceiver'] == 1)
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: showDownloadedImage(
                                messageData['localImagePath'].toString(),
                                context,
                                messageData['msg_type'] ?? '',
                                messageData['isReceiver'],
                                messageData['msg'],
                                messageData['msg_status']))
                        : Align(
                            alignment: Alignment.centerRight,
                            child: showDownloadedImage(
                                messageData['pickedMedia'].toString(),
                                context,
                                messageData['msg_type'],
                                messageData['isReceiver'],
                                messageData['msg'],
                                messageData['msg_status'])),
                    ChatSubtitle(messageData: messageData)
                  ]),
              child: Column(
                children: [
                  Align(
                      alignment: (messageData['isReceiver'] == 1)
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Container(
                          decoration: BoxDecoration(
                              color: (messageData['isReceiver'] == 1)
                                  ? AppColor.blueGrey
                                  : Colors.grey[300],
                              borderRadius:
                                  BorderRadius.circular(xxxTinierSpacing)),
                          margin: (messageData['isReceiver'] == 1)
                              ? EdgeInsets.only(right: margin)
                              : EdgeInsets.only(left: margin),
                          child: Column(children: [
                            QuoteMessageReplyContainer(
                                messageData: messageData),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: xxxTinierSpacing,
                                    vertical: kQuoteMessageTilePadding),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: SelectionArea(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                          (messageData['isReceiver'] == 1)
                                              ? Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: showDownloadedImage(
                                                      messageData[
                                                              'localImagePath']
                                                          .toString(),
                                                      context,
                                                      messageData['msg_type'] ??
                                                          '',
                                                      messageData['isReceiver'],
                                                      messageData['msg'],
                                                      messageData[
                                                          'msg_status']))
                                              : Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: showDownloadedImage(
                                                      messageData['pickedMedia']
                                                          .toString(),
                                                      context,
                                                      messageData['msg_type'],
                                                      messageData['isReceiver'],
                                                      messageData['msg'],
                                                      messageData[
                                                          'msg_status'])),
                                        ]))))
                          ]))),
                  ChatSubtitle(messageData: messageData)
                ],
              )));
    });
  }

  Widget showDownloadedImage(String attachmentPath, BuildContext context,
      String type, int isReceiver, String fileName, String msgStatus) {
    return (attachmentPath.toString() != 'null')
        ? SizedBox(
            width: kChatImageSize,
            height: kChatImageSize,
            child: AttachementMsgTypeUtil().renderWidget(
                type, attachmentPath, context, isReceiver, fileName, msgStatus))
        : Container(
            width: kChatImageSize,
            height: kChatImageSize,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(kRadius)),
            child: Stack(children: [
              Center(
                  child: IconButton(
                      icon: const Center(child: Icon(Icons.download)),
                      onPressed: () async {
                        ProgressBar.show(context);
                        final CustomerCache customerCache =
                            getIt<CustomerCache>();
                        String? hashCode =
                            await customerCache.getHashCode(CacheKeys.hashcode);
                        String url =
                            '${ApiConstants.baseUrl}${ApiConstants.chatDocBaseUrl}${messageData['msg'].toString()}&hashcode=$hashCode';
                        DateTime imageName = DateTime.now();
                        String attachmentExtension =
                            getFileName(messageData['msg'].toString());
                        bool downloadProcessComplete =
                            await downloadFileFromUrl(
                                url,
                                "$imageName.$attachmentExtension",
                                messageData['msg_id'],
                                messageData['msg_type']);
                        if (downloadProcessComplete) {
                          if (!context.mounted) return;
                          ProgressBar.dismiss(context);
                          context.read<ChatBloc>().add(
                              RebuildChatMessagingScreen(
                                  employeeDetailsMap:
                                      context.read<ChatBloc>().chatDetailsMap));
                        }
                      })),
              Padding(
                  padding: const EdgeInsets.all(xxTiniestSpacing),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: (msgStatus != '1')
                          ? const Icon(Icons.timer,
                              size: kDownloadImageIconSize,
                              color: AppColor.greyBlack)
                          : const SizedBox.shrink()))
            ]));
  }
}

double getTextWidth(BuildContext context, String text) {
  TextPainter textPainter = TextPainter();
  if (text.length < 35) {
    textPainter = TextPainter(
        text: TextSpan(text: text, style: Theme.of(context).textTheme.small),
        textDirection: ui.TextDirection.ltr);
  } else {
    textPainter = TextPainter(
        text: TextSpan(
            text: text.substring(0, 35),
            style: Theme.of(context).textTheme.small),
        textDirection: ui.TextDirection.ltr);
  }
  textPainter.layout();
  return textPainter.width;
}

String getFileName(String filePath) {
  return filePath.split('/').last;
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
  Directory directory = await getApplicationCacheDirectory();
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
