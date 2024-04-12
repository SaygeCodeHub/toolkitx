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
  static Map<String, dynamic> chatDetailsMap = {};

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
    ChatMessagingScreen.chatDetailsMap['isMedia'] = false;
    context.read<ChatBloc>().add(RebuildChatMessagingScreen(
        employeeDetailsMap: ChatMessagingScreen.chatDetailsMap));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GenericAppBar(
            title: ChatMessagingScreen.chatDetailsMap['employee_name'] ?? ''),
        body: StreamBuilder<List<Map<String, dynamic>>>(
            stream: context.read<ChatBloc>().messageStream,
            builder: (context, snapshot) {
              if (ChatMessagingScreen.chatDetailsMap['isMedia'] == false) {
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
                              message: snapshot.data?[chatIndex]['msg'] ?? '',
                              isMe:
                                  snapshot.data?[chatIndex]['isReceiver'] ?? 0,
                              messageType: snapshot.data?[chatIndex]
                                      ['messageType'] ??
                                  '',
                              time: formattedTime);
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
                          ChatMessagingScreen.chatDetailsMap['mediaType'],
                          {'file': chatData.fileName},
                          context),
                      const SizedBox(height: tinySpacing),
                      Row(
                        children: [
                          Expanded(
                              child: SecondaryButton(
                                  onPressed: () {
                                    setState(() {
                                      ChatMessagingScreen
                                          .chatDetailsMap['isMedia'] = false;
                                      context.read<ChatBloc>().add(
                                          RebuildChatMessagingScreen(
                                              employeeDetailsMap:
                                                  ChatMessagingScreen
                                                      .chatDetailsMap));
                                    });
                                  },
                                  textValue: 'Remove')),
                          const SizedBox(width: xxTinierSpacing),
                          Expanded(
                              child: SecondaryButton(
                                  onPressed: () {
                                    ChatMessagingScreen
                                        .chatDetailsMap['isMedia'] = false;
                                    ChatMessagingScreen
                                            .chatDetailsMap['message'] =
                                        chatData.fileName;
                                    _handleMessage(
                                        ChatMessagingScreen
                                            .chatDetailsMap['message'],
                                        context);
                                    context.read<ChatBloc>().add(
                                        SendChatMessage(
                                            sendMessageMap: ChatMessagingScreen
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
                      ChatMessagingScreen.chatDetailsMap['message'] =
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
                                          ChatMessagingScreen.chatDetailsMap[
                                                  'selectedMedia'] =
                                              chatData
                                                  .mediaOptions()[index]
                                                  .optionName;
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return ChatGalleryMediaAlertDialog(
                                                    chatDetailsMap:
                                                        ChatMessagingScreen
                                                            .chatDetailsMap);
                                              });
                                          break;
                                        case 'Camera':
                                          Navigator.pop(context);
                                          ChatMessagingScreen.chatDetailsMap[
                                                  'selectedMedia'] =
                                              chatData
                                                  .mediaOptions()[index]
                                                  .optionName;
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return ChatGalleryMediaAlertDialog(
                                                    chatDetailsMap:
                                                        ChatMessagingScreen
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
                      context.read<ChatBloc>().add(SendChatMessage(
                          sendMessageMap: ChatMessagingScreen.chatDetailsMap));
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
  final String message;
  final int isMe;
  final String messageType;
  final String time;

  const ChatMessage(
      {super.key,
      required this.message,
      required this.isMe,
      required this.messageType,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: xxxSmallestSpacing),
        child: Row(
            mainAxisAlignment:
                (isMe == 0) ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(xxTinierSpacing),
                  child: Column(
                      crossAxisAlignment: (isMe == 0)
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(xxxTinySpacing),
                          constraints: BoxConstraints(
                              maxWidth: MediaQuery.sizeOf(context).width / 2),
                          decoration: BoxDecoration(
                            color: (isMe == 0)
                                ? AppColor.lightBlueGrey
                                : AppColor.blueishGrey,
                            borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(tinierSpacing),
                                topRight: const Radius.circular(tinierSpacing),
                                bottomLeft: (isMe == 0)
                                    ? const Radius.circular(tinierSpacing)
                                    : const Radius.circular(0),
                                bottomRight: (isMe == 0)
                                    ? const Radius.circular(0)
                                    : const Radius.circular(tinierSpacing)),
                          ),
                          child: MediaTypeUtil().showMediaWidget(
                              messageType, {'file': message}, context,
                              height: 100, width: 100),
                        ),
                        if (isMe == 0)
                          CustomPaint(painter: TrianglePainter(isMe: isMe)),
                        const SizedBox(height: xxxTinierSpacing),
                        Text(time,
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.smallTextBlack)
                      ]))
            ]));
  }
}
