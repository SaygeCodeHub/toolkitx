import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/chat/chat_bloc.dart';
import 'package:toolkit/blocs/chat/chat_event.dart';
import 'package:toolkit/blocs/chat/chat_state.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/chat/group_details_screen.dart';
import 'package:toolkit/screens/chat/widgets/create_group_button.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_card.dart';

import '../../configs/app_dimensions.dart';

class GroupChatScreen extends StatelessWidget {
  static const routeName = 'GroupChatScreen';

  const GroupChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ChatBloc>().add(FetchAllGroups());
    return Scaffold(
        appBar: AppBar(
            title: Text(DatabaseUtil.getText('Groups')),
            automaticallyImplyLeading: true,
            titleTextStyle: Theme.of(context).textTheme.mediumLarge),
        body: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: leftRightMargin, horizontal: leftRightMargin),
            child: Column(children: [
              const Center(child: CreateGroupButton()),
              const SizedBox(height: xxTinierSpacing),
              BlocBuilder<ChatBloc, ChatState>(
                  buildWhen: (previousState, currentState) =>
                      currentState is AllGroupsFetching ||
                      currentState is AllGroupsFetched ||
                      currentState is AllGroupsNotFetched,
                  builder: (context, state) {
                    if (state is AllGroupsFetching) {
                      return Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 3),
                        child: const CircularProgressIndicator(),
                      );
                    } else if (state is AllGroupsFetched) {
                      var data = state.allGroupChatListModel.data;
                      return Expanded(
                          child: ListView.separated(
                              itemCount: data.length,
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return CustomCard(
                                    child: ListTile(
                                  leading: Container(
                                      padding:
                                          const EdgeInsets.all(tiniestSpacing),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              kChatIconRadius),
                                          color: AppColor.deepBlue),
                                      child: const Icon(Icons.people,
                                          color: AppColor.ghostWhite,
                                          size: kChatIconSize)),
                                  title: Text(data[index].name),
                                  titleTextStyle: Theme.of(context)
                                      .textTheme
                                      .small
                                      .copyWith(
                                          color: AppColor.black,
                                          fontWeight: FontWeight.w500),
                                  subtitle: Text(data[index].purpose),
                                  subtitleTextStyle:
                                      Theme.of(context).textTheme.xSmall,
                                  trailing: MenuAnchor(
                                    builder: (BuildContext context,
                                        MenuController controller,
                                        Widget? child) {
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
                                    alignmentOffset: const Offset(-40.0, 0.0),
                                    menuChildren: [
                                      MenuItemButton(
                                        onPressed: () {
                                          Navigator.pushNamed(context,
                                              GroupDetailsScreen.routeName,
                                              arguments: data[index].id);
                                        },
                                        child: Text(
                                            DatabaseUtil.getText('viewDetail')),
                                      )
                                    ],
                                  ),
                                ));
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: xxTinierSpacing);
                              }));
                    } else if (state is AllGroupsNotFetched) {
                      return const Center(
                          child: Text(StringConstants.kNoRecordsFound));
                    }
                    return const SizedBox.shrink();
                  })
            ])));
  }
}
