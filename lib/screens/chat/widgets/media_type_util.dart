import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/di/app_module.dart';
import 'package:toolkit/utils/chat/chat_database_util.dart';
import 'package:toolkit/widgets/custom_icon_button.dart';
import '../../../configs/app_color.dart';
import 'package:http/http.dart' as http;

class MediaTypeUtil {
  Widget showMediaWidget(type, Map typeData, BuildContext context,
      {double? width, double? height, int? isMe}) {
    switch (type) {
      case 'Image':
        return Image.file(File(typeData['file'] ?? ''),
            width: width ?? 400, height: height ?? 650);
      case 'Video':
        return const Icon(Icons.video_collection);
      default:
        return Text(typeData['file'] ?? '',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(fontWeight: FontWeight.w500));
    }
  }

  Widget processMessage(
      type, Map<String, dynamic> messageMap, BuildContext context,
      {double? width, double? height, int? isMe}) {
    switch (type) {
      case '1':
        return Text(messageMap['file'] ?? '',
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(fontWeight: FontWeight.w500));
      case '2':
        if (isMe == 0) {
          return Image.file(File(messageMap['picked_image'] ?? ''),
              width: width ?? 400, height: height ?? 650);
        } else {
          if (messageMap['server_image'] != null &&
              messageMap['is_downloaded'] == 0) {
            return Container(
              height: 100,
              width: 400,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(messageMap['server_image']))),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    alignment: Alignment.center,
                    color: AppColor.grey.withOpacity(0.1),
                    child: CustomIconButton(
                        icon: Icons.download,
                        onPressed: () async {
                          await downloadImage(
                              "https://www.google.com/imgres?q=network%20image&imgurl=https%3A%2F%2Fwww.n-able.com%2Fwp-content%2Fuploads%2Fblog%2F2019%2F01%2Fwhatis.jpg&imgrefurl=https%3A%2F%2Fwww.n-able.com%2Fblog%2Fhow-to-design-a-network&docid=qddH7J9ITZk96M&tbnid=DE1D1cSBfv705M&vet=12ahUKEwjOhcjWvcaFAxXewzgGHc88AqAQM3oECGcQAA..i&w=720&h=356&hcb=2&ved=2ahUKEwjOhcjWvcaFAxXewzgGHc88AqAQM3oECGcQAA",
                              messageMap['msg_id'],
                              context);
                        }),
                  ),
                ),
              ),
            );
          } else {
            return Image.file(
              File(messageMap['local_image'] ?? ''),
              width: width ?? 400,
              height: height ?? 650,
              errorBuilder: (context, error, stackTrace) {
                print('Error loading image: $error');
                return const Icon(Icons.warning_amber);
              },
            );
          }
        }

      default:
        return const SizedBox.shrink();
    }
  }

  Future<void> downloadImage(
      String imageUrl, String msgId, BuildContext context) async {
    final DatabaseHelper databaseHelper = getIt<DatabaseHelper>();
    var response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      String downloadsDirectory = (await getExternalStorageDirectory())!.path;
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      String savePath = '$downloadsDirectory/$timestamp.jpg';
      File saveFile = File(savePath);
      await saveFile.writeAsBytes(response.bodyBytes);
      await databaseHelper.updateLocalImagePath(msgId, savePath);
      print('Image downloaded successfully at: $savePath');
    } else {
      print('Failed to download the image: ${response.statusCode}');
    }
  }
}
