import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/chat/widgets/choose_media_widget.dart';

import '../../../blocs/chat/chat_bloc.dart';
import '../../../blocs/chat/chat_event.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';

class ChatBoxTextFieldWidget extends StatelessWidget {
  const ChatBoxTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textEditingController = TextEditingController();

    return IconTheme(
        data: const IconThemeData(color: AppColor.deepBlue),
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: xxxTinierSpacing),
            child: Row(children: <Widget>[
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: textEditingController,
                    maxLines: 2,
                    onChanged: (String text) {
                      textEditingController.text = text;
                      context.read<ChatBloc>().chatDetailsMap['message'] =
                          textEditingController.text.trim();
                    },
                    decoration: const InputDecoration.collapsed(
                        hintText: 'Send a message'),
                  ),
                ),
              ),
              ChooseMediaWidget(),
              IconButton(
                  icon: const Icon(Icons.send_rounded),
                  onPressed: () {
                    if (textEditingController.text.trim().isNotEmpty) {
                      _handleMessage(
                          textEditingController.text.trim(), context);
                      context.read<ChatBloc>().chatDetailsMap['message_type'] =
                          '1';
                      print(
                          'on tap of send${context.read<ChatBloc>().chatDetailsMap}');
                      context.read<ChatBloc>().add(SendChatMessage(
                          sendMessageMap:
                              context.read<ChatBloc>().chatDetailsMap));
                    }
                    textEditingController.clear();
                  }),
            ])));
  }

  void _handleMessage(String text, BuildContext context) {
    if (text.isEmpty) return;
    context.read<ChatBloc>().messagesList.insert(0, {'msg': text});
  }
}
