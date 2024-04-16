import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/chat/chat_bloc.dart';
import '../../../blocs/chat/chat_event.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../di/app_module.dart';
import '../../../widgets/custom_icon_button.dart';
import 'chat_data_model.dart';
import 'chat_gallery_media_alert_dialog.dart';
import 'media_options_widget.dart';

class ChatboxTextfieldWidget extends StatelessWidget {
  const ChatboxTextfieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatData chatData = getIt<ChatData>();
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
                          textEditingController.text;
                    },
                    decoration: const InputDecoration.collapsed(
                        hintText: 'Send a message'),
                  ),
                ),
              ),
              CustomIconButton(
                  icon: Icons.attach_file,
                  onPressed: () {
                    showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        isScrollControlled: true,
                        context: (context),
                        builder: (context) {
                          return GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 200 / 350,
                                      crossAxisCount: 4,
                                      crossAxisSpacing: tinierSpacing,
                                      mainAxisSpacing: tinierSpacing),
                              itemCount: chatData.mediaOptions().length - 2,
                              itemBuilder: (context, index) {
                                return MediaOptionsWidget(
                                    onMediaSelected: () {
                                      switch (chatData
                                          .mediaOptions()[index]
                                          .optionName) {
                                        case 'Gallery':
                                          Navigator.pop(context);
                                          context
                                                      .read<ChatBloc>()
                                                      .chatDetailsMap[
                                                  'selectedMedia'] =
                                              chatData
                                                  .mediaOptions()[index]
                                                  .optionName;
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return ChatGalleryMediaAlertDialog(
                                                    chatDetailsMap: context
                                                        .read<ChatBloc>()
                                                        .chatDetailsMap);
                                              });
                                          break;
                                        case 'Camera':
                                          Navigator.pop(context);
                                          context
                                                      .read<ChatBloc>()
                                                      .chatDetailsMap[
                                                  'selectedMedia'] =
                                              chatData
                                                  .mediaOptions()[index]
                                                  .optionName;
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return ChatGalleryMediaAlertDialog(
                                                    chatDetailsMap: context
                                                        .read<ChatBloc>()
                                                        .chatDetailsMap);
                                              });
                                      }
                                    },
                                    mediaDataMap: {
                                      'color':
                                          chatData.mediaOptions()[index].color,
                                      'icon':
                                          chatData.mediaOptions()[index].icon,
                                      'media': chatData
                                          .mediaOptions()[index]
                                          .optionName
                                    });
                              });
                        });
                  }),
              IconButton(
                  icon: const Icon(Icons.send_rounded),
                  onPressed: () {
                    if (textEditingController.text.isNotEmpty) {
                      _handleMessage(
                          textEditingController.text.trim(), context);
                      context.read<ChatBloc>().chatDetailsMap['message_type'] =
                          '1';
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
