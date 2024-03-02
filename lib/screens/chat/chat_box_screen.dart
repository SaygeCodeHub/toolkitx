import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/chatBox/chat_box_bloc.dart';
import 'package:toolkit/blocs/chatBox/chat_box_event.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/chat/fetch_employees_screen.dart';
import 'package:toolkit/screens/chat/new_chat_screen.dart';
import 'package:toolkit/screens/chat/widgets/chat_box_pop_up_menu.dart';
import 'package:toolkit/screens/chat/widgets/chat_data_model.dart';
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
        titleTextStyle: Theme.of(context).textTheme.mediumLarge,
        actions: [ChatBoxPopUpMenu()],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, FetchEmployeesScreen.routeName,
                arguments: false);
          },
          child: const Icon(Icons.add)),
      body: StreamBuilder<List<ChatData>>(
        stream: context.read<ChatBoxBloc>().allChatsStream,
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
                        onTap: () {
                          NewChatScreen.employeeDetailsMap = {
                            "employee_name": snapshot.data![index].employeeName,
                            'employee_id': snapshot.data![index].employeeId
                          };
                          Navigator.pushNamed(context, NewChatScreen.routeName);
                        },
                        leading: Container(
                            padding: const EdgeInsets.all(tiniestSpacing),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: AppColor.deepBlue),
                            child: const Icon(Icons.person,
                                color: AppColor.ghostWhite, size: 20)),
                        title: Text(snapshot.data![index].employeeName),
                        titleTextStyle: Theme.of(context)
                            .textTheme
                            .small
                            .copyWith(
                                color: AppColor.black,
                                fontWeight: FontWeight.w500),
                        subtitle: Text(snapshot.data![index].message),
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
