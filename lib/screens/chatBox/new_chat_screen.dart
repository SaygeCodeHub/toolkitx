import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/chatBox/chat_box_bloc.dart';
import 'package:toolkit/blocs/chatBox/chat_box_event.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

class NewChatScreen extends StatelessWidget {
  static const routeName = 'NewChatScreen';
  static Map<String, dynamic> employeeDetailsMap = {};

  const NewChatScreen({super.key});

  void _handleMessage(String text, BuildContext context) {
    if (text.isEmpty) return;
    context.read<ChatBoxBloc>().messagesList.insert(0, {'msg': text});
  }

  @override
  Widget build(BuildContext context) {
    final chatBoxBloc = BlocProvider.of<ChatBoxBloc>(context);
    chatBoxBloc.add(RebuildChat(employeeDetailsMap: employeeDetailsMap));
    return Scaffold(
        appBar: GenericAppBar(title: employeeDetailsMap['employee_name'] ?? ''),
        body: StreamBuilder<List<Map<String, dynamic>>>(
            stream: chatBoxBloc.messageStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(children: <Widget>[
                  Flexible(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      reverse: true,
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) =>
                          ChatMessage(message: snapshot.data?[index]['msg']),
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
              IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    _handleMessage(textEditingController.text, context);
                    context
                        .read<ChatBoxBloc>()
                        .add(SendMessage(sendMessageMap: employeeDetailsMap));
                  }),
            ])));
  }
}

class TrianglePainter extends CustomPainter {
  final bool isMe;

  TrianglePainter({required this.isMe});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = AppColor.offWhite;
    Path path = Path();
    if (isMe) {
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
  final bool isMe;

  const ChatMessage({super.key, required this.message, this.isMe = true});

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
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
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
                            bottomLeft: isMe
                                ? const Radius.circular(tinierSpacing)
                                : const Radius.circular(0),
                            bottomRight: isMe
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
                    if (!isMe)
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
