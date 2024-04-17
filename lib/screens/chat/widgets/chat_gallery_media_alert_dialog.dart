import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/chat/chat_bloc.dart';
import 'package:toolkit/blocs/chat/chat_event.dart';
import 'package:toolkit/di/app_module.dart';
import 'package:toolkit/screens/chat/widgets/chat_data_model.dart';
import 'package:toolkit/screens/chat/widgets/media_options_widget.dart';

class ChatGalleryMediaAlertDialog extends StatelessWidget {
  final Map chatDetailsMap;
  final ChatData chatData = getIt<ChatData>();

  ChatGalleryMediaAlertDialog({super.key, required this.chatDetailsMap});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(vertical: 200, horizontal: 90),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
            chatData.mediaTypes().length,
            (typeIndex) => Material(
                  child: MediaOptionsWidget(
                    onMediaSelected: () {
                      switch (chatData.mediaTypes()[typeIndex].optionName) {
                        case 'Image':
                          chatDetailsMap['isMedia'] = true;
                          chatDetailsMap['mediaType'] =
                              chatData.mediaTypes()[typeIndex].optionName;
                          chatDetailsMap['message_type'] = '2';
                          if (chatDetailsMap['selectedMedia'] == 'Gallery') {
                            context.read<ChatBloc>().isCameraImage = false;
                            context.read<ChatBloc>().add(
                                PickMedia(mediaDetailsMap: chatDetailsMap));
                          } else {
                            context.read<ChatBloc>().isCameraImage = true;
                            context.read<ChatBloc>().add(
                                PickMedia(mediaDetailsMap: chatDetailsMap));
                          }
                          Navigator.pop(context);
                          break;
                        case 'Video':
                          chatDetailsMap['isMedia'] = true;
                          chatDetailsMap['mediaType'] =
                              chatData.mediaTypes()[typeIndex].optionName;
                          chatDetailsMap['message_type'] = '3';
                          if (chatDetailsMap['selectedMedia'] == 'Gallery') {
                            context.read<ChatBloc>().isCameraVideo = false;
                            context.read<ChatBloc>().add(
                                PickMedia(mediaDetailsMap: chatDetailsMap));
                          } else {
                            context.read<ChatBloc>().isCameraVideo = true;
                            context.read<ChatBloc>().add(
                                PickMedia(mediaDetailsMap: chatDetailsMap));
                          }
                          Navigator.pop(context);
                          break;
                      }
                    },
                    mediaDataMap: {
                      'color': chatData.mediaTypes()[typeIndex].color,
                      'icon': chatData.mediaTypes()[typeIndex].icon,
                      'media': chatData.mediaTypes()[typeIndex].optionName
                    },
                  ),
                )),
      ),
    );
  }
}
