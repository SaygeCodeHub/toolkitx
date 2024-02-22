import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/chatBox/chat_box_bloc.dart';
import 'package:toolkit/blocs/chatBox/chat_box_event.dart';
import 'package:toolkit/blocs/chatBox/chat_box_state.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/chatBox/fetch_employees_screen.dart';
import 'package:toolkit/screens/chatBox/new_chat_screen.dart';
import 'package:toolkit/widgets/custom_card.dart';

class ChatBoxScreen extends StatelessWidget {
  static const routeName = 'ChatBoxScreen';

  const ChatBoxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ChatBoxBloc>().add(FetchChatsList());
    return Scaffold(
      appBar: AppBar(
          title: const Text('Chats'),
          automaticallyImplyLeading: false,
          titleTextStyle: Theme.of(context).textTheme.mediumLarge),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, FetchEmployeesScreen.routeName);
          },
          child: const Icon(Icons.add)),
      body: BlocBuilder<ChatBoxBloc, ChatBoxState>(
        buildWhen: (previousState, currentState) =>
            currentState is ChatListFetched,
        builder: (context, state) {
          if (state is ChatListFetched) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: leftRightMargin, horizontal: leftRightMargin),
              child: ListView.separated(
                itemCount: state.chatsList.length,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CustomCard(
                    child: ListTile(
                        onTap: () {
                          NewChatScreen.employeeDetailsMap = {
                            "employee_name":
                                state.chatsList[index].employeeName ?? '',
                            'employee_id':
                                state.chatsList[index].employeeId ?? ''
                          };
                          Navigator.pushNamed(context, NewChatScreen.routeName);
                        },
                        leading: Container(
                            padding: const EdgeInsets.all(tiniestSpacing),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: AppColor.deepBlue),
                            child: const Icon(
                              Icons.person,
                              color: AppColor.ghostWhite,
                              size: 20,
                            )),
                        title: Text(state.chatsList[index].employeeName ?? ''),
                        titleTextStyle: Theme.of(context)
                            .textTheme
                            .small
                            .copyWith(
                                color: AppColor.black,
                                fontWeight: FontWeight.w500),
                        subtitle: Text(state.chatsList[index].message ?? ''),
                        subtitleTextStyle: Theme.of(context).textTheme.xSmall),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: xxTinierSpacing);
                },
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
