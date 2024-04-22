import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/chat/chat_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/di/app_module.dart';
import 'package:toolkit/screens/chat/widgets/chat_data_model.dart';
import 'package:toolkit/screens/chat/widgets/chat_gallery_media_alert_dialog.dart';
import 'package:toolkit/screens/chat/widgets/document_media_widget.dart';
import 'package:toolkit/screens/chat/widgets/media_options_widget.dart';
import 'package:toolkit/widgets/custom_icon_button.dart';

class ChooseMediaWidget extends StatelessWidget {
  final ChatData chatData = getIt<ChatData>();

  ChooseMediaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    print('hello');
    return CustomIconButton(
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
                            childAspectRatio: 350 / 300,
                            crossAxisCount: 3,
                            crossAxisSpacing: tinierSpacing,
                            mainAxisSpacing: tinierSpacing),
                    itemCount: chatData.mediaOptions().length - 2,
                    itemBuilder: (context, index) {
                      return MediaOptionsWidget(
                          onMediaSelected: () {
                            switch (chatData.mediaOptions()[index].optionName) {
                              case 'Gallery':
                                Navigator.pop(context);
                                context
                                        .read<ChatBloc>()
                                        .chatDetailsMap['selectedMedia'] =
                                    chatData.mediaOptions()[index].optionName;
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
                                        .chatDetailsMap['selectedMedia'] =
                                    chatData.mediaOptions()[index].optionName;
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return ChatGalleryMediaAlertDialog(
                                          chatDetailsMap: context
                                              .read<ChatBloc>()
                                              .chatDetailsMap);
                                    });
                                break;
                              case 'Document':
                                Navigator.pop(context);
                                context
                                        .read<ChatBloc>()
                                        .chatDetailsMap['selectedMedia'] =
                                    chatData.mediaOptions()[index].optionName;
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const DocumentMediaWidget();
                                    });
                                break;
                            }
                          },
                          mediaDataMap: {
                            'color': chatData.mediaOptions()[index].color,
                            'icon': chatData.mediaOptions()[index].icon,
                            'media': chatData.mediaOptions()[index].optionName
                          });
                    });
              });
        });
  }
}
