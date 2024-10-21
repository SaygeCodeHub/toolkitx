import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/chat/all_chats_screen.dart';
import 'package:toolkit/screens/chat/widgets/attachment_preview_screen.dart';
import 'package:toolkit/screens/chat/widgets/chat_details_pop_up_menu.dart';
import 'package:toolkit/screens/chat/widgets/messgae_tile.dart';
import 'package:toolkit/screens/chat/widgets/chatbox_textfield_widget.dart';
import 'package:toolkit/screens/chat/widgets/date_divider_widget.dart';
import 'package:toolkit/screens/chat/widgets/uploading_image_bottom_bar.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/global.dart';

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
  String replyToMessage = '';

  @override
  void initState() {
    replyToMessage = '';
    context.read<ChatBloc>().chatDetailsMap['isMedia'] = false;
    context.read<ChatBloc>().add(RebuildChatMessagingScreen(
        employeeDetailsMap: context.read<ChatBloc>().chatDetailsMap,
        replyToMessage: replyToMessage));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: true,
        onPopInvokedWithResult: (pop, _) {
          chatScreenName = AllChatsScreen.routeName;
        },
        child: Scaffold(
            appBar: GenericAppBar(
                title:
                    context.read<ChatBloc>().chatDetailsMap['employee_name'] ??
                        '',
                onPressed: () {
                  chatScreenName = AllChatsScreen.routeName;
                  Navigator.pop(context);
                },
                actions: [
                  Visibility(
                      visible:
                          context.read<ChatBloc>().chatDetailsMap['rtype'] ==
                              '3',
                      child: const ChatDetailsPopUpMenu())
                ]),
            body: Column(children: [
              Expanded(
                  child: StreamBuilder<List<Map<String, dynamic>>>(
                      stream: context.read<ChatBloc>().messageStream,
                      builder: (context, snapshot) {
                        if (context
                                .read<ChatBloc>()
                                .chatDetailsMap['isMedia'] ==
                            false) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                reverse: true,
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  final bool needDateDivider =
                                      _needDateDivider(index, snapshot);
                                  return Column(children: [
                                    if (needDateDivider)
                                      Center(
                                          child: DateDividerWidget(
                                              msgTime: snapshot.data?[index]
                                                  ['msg_time'])),
                                    MessageTile(
                                        onReply: (String message) {
                                          context.read<ChatBloc>().add(
                                              ReplyToMessage(
                                                  replyToMessage: message,
                                                  quoteMessageId: snapshot
                                                      .data![index]["msg_id"]));
                                          replyToMessage = message;
                                        },
                                        messageData: snapshot.data![index])
                                  ]);
                                });
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        } else if (context
                                .read<ChatBloc>()
                                .chatDetailsMap['isUploadComplete'] ==
                            false) {
                          if (context
                                  .read<ChatBloc>()
                                  .chatDetailsMap['file_size'] >
                              20) {
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                      child: Text(
                                          StringConstants.kAttachmentLimit,
                                          style: Theme.of(context)
                                              .textTheme
                                              .xSmall
                                              .copyWith(color: AppColor.black)))
                                ]);
                          } else {
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CircularProgressIndicator(),
                                  const SizedBox(height: tiniestSpacing),
                                  Center(
                                      child: Text(
                                          StringConstants.kUploadingAttachment,
                                          style: Theme.of(context)
                                              .textTheme
                                              .xSmall
                                              .copyWith(color: AppColor.grey)))
                                ]);
                          }
                        } else {
                          return const AttachmentPreviewScreen();
                        }
                      })),
              const Divider(height: kChatScreenDividerHeight),
              BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
                if (state is ChatMessagingTextFieldHidden) {
                  return UploadingImageBottomBar(
                      isUploadComplete: context
                          .read<ChatBloc>()
                          .chatDetailsMap['isUploadComplete']);
                } else if (state is ShowChatMessagingTextField) {
                  replyToMessage = state.replyToMessage;
                  return ChatBoxTextFieldWidget(
                      replyToMessage: replyToMessage,
                      focusNode: replyToMessage != '' ? FocusNode() : null);
                } else {
                  if (context.read<ChatBloc>().chatDetailsMap['isMedia'] ==
                      true) {
                    return UploadingImageBottomBar(
                        isUploadComplete: context
                            .read<ChatBloc>()
                            .chatDetailsMap['isUploadComplete']);
                  } else {
                    return ChatBoxTextFieldWidget(
                        replyToMessage: replyToMessage,
                        focusNode: replyToMessage != '' ? FocusNode() : null);
                  }
                }
              })
            ])));
  }

  bool _needDateDivider(
      int index, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
    if (index == snapshot.data!.length - 1) return true;
    DateTime currentDate =
        DateTime.parse(snapshot.data![index]['msg_time']).toLocal();
    DateTime nextDate =
        DateTime.parse(snapshot.data![index + 1]['msg_time']).toLocal();
    return currentDate.day != nextDate.day ||
        currentDate.month != nextDate.month ||
        currentDate.year != nextDate.year;
  }
}
