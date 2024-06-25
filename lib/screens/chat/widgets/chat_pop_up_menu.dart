import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/di/app_module.dart';
import 'package:toolkit/screens/chat/group_chat_list_screen.dart';
import 'package:toolkit/screens/chat/widgets/chat_data_model.dart';

class ChatPopUpMenu extends StatelessWidget {
  final ChatData chatData = getIt<ChatData>();

  ChatPopUpMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(itemBuilder: (context) {
      return [
        PopupMenuItem(
            value: 'option1',
            child: Text('Groups', style: Theme.of(context).textTheme.xxSmall),
            onTap: () {
              Navigator.of(context).pushNamed(GroupChatListScreen.routeName);
            })
      ];
    });
  }
}
