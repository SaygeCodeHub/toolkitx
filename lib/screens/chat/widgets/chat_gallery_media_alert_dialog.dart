import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/chat/chat_bloc.dart';
import 'package:toolkit/blocs/chat/chat_event.dart';
import 'package:toolkit/di/app_module.dart';
import 'package:toolkit/screens/chat/widgets/chat_data_model.dart';
import 'package:toolkit/screens/chat/widgets/media_alert_dialog.dart';
import 'package:toolkit/screens/chat/widgets/media_options_widget.dart';

import '../../../configs/app_color.dart';

class ChatGalleryMediaAlertDialog extends StatelessWidget {
  final ChatData chatData = getIt<ChatData>();

  ChatGalleryMediaAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaAlertDialog(
      mediaList: List.generate(
          chatData.mediaTypes().length,
          (typeIndex) => Material(
                color: AppColor.white,
                child: MediaOptionsWidget(
                  onMediaSelected: () {
                    switch (chatData.mediaTypes()[typeIndex].optionName) {
                      case 'Image':
                        context.read<ChatBloc>().chatDetailsMap['mediaType'] =
                            chatData.mediaTypes()[typeIndex].optionName;
                        context
                            .read<ChatBloc>()
                            .chatDetailsMap['message_type'] = '2';
                        if (context
                                .read<ChatBloc>()
                                .chatDetailsMap['selectedMedia'] ==
                            'Gallery') {
                          context.read<ChatBloc>().isCameraImage = false;
                          context.read<ChatBloc>().add(PickMedia(
                              mediaDetailsMap:
                                  context.read<ChatBloc>().chatDetailsMap));
                        } else {
                          context.read<ChatBloc>().isCameraImage = true;
                          context.read<ChatBloc>().add(PickMedia(
                              mediaDetailsMap:
                                  context.read<ChatBloc>().chatDetailsMap));
                        }
                        Navigator.pop(context);
                        break;
                      case 'Video':
                        context.read<ChatBloc>().chatDetailsMap['mediaType'] =
                            chatData.mediaTypes()[typeIndex].optionName;
                        context
                            .read<ChatBloc>()
                            .chatDetailsMap['message_type'] = '3';
                        if (context
                                .read<ChatBloc>()
                                .chatDetailsMap['selectedMedia'] ==
                            'Gallery') {
                          context.read<ChatBloc>().isCameraVideo = false;
                          context.read<ChatBloc>().add(PickMedia(
                              mediaDetailsMap:
                                  context.read<ChatBloc>().chatDetailsMap));
                        } else {
                          context.read<ChatBloc>().isCameraVideo = true;
                          context.read<ChatBloc>().add(PickMedia(
                              mediaDetailsMap:
                                  context.read<ChatBloc>().chatDetailsMap));
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
    );
  }
}
