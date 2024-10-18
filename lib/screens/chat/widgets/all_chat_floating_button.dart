import 'package:flutter/material.dart';
import 'package:toolkit/blocs/chat/chat_bloc.dart';
import 'package:toolkit/blocs/chat/chat_event.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/screens/chat/group_chat_screen.dart';
import 'package:toolkit/screens/chat/users_screen.dart';

class AllChatFloatingButton extends StatelessWidget {
  const AllChatFloatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          _showOptions(context);
        },
        child: const Icon(Icons.add));
  }

  void _showOptions(BuildContext context) {
    List chatItemList = ['New Chat', 'New Group'];
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: kChatBottomSheetHeight,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: chatItemList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: tinySpacing),
                child: Card(
                  child: ListTile(
                    title: Center(child: Text(chatItemList[index])),
                    onTap: () {
                      navigateToModule(chatItemList[index], context);
                    },
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: tiniestSpacing,
              );
            },
          ),
        );
      },
    );
  }

  navigateToModule(
    buttonName,
    context,
  ) {
    switch (buttonName) {
      case "New Chat":
        Navigator.pop(context);
        Navigator.pushNamed(context, UsersScreen.routeName, arguments: false)
            .whenComplete(() {
          context.read<ChatBloc>().add(FetchChatsList());
        });
        break;
      case "New Group":
        Navigator.pop(context);
        Navigator.pushNamed(context, GroupChatScreen.routeName);
        break;
    }
  }
}
