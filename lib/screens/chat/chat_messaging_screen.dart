import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toolkit/blocs/chat/chat_bloc.dart';
import 'package:toolkit/blocs/chat/chat_event.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/di/app_module.dart';
import 'package:toolkit/screens/chat/widgets/chat_data_model.dart';
import 'package:toolkit/screens/chat/widgets/chat_gallery_media_alert_dialog.dart';
import 'package:toolkit/screens/chat/widgets/media_options_widget.dart';
import 'package:toolkit/screens/chat/widgets/media_type_util.dart';
import 'package:toolkit/widgets/custom_icon_button.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/secondary_button.dart';

class ChatMessagingScreen extends StatefulWidget {
  static const routeName = 'NewChatScreen';

  const ChatMessagingScreen({super.key});

  @override
  State<ChatMessagingScreen> createState() => _ChatMessagingScreenState();
}

class _ChatMessagingScreenState extends State<ChatMessagingScreen> {
  final ChatData chatData = getIt<ChatData>();

  void _handleMessage(String text, BuildContext context) {
    if (text.isEmpty) return;
    context.read<ChatBloc>().messagesList.insert(0, {'msg': text});
  }

  @override
  void initState() {
    context.read<ChatBloc>().chatDetailsMap['isMedia'] = false;
    context.read<ChatBloc>().add(RebuildChatMessagingScreen(
        employeeDetailsMap: context.read<ChatBloc>().chatDetailsMap));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GenericAppBar(
            title:
                context.read<ChatBloc>().chatDetailsMap['employee_name'] ?? ''),
        body: StreamBuilder<List<Map<String, dynamic>>>(
            stream: context.read<ChatBloc>().messageStream,
            builder: (context, snapshot) {
              if (context.read<ChatBloc>().chatDetailsMap['isMedia'] == false) {
                if (snapshot.hasData) {
                  return Column(children: <Widget>[
                    Flexible(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        reverse: true,
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, chatIndex) {
                          DateTime dateTime = DateTime.parse(
                              snapshot.data?[chatIndex]['msg_time']);
                          String formattedTime =
                              DateFormat('h:mm a').format(dateTime);
                          return ChatMessage(
                            chatMap: {
                              'message': snapshot.data?[chatIndex]['msg'] ?? '',
                              'is_me':
                                  snapshot.data?[chatIndex]['isReceiver'] ?? 0,
                              'message_type':
                                  snapshot.data?[chatIndex]['msg_type'] ?? '',
                              'time': formattedTime,
                              'image': snapshot.data?[chatIndex]
                                      ['serverImagePath'] ??
                                  '',
                              'picked_image': snapshot.data?[chatIndex]
                                      ['pickedMedia'] ??
                                  '',
                              'msg_id':
                                  snapshot.data?[chatIndex]['msg_id'] ?? '',
                              'is_downloaded': snapshot.data?[chatIndex]
                                      ['isDownloadedImage'] ??
                                  0,
                              'local_image': snapshot.data?[chatIndex]
                                      ['localImagePath'] ??
                                  ''
                            },
                          );
                        },
                      ),
                    ),
                    const Divider(height: kChatScreenDividerHeight),
                    Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                        ),
                        child: _buildTextComposer(context))
                  ]);
                } else {
                  return const SizedBox.shrink();
                }
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: xxxTinySpacing, horizontal: xxTinierSpacing),
                  child: Column(
                    children: [
                      MediaTypeUtil().showMediaWidget(
                          context.read<ChatBloc>().chatDetailsMap['mediaType'],
                          {'file': chatData.fileName},
                          context),
                      const SizedBox(height: tinySpacing),
                      Row(
                        children: [
                          Expanded(
                              child: SecondaryButton(
                                  onPressed: () {
                                    setState(() {
                                      context
                                          .read<ChatBloc>()
                                          .chatDetailsMap['isMedia'] = false;
                                      context.read<ChatBloc>().add(
                                          RebuildChatMessagingScreen(
                                              employeeDetailsMap: context
                                                  .read<ChatBloc>()
                                                  .chatDetailsMap));
                                    });
                                  },
                                  textValue: 'Remove')),
                          const SizedBox(width: xxTinierSpacing),
                          Expanded(
                              child: SecondaryButton(
                                  onPressed: () {
                                    context
                                        .read<ChatBloc>()
                                        .chatDetailsMap['isMedia'] = false;
                                    _handleMessage(
                                        context
                                            .read<ChatBloc>()
                                            .chatDetailsMap['message'],
                                        context);
                                    context.read<ChatBloc>().add(
                                        SendChatMessage(
                                            sendMessageMap: context
                                                .read<ChatBloc>()
                                                .chatDetailsMap));
                                  },
                                  textValue: 'Send')),
                        ],
                      )
                    ],
                  ),
                );
              }
            }));
  }

  Widget _buildTextComposer(BuildContext context) {
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
                      _handleMessage(textEditingController.text, context);
                      context.read<ChatBloc>().chatDetailsMap['message_type'] =
                          '1';
                      context.read<ChatBloc>().add(SendChatMessage(
                          sendMessageMap:
                              context.read<ChatBloc>().chatDetailsMap));
                    }
                  }),
            ])));
  }
}

class TrianglePainter extends CustomPainter {
  final int isMe;

  TrianglePainter({required this.isMe});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = AppColor.offWhite;
    Path path = Path();
    if (isMe == 0) {
      path.moveTo(size.width, size.height);
      path.lineTo(size.width - 15, size.height);
      path.lineTo(size.width, size.height + 15);
      path.close();
    } else {
      path.moveTo(0, size.height);
      path.lineTo(15, size.height);
      path.lineTo(0, size.height + 15);
      path.close();
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class ChatMessage extends StatelessWidget {
  final Map chatMap;

  const ChatMessage({super.key, required this.chatMap});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: xxxSmallestSpacing),
        child: Row(
            mainAxisAlignment: (chatMap['is_me'] == 0)
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(xxTinierSpacing),
                  child: Column(
                      crossAxisAlignment: (chatMap['is_me'] == 0)
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(xxxTinySpacing),
                          constraints: BoxConstraints(
                              maxWidth: MediaQuery.sizeOf(context).width / 2),
                          decoration: BoxDecoration(
                            color: (chatMap['is_me'] == 0)
                                ? AppColor.lightBlueGrey
                                : AppColor.blueishGrey,
                            borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(tinierSpacing),
                                topRight: const Radius.circular(tinierSpacing),
                                bottomLeft: (chatMap['is_me'] == 0)
                                    ? const Radius.circular(tinierSpacing)
                                    : const Radius.circular(0),
                                bottomRight: (chatMap['is_me'] == 0)
                                    ? const Radius.circular(0)
                                    : const Radius.circular(tinierSpacing)),
                          ),
                          child: MediaTypeUtil().processMessage(
                              chatMap['message_type'],
                              {
                                'file': chatMap['message'],
                                'picked_image': chatMap['picked_image'],
                                'server_image': chatMap['image'],
                                'msg_id': chatMap['msg_id'],
                                'is_downloaded': chatMap['is_downloaded'],
                                'local_image': chatMap['local_image']
                              },
                              context,
                              isMe: chatMap['is_me'],
                              height: 150,
                              width: 200),
                        ),
                        if (chatMap['is_me'] == 0)
                          CustomPaint(
                              painter: TrianglePainter(isMe: chatMap['is_me'])),
                        const SizedBox(height: xxxTinierSpacing),
                        Text(chatMap['time'],
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.smallTextBlack)
                      ]))
            ]));
  }
}
