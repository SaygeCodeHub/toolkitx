import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/chat/chat_bloc.dart';
import 'package:toolkit/blocs/chat/chat_event.dart';
import 'package:toolkit/blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import 'package:toolkit/blocs/pickAndUploadImage/pick_and_upload_image_events.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/di/app_module.dart';
import 'package:toolkit/screens/chat/widgets/chat_data_model.dart';
import 'package:toolkit/widgets/custom_icon_button.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

class ChatMessagingScreen extends StatelessWidget {
  static const routeName = 'NewChatScreen';
  static Map<String, dynamic> employeeDetailsMap = {};
  final ChatData chatData = getIt<ChatData>();

  ChatMessagingScreen({super.key});

  void _handleMessage(String text, BuildContext context) {
    if (text.isEmpty) return;
    context.read<ChatBloc>().messagesList.insert(0, {'msg': text});
  }

  @override
  Widget build(BuildContext context) {
    context.read<ChatBloc>().add(
        RebuildChatMessagingScreen(employeeDetailsMap: employeeDetailsMap));
    return Scaffold(
        appBar: GenericAppBar(title: employeeDetailsMap['employee_name'] ?? ''),
        body: StreamBuilder<List<Map<String, dynamic>>>(
            stream: context.read<ChatBloc>().messageStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(children: <Widget>[
                  Flexible(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      reverse: true,
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return ChatMessage(
                            message: snapshot.data?[index]['msg'],
                            isMe: snapshot.data?[index]['isReceiver'] ?? 0);
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
                return const Text('No messages');
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
                child: TextField(
                  controller: textEditingController,
                  onChanged: (String text) {
                    textEditingController.text = text;
                    employeeDetailsMap['message'] = textEditingController.text;
                  },
                  decoration: const InputDecoration.collapsed(
                      hintText: 'Send a message'),
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
                              itemCount: chatData.attachementOptions().length,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        switch (chatData
                                            .attachementOptions()[index]
                                            .optionName) {
                                          case 'Gallery':
                                            context
                                                .read<PickAndUploadImageBloc>()
                                                .add(PickGalleryImage(
                                                    isImageAttached: null,
                                                    galleryImagesList: [],
                                                    isSignature: false,
                                                    editedGalleryList: []));
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(
                                            xxTinierSpacing),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: chatData
                                              .attachementOptions()[index]
                                              .color,
                                        ),
                                        child: Icon(
                                            chatData
                                                .attachementOptions()[index]
                                                .icon,
                                            color: AppColor.white),
                                      ),
                                    ),
                                    const SizedBox(height: xxTiniestSpacing),
                                    Text(
                                        chatData
                                            .attachementOptions()[index]
                                            .optionName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .xxSmall
                                            .copyWith(
                                                fontWeight: FontWeight.w500))
                                  ],
                                );
                              });
                        });
                  }),
              IconButton(
                  icon: const Icon(Icons.send_rounded),
                  onPressed: () {
                    _handleMessage(textEditingController.text, context);
                    context.read<ChatBloc>().add(
                        SendChatMessage(sendMessageMap: employeeDetailsMap));
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

  const ChatMessage({super.key, required this.message, required this.isMe});

  String getCurrentTime() {
    int hour = DateTime.now().hour;
    int minute = DateTime.now().minute;
    String currentTime = '$hour:$minute';
    return currentTime;
  }

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
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(xxxTinySpacing),
                          constraints: BoxConstraints(
                              maxWidth: MediaQuery.sizeOf(context).width / 2),
                          decoration: BoxDecoration(
                            color: AppColor.lightBlueGrey,
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
                          child: Text(
                            message,
                            style: Theme.of(context)
                                .textTheme
                                .xSmall
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                        if (isMe == 0)
                          CustomPaint(
                            painter: TrianglePainter(isMe: isMe),
                          ),
                        const SizedBox(height: xxxTinierSpacing),
                        Text(getCurrentTime(),
                            style: Theme.of(context).textTheme.smallTextBlack)
                      ]))
            ]));
  }
}
