// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toolkit/blocs/chat/chat_bloc.dart';
import 'package:toolkit/blocs/chat/chat_event.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/chat/chat_messaging_screen.dart';
import 'package:toolkit/screens/chat/users_screen.dart';
import 'package:toolkit/screens/chat/widgets/chat_data_model.dart';
import 'package:toolkit/screens/chat/widgets/all_chat_pop_up_menu.dart';
import 'package:toolkit/utils/global.dart';
import 'package:toolkit/widgets/custom_card.dart';

import '../../configs/app_dimensions.dart';

class AllChatsScreen extends StatelessWidget {
  static const routeName = 'AllChatsScreen';

  const AllChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ChatBloc>().add(FetchChatsList());
    return Scaffold(
        appBar: AppBar(
            title: const Text('Chats'),
            automaticallyImplyLeading: false,
            titleTextStyle: Theme.of(context).textTheme.mediumLarge,
            actions: [AllChatPopUpMenu()]),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, UsersScreen.routeName,
                      arguments: false)
                  .whenComplete(() {
                context.read<ChatBloc>().add(FetchChatsList());
              });
            },
            child: const Icon(Icons.add)),
        body: StreamBuilder<List<ChatData>>(
            stream: context.read<ChatBloc>().allChatsStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: leftRightMargin, horizontal: leftRightMargin),
                    child: ListView.separated(
                        itemCount: snapshot.data!.length,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return CustomCard(
                              child: ListTile(
                                  onTap: () async {
                                    context.read<ChatBloc>().chatDetailsMap = {
                                      "employee_name":
                                          snapshot.data![index].userName,
                                      'rid': snapshot.data![index].rId,
                                      'rtype': snapshot.data![index].rType,
                                    };
                                    chatScreenName =
                                        ChatMessagingScreen.routeName;
                                    Navigator.pushNamed(context,
                                            ChatMessagingScreen.routeName)
                                        .whenComplete(() => context
                                            .read<ChatBloc>()
                                            .add(FetchChatsList()));
                                  },
                                  leading: Container(
                                      padding:
                                          const EdgeInsets.all(tiniestSpacing),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              kChatIconRadius),
                                          color: AppColor.deepBlue),
                                      child: Icon(
                                          (snapshot.data![index].isGroup ==
                                                  true)
                                              ? Icons.people
                                              : Icons.person,
                                          color: AppColor.ghostWhite,
                                          size: kChatIconSize)),
                                  title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text((snapshot.data![index].isGroup ==
                                                true)
                                            ? snapshot.data![index].groupName
                                            : snapshot.data![index].userName),
                                        Text(snapshot.data![index].dateTime,
                                            style: Theme.of(context)
                                                .textTheme
                                                .xxSmall
                                                .copyWith(
                                                    color: AppColor.black,
                                                    fontWeight:
                                                        FontWeight.w500))
                                      ]),
                                  titleTextStyle: Theme.of(context)
                                      .textTheme
                                      .small
                                      .copyWith(
                                          color: AppColor.black,
                                          fontWeight: FontWeight.w500),
                                  subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                            height: xxTiniestSpacing),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text((snapshot.data![index]
                                                          .isGroup ==
                                                      true)
                                                  ? 'Group'
                                                  : (snapshot.data![index]
                                                              .sType ==
                                                          '2')
                                                      ? 'Workforce'
                                                      : 'System User')
                                            ]),
                                        const SizedBox(
                                            height: xxTiniestSpacing),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                  child: messageText(
                                                      snapshot
                                                          .data![index].message,
                                                      snapshot.data![index]
                                                          .messageType)),
                                              Visibility(
                                                  visible: snapshot.data![index]
                                                          .unreadMsgCount >
                                                      0,
                                                  child: Container(
                                                      height:
                                                          kChatUnreadMsgCountSize,
                                                      width:
                                                          kChatUnreadMsgCountSize,
                                                      decoration: BoxDecoration(
                                                          color: AppColor.green,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  kChatUnreadMsgCountRadius)),
                                                      child: Center(
                                                          child: Text(
                                                              snapshot
                                                                  .data![index]
                                                                  .unreadMsgCount
                                                                  .toString(),
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .xxSmall
                                                                  .copyWith(
                                                                      color: AppColor.black,
                                                                      fontWeight: FontWeight.w500)))))
                                            ]),
                                        const SizedBox(height: xxTiniestSpacing)
                                      ]),
                                  subtitleTextStyle:
                                      Theme.of(context).textTheme.xSmall));
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: xxTinierSpacing);
                        }));
              } else {
                return const SizedBox.shrink();
              }
            }));
  }

  String time(String time) {
    DateTime formattedTime = DateTime.parse(time);
    return DateFormat('H:mm').format(formattedTime);
  }

  Widget messageText(String message, String type) {
    switch (type) {
      case '1':
        return Text(message, maxLines: 1, overflow: TextOverflow.ellipsis);
      case '2':
        return const Text('Image');
      case '3':
        return const Text('Video');
      case '4':
        return const Text('Document');
      default:
        return const Text('');
    }
  }
}
