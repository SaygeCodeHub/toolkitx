import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/di/app_module.dart';
import 'package:toolkit/screens/chat/group_chat_list_screen.dart';
import 'package:toolkit/screens/chat/group_chat_screen.dart';
import 'package:toolkit/screens/chat/widgets/chat_data_model.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../../blocs/chat/chat_bloc.dart';
import '../../../blocs/chat/chat_event.dart';
import '../../../configs/app_dimensions.dart';

class AllChatPopUpMenu extends StatelessWidget {
  final ChatData chatData = getIt<ChatData>();

  AllChatPopUpMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
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
                value: 'option1',
                child: Text(DatabaseUtil.getText('Groups'),
                    style: Theme.of(context).textTheme.xxSmall),
                onTap: () {
                  Navigator.pushNamed(context, GroupChatScreen.routeName);
                }),
            PopupMenuItem(
                value: 'option2',
                child:
                    Text('Groups2', style: Theme.of(context).textTheme.xxSmall),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(GroupChatListScreen.routeName)
                      .whenComplete(() {
                    context.read<ChatBloc>().add(FetchChatsList());
                  });
                })
          ];
        });
  }
}
