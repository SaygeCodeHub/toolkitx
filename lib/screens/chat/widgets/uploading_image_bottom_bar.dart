import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/chat/chat_bloc.dart';
import '../../../blocs/chat/chat_event.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/primary_button.dart';

class UploadingImageBottomBar extends StatelessWidget {
  final bool isUploadComplete;
  const UploadingImageBottomBar({super.key, required this.isUploadComplete});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(xxTinierSpacing),
        child: Row(children: [
          Expanded(
              child: PrimaryButton(
                  onPressed: () {
                    context.read<ChatBloc>().chatDetailsMap['isMedia'] = false;
                    context.read<ChatBloc>().chatDetailsMap['message'] = '';
                    context.read<ChatBloc>().add(RebuildChatMessagingScreen(
                        employeeDetailsMap:
                            context.read<ChatBloc>().chatDetailsMap,
                        replyToMessage: ''));
                  },
                  textValue: (isUploadComplete)
                      ? StringConstants.kRemove
                      : StringConstants.kBack)),
          const SizedBox(width: xxTinierSpacing),
          Expanded(
              child: PrimaryButton(
                  onPressed: (isUploadComplete)
                      ? () {
                          if (context
                                      .read<ChatBloc>()
                                      .chatDetailsMap['message']
                                      .toString() ==
                                  '' ||
                              context
                                      .read<ChatBloc>()
                                      .chatDetailsMap['message'] ==
                                  null) {
                            showCustomSnackBar(context,
                                StringConstants.kUploadingAttachmentError, '');
                          } else {
                            context.read<ChatBloc>().chatDetailsMap['isMedia'] =
                                false;
                            _handleMessage(
                                context
                                    .read<ChatBloc>()
                                    .chatDetailsMap['message']
                                    .toString(),
                                context);
                            context.read<ChatBloc>().add(SendChatMessage(
                                sendMessageMap:
                                    context.read<ChatBloc>().chatDetailsMap));
                            context.read<ChatBloc>().add(ReplyToMessage(
                                replyToMessage: '', quoteMessageId: ''));
                          }
                        }
                      : null,
                  textValue: StringConstants.kSend))
        ]));
  }

  void _handleMessage(String text, BuildContext context) {
    if (text.isEmpty) return;
    context.read<ChatBloc>().messagesList.insert(0, {'msg': text});
  }
}
