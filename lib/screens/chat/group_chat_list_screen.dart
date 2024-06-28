// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/chat/chat_bloc.dart';
import 'package:toolkit/blocs/chat/chat_event.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/chat/chat_messaging_screen.dart';
import 'package:toolkit/screens/chat/widgets/chat_data_model.dart';
import 'package:toolkit/screens/chat/widgets/create_group_button.dart';
import 'package:toolkit/utils/global.dart';
import 'package:toolkit/widgets/custom_card.dart';

import '../../configs/app_dimensions.dart';

class GroupChatListScreen extends StatelessWidget {
  static const routeName = 'GroupChatListScreen';

  const GroupChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ChatBloc>().add(FetchGroupsList());
    return Scaffold(
        appBar: AppBar(
            title: const Text('Groups'),
            automaticallyImplyLeading: true,
            titleTextStyle: Theme.of(context).textTheme.mediumLarge),
        body: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: leftRightMargin, horizontal: leftRightMargin),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CreateGroupButton(),
                  const SizedBox(height: xxTinierSpacing),
                  StreamBuilder<List<ChatData>>(
                      stream: context.read<ChatBloc>().allGroupChatsStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Expanded(
                              child: ListView.separated(
                                  itemCount: snapshot.data!.length,
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return CustomCard(
                                        child: ListTile(
                                            onTap: () async {
                                              context
                                                  .read<ChatBloc>()
                                                  .chatDetailsMap = {
                                                "employee_name": snapshot
                                                    .data![index].groupName,
                                                'rid': snapshot
                                                    .data![index].groupId,
                                                'rtype': '3'
                                              };
                                              chatScreenName =
                                                  ChatMessagingScreen.routeName;
                                              Navigator.pushNamed(
                                                      context,
                                                      ChatMessagingScreen
                                                          .routeName)
                                                  .then((value) => context
                                                      .read<ChatBloc>()
                                                      .add(FetchGroupsList()));
                                            },
                                            leading: Container(
                                                padding: const EdgeInsets.all(
                                                    tiniestSpacing),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            kChatIconRadius),
                                                    color: AppColor.deepBlue),
                                                child: Icon(
                                                    (snapshot.data![index].isGroup ==
                                                            true)
                                                        ? Icons.people
                                                        : Icons.person,
                                                    color: AppColor.ghostWhite,
                                                    size: kChatIconSize)),
                                            title: Text(snapshot
                                                .data![index].groupName),
                                            titleTextStyle: Theme.of(context)
                                                .textTheme
                                                .small
                                                .copyWith(
                                                    color: AppColor.black,
                                                    fontWeight: FontWeight.w500),
                                            subtitle: Text(snapshot.data![index].groupPurpose),
                                            subtitleTextStyle: Theme.of(context).textTheme.xSmall));
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                        height: xxTinierSpacing);
                                  }));
                        } else {
                          return const SizedBox.shrink();
                        }
                      })
                ])));
  }
}
