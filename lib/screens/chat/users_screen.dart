import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/chat/chat_bloc.dart';
import 'package:toolkit/blocs/chat/chat_event.dart';
import 'package:toolkit/blocs/chat/chat_state.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/di/app_module.dart';
import 'package:toolkit/screens/chat/chat_messaging_screen.dart';
import 'package:toolkit/screens/chat/widgets/chat_data_model.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/global.dart';
import 'package:toolkit/widgets/android_pop_up.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_no_records_text.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../configs/app_color.dart';

class UsersScreen extends StatelessWidget {
  static const routeName = 'EmployeesScreen';
  final bool isCreateNewGroup;

  UsersScreen({super.key, this.isCreateNewGroup = false});

  final Map sendMessageMap = {};

  static int pageNo = 1;

  final ChatData chatData = getIt<ChatData>();
  static TextEditingController textEditingController = TextEditingController();
  static bool isSearchEnabled = false;

  @override
  Widget build(BuildContext context) {
    pageNo = 1;
    textEditingController.clear();
    context.read<ChatBloc>().add(FetchEmployees(pageNo: 1, searchedName: ''));
    context.read<ChatBloc>().employeeListReachedMax = false;
    context.read<ChatBloc>().isSearchEnabled = false;
    context.read<ChatBloc>().employeeList.clear();

    textEditingController.addListener(() {
      String text = textEditingController.text.trim();
      if (text.isEmpty) {
        context.read<ChatBloc>().isSearchEnabled = false;
        pageNo = 1;
        context.read<ChatBloc>().employeeList.clear();
        context.read<ChatBloc>().employeeListReachedMax = false;
        context
            .read<ChatBloc>()
            .add(FetchEmployees(pageNo: pageNo, searchedName: ''));
      }
    });

    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kUsers),
        floatingActionButton: (isCreateNewGroup)
            ? BlocListener<ChatBloc, ChatState>(
                listener: (context, state) {
                  if (state is CreatingChatGroup) {
                    ProgressBar.show(context);
                  } else if (state is ChatGroupCreated) {
                    ProgressBar.dismiss(context);
                    Navigator.pop(context);
                  } else if (state is ChatGroupCannotCreate) {
                    ProgressBar.dismiss(context);
                    showCustomSnackBar(context, state.errorMessage, '');
                  }
                },
                child: FloatingActionButton.extended(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AndroidPopUp(
                                titleValue: 'Do you want to create the group?',
                                contentValue: '',
                                onPrimaryButton: () {
                                  context
                                      .read<ChatBloc>()
                                      .add(CreateChatGroup());
                                  Navigator.pop(context);
                                });
                          });
                    },
                    label: const Text('Create Group')))
            : null,
        body: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: leftRightMargin, vertical: xxTinierSpacing),
            child: Column(children: [
              Padding(
                  padding: const EdgeInsets.only(bottom: xxxSmallestSpacing),
                  child: BlocBuilder<ChatBloc, ChatState>(
                      buildWhen: (previousState, currentState) =>
                          currentState is EmployeesFetched,
                      builder: (context, state) {
                        if (state is EmployeesFetched) {
                          return Row(children: [
                            Expanded(
                                flex: 2,
                                child: TextFormField(
                                    controller: textEditingController,
                                    decoration: InputDecoration(
                                        suffix: const SizedBox(),
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .xSmall
                                            .copyWith(color: AppColor.grey),
                                        hintText: StringConstants.kSearch,
                                        contentPadding: const EdgeInsets.all(
                                            xxxTinierSpacing),
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColor.lightGrey)),
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColor.lightGrey)),
                                        filled: true,
                                        fillColor: AppColor.white))),
                            const SizedBox(width: xxTinierSpacing),
                            Expanded(
                                child: PrimaryButton(
                                    onPressed: () {
                                      FocusScopeNode currentFocus =
                                          FocusScope.of(context);
                                      if (!currentFocus.hasPrimaryFocus) {
                                        currentFocus.unfocus();
                                      }
                                      String searchText =
                                          textEditingController.text.trim();
                                      if (searchText.isNotEmpty) {
                                        context
                                            .read<ChatBloc>()
                                            .isSearchEnabled = true;
                                        pageNo = 1;
                                        context
                                            .read<ChatBloc>()
                                            .employeeList
                                            .clear();
                                        context
                                            .read<ChatBloc>()
                                            .employeeListReachedMax = false;
                                        sendMessageMap['user_name'] =
                                            searchText;
                                        context.read<ChatBloc>().add(
                                            FetchEmployees(
                                                pageNo: pageNo,
                                                searchedName: sendMessageMap[
                                                    'user_name']));
                                      }
                                    },
                                    textValue: StringConstants.kSearch))
                          ]);
                        } else {
                          return const SizedBox.shrink();
                        }
                      })),
              BlocConsumer<ChatBloc, ChatState>(
                  listener: (context, state) {
                    if (state is EmployeesFetched &&
                        context.read<ChatBloc>().employeeListReachedMax) {
                      const Center(child: Text(StringConstants.kNoDataFound));
                    }
                  },
                  buildWhen: (previousState, currentState) =>
                      (currentState is FetchingEmployees && pageNo == 1) ||
                      (currentState is EmployeesFetched),
                  builder: (context, state) {
                    if (state is FetchingEmployees) {
                      return const Expanded(
                          child: Center(child: CircularProgressIndicator()));
                    } else if (state is EmployeesFetched) {
                      return Expanded(
                          child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: (context
                                      .read<ChatBloc>()
                                      .employeeListReachedMax)
                                  ? state.employeeList.length
                                  : state.employeeList.length + 1,
                              itemBuilder: (context, index) {
                                if (state.employeeList.isNotEmpty) {
                                  if (index < state.employeeList.length) {
                                    return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomCard(
                                              child: ListTile(
                                                  onTap: () async {
                                                    context
                                                        .read<ChatBloc>()
                                                        .chatDetailsMap = {
                                                      'rid': state
                                                          .employeeList[index]
                                                          .id
                                                          .toString(),
                                                      'employee_name': state
                                                          .employeeList[index]
                                                          .name,
                                                      'rtype': state
                                                          .employeeList[index]
                                                          .type
                                                          .toString()
                                                    };
                                                    chatScreenName =
                                                        ChatMessagingScreen
                                                            .routeName;
                                                    Navigator.pushNamed(
                                                            context,
                                                            ChatMessagingScreen
                                                                .routeName)
                                                        .whenComplete(() {
                                                      context
                                                          .read<ChatBloc>()
                                                          .add(
                                                              FetchChatsList());
                                                    });
                                                  },
                                                  leading: const Icon(
                                                      Icons.person,
                                                      color: AppColor.deepBlue),
                                                  title: Text(
                                                      state.employeeList[index]
                                                          .name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .xSmall),
                                                  subtitle: Text(
                                                      (state.employeeList[index]
                                                                  .type ==
                                                              1)
                                                          ? 'System User'
                                                          : 'Workforce'),
                                                  trailing: (isCreateNewGroup)
                                                      ? ShowCheckBox(
                                                          employeeDetailsMap: {
                                                              'rid': state
                                                                  .employeeList[
                                                                      index]
                                                                  .id
                                                                  .toString(),
                                                              'employee_name': state
                                                                  .employeeList[
                                                                      index]
                                                                  .name,
                                                              'type': state
                                                                  .employeeList[
                                                                      index]
                                                                  .type
                                                            },
                                                          chatData: chatData)
                                                      : IconButton(
                                                          onPressed: () {
                                                            context
                                                                .read<
                                                                    ChatBloc>()
                                                                .chatDetailsMap = {
                                                              'rid': state
                                                                  .employeeList[
                                                                      index]
                                                                  .id
                                                                  .toString(),
                                                              'employee_name': state
                                                                  .employeeList[
                                                                      index]
                                                                  .name,
                                                              'rtype': state
                                                                  .employeeList[
                                                                      index]
                                                                  .type
                                                                  .toString(),
                                                              'isReceiver': 0
                                                            };
                                                            Navigator.pushNamed(
                                                                context,
                                                                ChatMessagingScreen
                                                                    .routeName);
                                                          },
                                                          icon: const Icon(Icons
                                                              .message_outlined)))),
                                          const SizedBox(
                                              height: xxTinierSpacing)
                                        ]);
                                  } else {
                                    pageNo++;
                                    context.read<ChatBloc>().add(FetchEmployees(
                                        pageNo: pageNo,
                                        searchedName:
                                            sendMessageMap['user_name'] ?? ''));

                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                } else {
                                  return const Center(
                                      child:
                                          Text(StringConstants.kNoDataFound));
                                }
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                    height: xxxTiniestSpacing);
                              }));
                    } else if (state is EmployeesNotFetched) {
                      return const NoRecordsText(
                          text: StringConstants.kNoDataFound);
                    } else {
                      return const Center(
                          child: Text(StringConstants.kNoDataFound));
                    }
                  })
            ])));
  }
}

