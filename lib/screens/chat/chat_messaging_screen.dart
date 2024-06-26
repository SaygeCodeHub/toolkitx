import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/chat/all_chats_screen.dart';
import 'package:toolkit/screens/chat/widgets/attachment_msg_widget.dart';
import 'package:toolkit/screens/chat/widgets/attachment_preview_screen.dart';
import 'package:toolkit/screens/chat/widgets/chatbox_textfield_widget.dart';
import 'package:toolkit/screens/chat/widgets/date_divider_widget.dart';
import 'package:toolkit/screens/chat/widgets/msg_text_widget.dart';
import 'package:toolkit/utils/global.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../blocs/chat/chat_bloc.dart';
import '../../blocs/chat/chat_event.dart';
import '../../blocs/chat/chat_state.dart';
import '../../configs/app_color.dart';
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
    context.read<ChatBloc>().chatDetailsMap['isMedia'] = false;
    context.read<ChatBloc>().add(RebuildChatMessagingScreen(
        employeeDetailsMap: context.read<ChatBloc>().chatDetailsMap));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (pop) {
        chatScreenName = AllChatsScreen.routeName;
      },
      child: Scaffold(
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
                                        snapshot: snapshot,
                                        reversedIndex: index),
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
                    } else if (context
                            .read<ChatBloc>()
                            .chatDetailsMap['isUploadComplete'] ==
                        false) {
                      if (context.read<ChatBloc>().chatDetailsMap['file_size'] >
                          20) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: Text(
                                    'Cannot upload attachement more than 20 mb!',
                                    style: Theme.of(context)
                                        .textTheme
                                        .xSmall
                                        .copyWith(color: AppColor.black))),
                          ],
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircularProgressIndicator(),
                            const SizedBox(height: tiniestSpacing),
                            Center(
                                child: Text(
                                    'Uploading attachment, please wait!',
                                    style: Theme.of(context)
                                        .textTheme
                                        .xSmall
                                        .copyWith(color: AppColor.grey))),
                          ],
                        );
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
                  return Padding(
                    padding: const EdgeInsets.all(xxTinierSpacing),
                    child: Row(
                      children: [
                        Expanded(
                            child: PrimaryButton(
                                onPressed: () {
                                  context
                                      .read<ChatBloc>()
                                      .chatDetailsMap['isMedia'] = false;
                                  context
                                      .read<ChatBloc>()
                                      .chatDetailsMap['message'] = '';
                                  context.read<ChatBloc>().add(
                                      RebuildChatMessagingScreen(
                                          employeeDetailsMap: context
                                              .read<ChatBloc>()
                                              .chatDetailsMap));
                                },
                                textValue:
                                    (context.read<ChatBloc>().chatDetailsMap[
                                                'isUploadComplete'] ==
                                            true)
                                        ? 'Remove'
                                        : 'Back')),
                        const SizedBox(width: xxTinierSpacing),
                        Expanded(
                            child: PrimaryButton(
                                onPressed: (context
                                                .read<ChatBloc>()
                                                .chatDetailsMap[
                                            'isUploadComplete'] ==
                                        true)
                                    ? () {
                                        if (context
                                                    .read<ChatBloc>()
                                                    .chatDetailsMap['message']
                                                    .toString() ==
                                                '' ||
                                            context
                                                        .read<ChatBloc>()
                                                        .chatDetailsMap[
                                                    'message'] ==
                                                null) {
                                          showCustomSnackBar(
                                              context,
                                              'Something went wrong. Please try again later!',
                                              '');
                                        } else {
                                          context
                                                  .read<ChatBloc>()
                                                  .chatDetailsMap['isMedia'] =
                                              false;
                                          _handleMessage(
                                              context
                                                  .read<ChatBloc>()
                                                  .chatDetailsMap['message']
                                                  .toString(),
                                              context);
                                          context.read<ChatBloc>().add(
                                              SendChatMessage(
                                                  sendMessageMap: context
                                                      .read<ChatBloc>()
                                                      .chatDetailsMap));
                                        }
                                      }
                                    : null,
                                textValue: 'Send')),
                      ],
                    ),
                  );
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
      ),
    );
  }

  Widget getWidgetBasedOnString(msgType, snapshot, reversedIndex) {
    switch (msgType) {
      case '1':
        return MsgTextWidget(snapshot: snapshot, reversedIndex: reversedIndex);
      default:
        return AttachmentMsgWidget(
            snapShot: snapshot, reversedIndex: reversedIndex);
    }
  }

  void _handleMessage(String text, BuildContext context) {
    if (text.isEmpty) return;
    context.read<ChatBloc>().messagesList.insert(0, {'msg': text});
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
