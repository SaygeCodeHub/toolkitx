import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/screens/chat/widgets/choose_media_widget.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../blocs/chat/chat_bloc.dart';
import '../../../blocs/chat/chat_event.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';

class ChatBoxTextFieldWidget extends StatefulWidget {
  final String replyToMessage;
  final FocusNode? focusNode;

  const ChatBoxTextFieldWidget({
    super.key,
    required this.replyToMessage,
    required this.focusNode,
  });

  @override
  State<ChatBoxTextFieldWidget> createState() => _ChatBoxTextFieldWidgetState();
}

class _ChatBoxTextFieldWidgetState extends State<ChatBoxTextFieldWidget> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.replyToMessage.isNotEmpty || widget.replyToMessage != '') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.focusNode?.requestFocus();
      });
    }
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconTheme(
        data: const IconThemeData(color: AppColor.deepBlue),
        child: Column(children: [
          if (widget.replyToMessage.isNotEmpty)
            Container(
                padding: const EdgeInsets.all(tiniestSpacing),
                color: Colors.grey[200],
                child: Row(children: [
                  const Icon(Icons.reply, size: kMessageReplyIconSize),
                  const SizedBox(width: xxxTinierSpacing),
                  Expanded(
                      child: Text(widget.replyToMessage,
                          overflow: TextOverflow.ellipsis)),
                  IconButton(
                      icon: const Icon(Icons.close,
                          size: kCancelMessageReplyIconSize),
                      onPressed: () {
                        context
                            .read<ChatBloc>()
                            .add(ReplyToMessage(replyToMessage: ''));
                      })
                ])),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: xxxTinierSpacing),
              child: Row(children: [
                Flexible(
                    child: Padding(
                        padding: const EdgeInsets.all(xxTinierSpacing),
                        child: TextField(
                            focusNode: widget.focusNode,
                            controller: textEditingController,
                            maxLines: 2,
                            onChanged: (String text) {
                              context
                                  .read<ChatBloc>()
                                  .chatDetailsMap['message'] = text.trim();
                            },
                            decoration: const InputDecoration.collapsed(
                                hintText: StringConstants.kSendMessage)))),
                ChooseMediaWidget(),
                IconButton(
                    icon: const Icon(Icons.send_rounded),
                    onPressed: () {
                      if (textEditingController.text.trim().isNotEmpty) {
                        _handleMessage(
                            textEditingController.text.trim(), context);
                        context
                            .read<ChatBloc>()
                            .chatDetailsMap['message_type'] = '1';
                        context.read<ChatBloc>().add(SendChatMessage(
                              sendMessageMap:
                                  context.read<ChatBloc>().chatDetailsMap,
                            ));
                      }
                      textEditingController.clear();
                      context
                          .read<ChatBloc>()
                          .add(ReplyToMessage(replyToMessage: ''));
                    })
              ]))
        ]));
  }

  void _handleMessage(String text, BuildContext context) {
    if (text.isEmpty) return;
    context.read<ChatBloc>().messagesList.insert(0, {'msg': text});
  }
}
