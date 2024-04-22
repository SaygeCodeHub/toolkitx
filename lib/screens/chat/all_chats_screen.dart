import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/chat/chat_bloc.dart';
import 'package:toolkit/blocs/chat/chat_event.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/chat/employees_screen.dart';
import 'package:toolkit/screens/chat/chat_messaging_screen.dart';
import 'package:toolkit/screens/chat/widgets/chat_pop_up_menu.dart';
import 'package:toolkit/screens/chat/widgets/chat_data_model.dart';
import 'package:toolkit/widgets/custom_card.dart';

import '../../di/app_module.dart';
import '../../utils/database/database_util.dart';

class AllChatsScreen extends StatelessWidget {
  static const routeName = 'AllChatsScreen';

  const AllChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ChatBloc>().add(FetchChatsList());
    final DatabaseHelper databaseHelper = getIt<DatabaseHelper>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        automaticallyImplyLeading: false,
        titleTextStyle: Theme.of(context).textTheme.mediumLarge,
        actions: [ChatPopUpMenu()],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, EmployeesScreen.routeName,
                arguments: false);
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
                          await databaseHelper.updateShowCountForMessages(
                              snapshot.data![index].rId,
                              snapshot.data![index].sId);
                          context.read<ChatBloc>().chatDetailsMap = {
                            "employee_name": snapshot.data![index].userName,
                            'rid': snapshot.data![index].rId,
                            'sid': snapshot.data![index].sId,
                            'isReceiver': snapshot.data![index].isReceiver,
                            'stype': snapshot.data![index].sType,
                            'rtype': snapshot.data![index].rType,
                            'isGroup': snapshot.data![index].isGroup
                          };
                          Navigator.pushNamed(
                              context, ChatMessagingScreen.routeName);
                        },
                        leading: Container(
                            padding: const EdgeInsets.all(tiniestSpacing),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: AppColor.deepBlue),
                            child: Icon(
                                (snapshot.data![index].isGroup == true)
                                    ? Icons.people
                                    : Icons.person,
                                color: AppColor.ghostWhite,
                                size: 20)),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text((snapshot.data![index].isGroup == true)
                                ? snapshot.data![index].groupName
                                : snapshot.data![index].userName),
                            Text(snapshot.data![index].date)
                          ],
                        ),
                        titleTextStyle: Theme.of(context)
                            .textTheme
                            .small
                            .copyWith(
                                color: AppColor.black,
                                fontWeight: FontWeight.w500),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: xxTiniestSpacing),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text((snapshot.data![index].sType == '2')
                                    ? 'Workforce'
                                    : 'System User'),
                                Text(snapshot.data![index].time,
                                    style: Theme.of(context)
                                        .textTheme
                                        .xxSmall
                                        .copyWith(
                                            color: AppColor.black,
                                            fontWeight: FontWeight.w500))
                              ],
                            ),
                            const SizedBox(height: xxTiniestSpacing),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                    child: messageText(
                                        snapshot.data![index].message,
                                        snapshot.data![index].messageType)),
                                Visibility(
                                  visible:
                                      snapshot.data![index].unreadMsgCount != 0,
                                  child: Container(
                                      height: 15,
                                      width: 15,
                                      decoration: BoxDecoration(
                                          color: AppColor.green,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                          child: Text(
                                              snapshot
                                                  .data![index].unreadMsgCount
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .xxSmall
                                                  .copyWith(
                                                      color: AppColor.black,
                                                      fontWeight:
                                                          FontWeight.w500)))),
                                )
                              ],
                            ),
                            const SizedBox(height: xxTiniestSpacing),
                          ],
                        ),
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

  Widget messageText(String message, String type) {
    switch (type) {
      case '1':
        return Text(message, maxLines: 1);
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
