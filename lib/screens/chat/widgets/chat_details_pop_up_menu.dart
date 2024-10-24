import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/chat/chat_bloc.dart';
import 'package:toolkit/blocs/chat/chat_event.dart';
import 'package:toolkit/blocs/chat/chat_state.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/chat/group_details_screen.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/progress_bar.dart';

class ChatDetailsPopUpMenu extends StatelessWidget {
  const ChatDetailsPopUpMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is ChatMemberRemoving) {
          ProgressBar.show(context);
        } else if (state is ChatMemberRemoved) {
          ProgressBar.dismiss(context);
          if (state.isExitGroup == true) {
            Navigator.pop(context);
          }
        } else if (state is ChatMemberNotRemoved) {
          ProgressBar.dismiss(context);
          showCustomSnackBar(context, state.errorMessage, '');
        }
      },
      child: PopupMenuButton(
          offset: const Offset(0, 40),
          shape: ShapeBorder.lerp(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kCardRadius)),
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kCardRadius)),
              1),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                  value: '1',
                  child: Text('View Details',
                      style: Theme.of(context).textTheme.xxSmall),
                  onTap: () {
                    Navigator.pushNamed(context, GroupDetailsScreen.routeName,
                        arguments:
                            context.read<ChatBloc>().chatDetailsMap['rid']);
                  }),
              PopupMenuItem(
                  value: '2',
                  child: Text('Exit From Group',
                      style: Theme.of(context).textTheme.xxSmall),
                  onTap: () {
                    context.read<ChatBloc>().add(RemoveChatMember(
                        groupId: context.read<ChatBloc>().chatDetailsMap['rid'],
                        memberId: '',
                        memberType: '',
                        isExitGroup: true));
                  })
            ];
          }),
    );
  }
}
