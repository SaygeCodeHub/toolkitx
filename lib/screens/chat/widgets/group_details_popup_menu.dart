import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/chat/chat_bloc.dart';
import 'package:toolkit/blocs/chat/chat_event.dart';
import 'package:toolkit/blocs/chat/chat_state.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/chat/group_chat_screen.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/progress_bar.dart';

class GroupDetailsPopupMenu extends StatelessWidget {
  const GroupDetailsPopupMenu({super.key, required this.groupId});

  final String groupId;

  PopupMenuItem _buildPopupMenuItem(context, String title, String position) {
    return PopupMenuItem(
        value: position,
        child: Text(title, style: Theme.of(context).textTheme.xSmall));
  }

  @override
  Widget build(BuildContext context) {
    List groupDetailsPopupMenu = ['Exit From Group'];
    return BlocListener<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is ChatMemberRemoving) {
          ProgressBar.show(context);
        } else if (state is ChatMemberRemoved) {
          ProgressBar.dismiss(context);
          if (state.isExitGroup == true) {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, GroupChatScreen.routeName);
          }
        } else if (state is ChatMemberNotRemoved) {
          ProgressBar.dismiss(context);
          showCustomSnackBar(context, state.errorMessage, '');
        }
      },
      child: PopupMenuButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kCardRadius)),
        iconSize: kIconSize,
        icon: const Icon(Icons.more_vert_outlined),
        offset: const Offset(0, xxTinierSpacing),
        onSelected: (value) {
          if (value == "Exit From Group") {
            context.read<ChatBloc>().add(RemoveChatMember(
                groupId: groupId,
                memberId: '',
                memberType: '',
                isExitGroup: true));
          }
        },
        position: PopupMenuPosition.under,
        itemBuilder: (BuildContext context) => [
          for (int i = 0; i < groupDetailsPopupMenu.length; i++)
            _buildPopupMenuItem(
                context, groupDetailsPopupMenu[i], groupDetailsPopupMenu[i])
        ],
      ),
    );
  }
}
