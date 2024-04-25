import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/chat/widgets/attachment_msg_widget.dart';
import 'package:toolkit/screens/chat/widgets/attachment_preview_screen.dart';
import 'package:toolkit/screens/chat/widgets/chatbox_textfield_widget.dart';
import 'package:toolkit/screens/chat/widgets/date_divider_widget.dart';
import 'package:toolkit/screens/chat/widgets/msg_text_widget.dart';

import '../../blocs/chat/chat_bloc.dart';
import '../../blocs/chat/chat_event.dart';
import '../../blocs/chat/chat_state.dart';
import '../../configs/app_dimensions.dart';
import '../../widgets/generic_app_bar.dart';

class ChatMessagingScreen extends StatefulWidget {
  static const routeName = 'ChatMessagingScreen';

  const ChatMessagingScreen({super.key});

  @override
  State<ChatMessagingScreen> createState() => _ChatMessagingScreenState();
}

class _ChatMessagingScreenState extends State<ChatMessagingScreen> {
  @override
  void initState() {
    print('message screen ${context.read<ChatBloc>().chatDetailsMap}');
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
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
                stream: context.read<ChatBloc>().messageStream,
                builder: (context, snapshot) {
                  if (context.read<ChatBloc>().chatDetailsMap['isMedia'] ==
                      false) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final bool needDateDivider =
                              index == snapshot.data!.length - 1 ||
                                  _needDateDivider(index, snapshot);
                          return Column(
                            children: <Widget>[
                              if (needDateDivider)
                                Center(
                                  child: DateDividerWidget(
                                      snapshot: snapshot, reversedIndex: index),
                                ),
                              getWidgetBasedOnString(
                                  snapshot.data![index]['msg_type'],
                                  snapshot,
                                  index)
                            ],
                          );
                        },
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  } else {
                    return const AttachmentPreviewScreen();
                  }
                }),
          ),
          const Divider(height: kChatScreenDividerHeight),
          BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              if (state is ChatMessagingTextFieldHidden) {
                return const SizedBox.shrink();
              } else if (state is ShowChatMessagingTextField) {
                return Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                    ),
                    child: const ChatBoxTextFieldWidget());
              } else {
                return Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                    ),
                    child: const ChatBoxTextFieldWidget());
              }
            },
          )
        ],
      ),
    );
  }

  Widget getWidgetBasedOnString(msgType, snapshot, reversedIndex) {
    switch (msgType) {
      case '1':
        return MsgTextWidget(snapshot: snapshot, reversedIndex: reversedIndex);
      default:
        return AttachmentMsgWidget(
            snapshot: snapshot, reversedIndex: reversedIndex);
    }
  }

  bool _needDateDivider(
      int index, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
    if (index == 0) return false;
    DateTime currentDate =
        DateTime.parse(snapshot.data![index]['msg_time']).toLocal();
    DateTime previousDate =
        DateTime.parse(snapshot.data![index - 1]['msg_time']).toLocal();
    return currentDate.day != previousDate.day ||
        currentDate.month != previousDate.month ||
        currentDate.year != previousDate.year;
  }
}
