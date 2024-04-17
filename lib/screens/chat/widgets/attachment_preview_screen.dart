import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/chat/chat_bloc.dart';
import '../../../blocs/chat/chat_event.dart';
import '../../../configs/app_spacing.dart';
import '../../../di/app_module.dart';
import '../../../widgets/secondary_button.dart';
import 'chat_data_model.dart';
import 'media_type_util.dart';

class AttachmentPreviewScreen extends StatefulWidget {
  const AttachmentPreviewScreen({super.key});

  @override
  State<AttachmentPreviewScreen> createState() =>
      _AttachmentPreviewScreenState();
}

class _AttachmentPreviewScreenState extends State<AttachmentPreviewScreen> {
  final ChatData chatData = getIt<ChatData>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: xxxTinySpacing, horizontal: xxTinierSpacing),
      child: SingleChildScrollView(
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
                            context.read<ChatBloc>().chatDetailsMap['isMedia'] =
                                false;
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
                        },
                        textValue: 'Send')),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _handleMessage(String text, BuildContext context) {
    if (text.isEmpty) return;
    context.read<ChatBloc>().messagesList.insert(0, {'msg': text});
  }
}