class ShowCheckBox extends StatefulWidget {
  final Map employeeDetailsMap;
  final ChatData chatData;

  const ShowCheckBox(
      {super.key, required this.employeeDetailsMap, required this.chatData});

  @override
  State<ShowCheckBox> createState() => _ShowCheckBoxState();
}

class _ShowCheckBoxState extends State<ShowCheckBox> {
  void addOrRemoveMember() {
    if (context.read<ChatBloc>().groupDataMap['members']?.indexWhere(
            (element) =>
                element['id'] == int.parse(widget.employeeDetailsMap['rid'])) ==
        -1) {
      context.read<ChatBloc>().groupDataMap['members'].add({
        'id': int.parse(widget.employeeDetailsMap['rid']),
        'type': widget.employeeDetailsMap['type'],
        'name': widget.employeeDetailsMap['employee_name'],
        'isowner': 0
      });
    } else {
      if (context.read<ChatBloc>().groupDataMap['members'][context
              .read<ChatBloc>()
              .groupDataMap['members']
              ?.indexWhere((element) =>
                  element['id'] ==
                  int.parse(widget.employeeDetailsMap['rid']))]['isowner'] !=
          1) {
        context.read<ChatBloc>().groupDataMap['members']?.removeWhere(
            (element) =>
                element['id'] == int.parse(widget.employeeDetailsMap['rid']));
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        activeColor: AppColor.deepBlue,
        value: context.read<ChatBloc>().groupDataMap['members']?.indexWhere(
                (element) =>
                    element['id'] ==
                    int.parse(widget.employeeDetailsMap['rid'])) !=
            -1,
        onChanged: (bool? val) {
          addOrRemoveMember();
        });
  }
}
