import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/chat/chat_bloc.dart';
import 'package:toolkit/blocs/chat/chat_event.dart';
import 'package:toolkit/blocs/chat/chat_state.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/chat/widgets/add_new_chat_member_button.dart';
import 'package:toolkit/screens/chat/widgets/group_details_popup_menu.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

class GroupDetailsScreen extends StatelessWidget {
  static const routeName = 'GroupDetailsScreen';
  final String groupId;

  const GroupDetailsScreen({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    print('idd==============>$groupId');
    context.read<ChatBloc>().add(FetchGroupDetails(groupId: groupId));
    return Scaffold(
      appBar: const GenericAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing,
            bottom: xxTinierSpacing),
        child: BlocBuilder<ChatBloc, ChatState>(
          buildWhen: (previousState, currentState) =>
              currentState is GroupDetailsFetching ||
              currentState is GroupDetailsFetched ||
              currentState is GroupDetailsNotFetched,
          builder: (context, state) {
            if (state is GroupDetailsFetching) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GroupDetailsFetched) {
              var data = state.fetchGroupInfoModel.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.name,
                      style: Theme.of(context).textTheme.xSmall.copyWith(
                          color: AppColor.black, fontWeight: FontWeight.bold)),
                  const SizedBox(height: tiniestSpacing),
                  Text(data.purpose),
                  const SizedBox(height: xxxSmallestSpacing),
                  Center(child: AddNewChatMemberButton(groupId: groupId)),
                  const SizedBox(height: xxxSmallestSpacing),
                  Expanded(
                      child: ListView.separated(
                          itemCount: data.members.length,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return CustomCard(
                                child: ListTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(data.members[index].username,
                                            style: Theme.of(context)
                                                .textTheme
                                                .xSmall
                                                .copyWith(
                                                    color: AppColor.black,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                        Visibility(
                                            visible:
                                                data.members[index].isowner ==
                                                    1,
                                            child: const Text("Group Admin",
                                                style: TextStyle(
                                                    color: AppColor.green))),
                                      ],
                                    ),
                                    subtitle: Text(data.members[index].type == 1
                                        ? StringConstants.kSystemUser
                                        : StringConstants.kWorkforce),
                                    trailing: GroupDetailsPopupMenu(
                                        groupId: groupId)));
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: xxTinierSpacing);
                          }))
                ],
              );
            } else if (state is GroupDetailsNotFetched) {
              return const Center(child: Text(StringConstants.kNoRecordsFound));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
