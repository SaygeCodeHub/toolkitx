import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/chat/chat_bloc.dart';
import 'package:toolkit/blocs/chat/chat_event.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/screens/chat/widgets/media_alert_dialog.dart';
import 'package:toolkit/screens/chat/widgets/media_options_widget.dart';

class DocumentMediaWidget extends StatelessWidget {
  const DocumentMediaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaAlertDialog(
      mediaList: [
        Material(
          child: MediaOptionsWidget(
            onMediaSelected: () {
              switch (
                  context.read<ChatBloc>().chatDetailsMap['selectedMedia']) {
                case 'Document':
                  context.read<ChatBloc>().chatDetailsMap['mediaType'] =
                      'Document';
                  context.read<ChatBloc>().chatDetailsMap['message_type'] = '4';
                  if (context
                          .read<ChatBloc>()
                          .chatDetailsMap['selectedMedia'] ==
                      'Gallery') {
                    context.read<ChatBloc>().isCameraImage = false;
                    context.read<ChatBloc>().add(PickMedia(
                        mediaDetailsMap:
                            context.read<ChatBloc>().chatDetailsMap));
                  } else {
                    context.read<ChatBloc>().isCameraImage = true;
                    context.read<ChatBloc>().add(PickMedia(
                        mediaDetailsMap:
                            context.read<ChatBloc>().chatDetailsMap));
                  }
                  Navigator.pop(context);
                  break;
              }
            },
            mediaDataMap: const {
              'color': AppColor.yellow,
              'icon': Icons.folder,
              'media': 'Document'
            },
          ),
        )
      ],
    );
  }
}
