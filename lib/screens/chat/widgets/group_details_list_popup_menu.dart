import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/chat/chat_bloc.dart';
import 'package:toolkit/blocs/chat/chat_event.dart';
import 'package:toolkit/blocs/chat/chat_state.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/progress_bar.dart';

class GroupDetailsListPopupMenu extends StatelessWidget {
  const GroupDetailsListPopupMenu(
      {super.key,
      required this.groupId,
      required this.memberId,
      required this.apiKey,
      required this.memberType});

  final String groupId;
  final String memberId;
  final String memberType;
  final String apiKey;

  @override
  Widget build(BuildContext context) {
    List popUpMenuItems = ['Remove Member', 'Set as Admin', 'Dismiss as Admin'];
    final chatBloc = context.read<ChatBloc>();
    return BlocListener<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is ChatMemberRemoving) {
          ProgressBar.show(context);
        } else if (state is ChatMemberRemoved) {
          ProgressBar.dismiss(context);
          context.read<ChatBloc>().add(FetchGroupDetails(groupId: groupId));
        } else if (state is ChatMemberNotRemoved) {
          ProgressBar.dismiss(context);
          showCustomSnackBar(context, state.errorMessage, '');
        }

        if (state is SavingChatMemberAsAdmin) {
          ProgressBar.show(context);
        } else if (state is ChatMemberAsAdminSaved) {
          ProgressBar.dismiss(context);
          context.read<ChatBloc>().add(FetchGroupDetails(groupId: groupId));
        } else if (state is ChatMemberAsAdminNotSaved) {
          ProgressBar.dismiss(context);
          showCustomSnackBar(context, state.errorMessage, '');
        }

        if (state is ChatMemberAsAdminDismissing) {
          ProgressBar.show(context);
        } else if (state is ChatMemberAsAdminDismissed) {
          ProgressBar.dismiss(context);
          context.read<ChatBloc>().add(FetchGroupDetails(groupId: groupId));
        } else if (state is ChatMemberAsAdminNotDismissed) {
          ProgressBar.dismiss(context);
          showCustomSnackBar(context, state.errorMessage, '');
        }
      },
      child: MenuAnchor(
        builder:
            (BuildContext context, MenuController controller, Widget? child) {
          return IconButton(
            onPressed: () {
              if (controller.isOpen) {
                controller.close();
              } else {
                controller.open();
              }
            },
            icon: const Icon(Icons.more_horiz),
          );
        },
        alignmentOffset: const Offset(-80.0, 0.0),
        menuChildren: List<MenuItemButton>.generate(
          popUpMenuItems.length,
          (int index) => MenuItemButton(
            onPressed: () {
              callFunction(popUpMenuItems[index], context, chatBloc, memberId,
                  memberType);
            },
            child: Text(popUpMenuItems[index]),
          ),
        ),
      ),
    );
  }

  callFunction(buttonName, context, chatBloc, memberId, memberType) {
    switch (buttonName) {
      case "Remove Member":
        chatBloc.add(RemoveChatMember(
            groupId: groupId,
            memberId: memberId,
            memberType: memberType,
            isExitGroup: false));
        break;
      case "Set as Admin":
        chatBloc.add(SetChatMemberAsAdmin(
            groupId: groupId, memberId: memberId, memberType: memberType));
        break;
      case "Dismiss as Admin":
        chatBloc.add(DismissChatMemberAsAdmin(
            groupId: groupId, memberId: memberId, memberType: memberType));
        break;
    }
  }
}
