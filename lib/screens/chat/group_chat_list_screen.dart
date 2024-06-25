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
import 'package:toolkit/utils/global.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/secondary_button.dart';

import '../../configs/app_dimensions.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_text_field.dart';
import '../../widgets/primary_button.dart';

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
              SecondaryButtonIcon(
                  width: kAddChatGroupButtonWidth,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              actions: [
                                SizedBox(
                                    height: 35,
                                    child: PrimaryButton(
                                        onPressed: () {
                                          if (context
                                                          .read<ChatBloc>()
                                                          .groupDataMap[
                                                      'group_name'] ==
                                                  null ||
                                              context
                                                          .read<ChatBloc>()
                                                          .groupDataMap[
                                                      'group_name'] ==
                                                  '') {
                                            showCustomSnackBar(context,
                                                'Please enter group name!', '');
                                          } else {
                                            Navigator.pop(context);
                                            context.read<ChatBloc>().add(
                                                InitializeGroupChatMembers());
                                            Navigator.pushNamed(
                                                context, UsersScreen.routeName,
                                                arguments: true);
                                          }
                                        },
                                        textValue: 'Click to select members'))
                              ],
                              actionsAlignment: MainAxisAlignment.center,
                              actionsPadding: const EdgeInsets.symmetric(
                                  vertical: tinySpacing,
                                  horizontal: xxxTinierSpacing),
                              contentTextStyle:
                                  Theme.of(context).textTheme.xSmall,
                              titlePadding: EdgeInsets.zero,
                              title: Container(
                                  height: 39,
                                  color: AppColor.blueGrey,
                                  child: Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(Icons.close)))),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: xxxTinySpacing,
                                  horizontal: tinierSpacing),
                              content: SizedBox(
                                  height: 200,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Name of Group',
                                            style: Theme.of(context)
                                                .textTheme
                                                .xSmall),
                                        const SizedBox(height: xxTinierSpacing),
                                        TextFieldWidget(onTextFieldChanged:
                                            (String textValue) {
                                          context
                                                  .read<ChatBloc>()
                                                  .groupDataMap['group_name'] =
                                              textValue;
                                        }),
                                        const SizedBox(height: tinySpacing),
                                        Text('Purpose of the Group',
                                            style: Theme.of(context)
                                                .textTheme
                                                .xSmall),
                                        const SizedBox(height: xxTinierSpacing),
                                        TextFieldWidget(
                                            maxLength: 255,
                                            onTextFieldChanged:
                                                (String textValue) {
                                              context
                                                      .read<ChatBloc>()
                                                      .groupDataMap[
                                                  'group_purpose'] = textValue;
                                            })
                                      ])));
                        });
                  },
                  textValue: 'Add New Group',
                  icon: const Icon(Icons.add),
                  iconAlignment: IconAlignment.start),
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
                                        context.read<ChatBloc>().chatDetailsMap =
                                            {
                                          "employee_name":
                                              snapshot.data![index].groupName,
                                          'rid': snapshot.data![index].groupId,
                                          'rtype': '3'
                                        };
                                        chatScreenName =
                                            ChatMessagingScreen.routeName;
                                        Navigator.pushNamed(context,
                                                ChatMessagingScreen.routeName)
                                            .then((value) => context
                                                .read<ChatBloc>()
                                                .add(FetchGroupsList()));
                                      },
                                      leading: Container(
                                          padding: const EdgeInsets.all(
                                              tiniestSpacing),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: AppColor.deepBlue),
                                          child: Icon(
                                              (snapshot.data![index].isGroup ==
                                                      true)
                                                  ? Icons.people
                                                  : Icons.person,
                                              color: AppColor.ghostWhite,
                                              size: 20)),
                                      title:
                                          Text(snapshot.data![index].groupName),
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(snapshot
                                                      .data![index].groupPurpose)
                                                ]),
                                            const SizedBox(
                                                height: xxTiniestSpacing),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Flexible(
                                                      child: messageText(
                                                          snapshot.data![index]
                                                              .message,
                                                          snapshot.data![index]
                                                              .messageType)),
                                                  Visibility(
                                                    visible: snapshot.data![index]
                                                            .unreadMsgCount >
                                                        0,
                                                    child: Container(
                                                        height: 15,
                                                        width: 15,
                                                        decoration: BoxDecoration(
                                                            color: AppColor.green,
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    10)),
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
                                                                        color: AppColor
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500)))),
                                                  )
                                                ]),
                                            const SizedBox(
                                                height: xxTiniestSpacing)
                                          ]),
                                      subtitleTextStyle:
                                          Theme.of(context).textTheme.xSmall));
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: xxTinierSpacing);
                            }),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
            ],
          ),
        ));
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
