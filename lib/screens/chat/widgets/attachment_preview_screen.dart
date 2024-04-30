import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';

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
        child: MediaTypeUtil().showMediaWidget(
            context.read<ChatBloc>().chatDetailsMap['mediaType'],
            {'file': chatData.fileName},
            context),
      ),
    );
  }
}
