import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_snackbar.dart';
import 'attachment_msg_widget.dart';
import 'msg_text_widget.dart';

class MessageTile extends StatelessWidget {
  final Map<String, dynamic> messageData;

  final Function(String) onReply;

  const MessageTile(
      {super.key, required this.onReply, required this.messageData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPress: () {
          if (messageData['msg_type']) {
            Clipboard.setData(ClipboardData(text: messageData['msg']));
            showCustomSnackBar(
                context, StringConstants.kMsgCopyToClipboard, '');
          }
        },
        onHorizontalDragEnd: (details) {
          String quoteMsg = '';
          switch (messageData['msg_type']) {
            case '1':
              quoteMsg = messageData["msg"].toString();
              break;
            case '2':
              quoteMsg = "Image";
              break;
            case '3':
              quoteMsg = "Video";
              break;
            case '4':
              quoteMsg = "Docs";
              break;
          }
          if (messageData['isReceiver'] == 1 && details.primaryVelocity! > 0) {
            onReply(quoteMsg);
          } else if (messageData['isReceiver'] != 1 &&
              details.primaryVelocity! < 0) {
            onReply(quoteMsg);
          }
        },
        child: getWidgetBasedOnString(messageData['msg_type'], messageData));
  }

  Widget getWidgetBasedOnString(msgType, messageData) {
    switch (msgType) {
      case '1':
        return MsgTextWidget(messageData: messageData);
      default:
        return AttachmentMsgWidget(messageData: messageData);
    }
  }
}
