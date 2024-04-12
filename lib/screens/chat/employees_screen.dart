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
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/android_pop_up.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/custom_icon_button.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_no_records_text.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../configs/app_color.dart';

class EmployeesScreen extends StatelessWidget {
  static const routeName = 'EmployeesScreen';
  final bool isCreateNewGroup;

  EmployeesScreen({super.key, this.isCreateNewGroup = false});

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
                  Navigator.pop(context);
                } else if (state is ChatGroupCannotCreate) {
                  ProgressBar.dismiss(context);
                  showCustomSnackBar(context, state.errorMessage, '');
                }
              },
              child: FloatingActionButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AndroidPopUp(
                              titleValue: 'Do you want to create the group?',
                              contentValue: '',
                              onPrimaryButton: () {
                                context.read<ChatBloc>().add(CreateChatGroup());
                                Navigator.pop(context);
                              });
                        });
                  },
                  child: const Icon(Icons.check)),
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: leftRightMargin, vertical: xxTinierSpacing),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: xxxSmallestSpacing),
              child: BlocBuilder<ChatBloc, ChatState>(
                buildWhen: (previousState, currentState) =>
                    currentState is EmployeesFetched,
                builder: (context, state) {
                  if (state is EmployeesFetched) {
                    return TextFormField(
                        controller: textEditingController,
                        onChanged: (value) {
                          textEditingController.text = value;
                        },
                        decoration: InputDecoration(
                            suffix: const SizedBox(),
                            suffixIcon: CustomIconButton(
                              onPressed: () {
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                if (textEditingController.text != '' ||
                                    textEditingController.text.trim() != '') {
                                  context.read<ChatBloc>().isSearchEnabled =
                                      !context.read<ChatBloc>().isSearchEnabled;
                                  if (context
                                      .read<ChatBloc>()
                                      .isSearchEnabled) {
                                    pageNo = 1;
                                    context.read<ChatBloc>().employeeList = [];
                                    context
                                        .read<ChatBloc>()
                                        .employeeListReachedMax = false;
                                    sendMessageMap['user_name'] =
                                        textEditingController.text;
                                    context.read<ChatBloc>().add(FetchEmployees(
                                        pageNo: pageNo,
                                        searchedName:
                                            sendMessageMap['user_name']));
                                  } else {
                                    pageNo = 1;
                                    context.read<ChatBloc>().employeeList = [];
                                    context
                                        .read<ChatBloc>()
                                        .employeeListReachedMax = false;
                                    textEditingController.clear();
                                    context.read<ChatBloc>().add(FetchEmployees(
                                        pageNo: pageNo, searchedName: ''));
                                  }
                                }
                              },
                              icon: (context.read<ChatBloc>().isSearchEnabled ==
                                      false)
                                  ? Icons.search
                                  : Icons.clear,
                            ),
                            hintStyle: Theme.of(context)
                                .textTheme
                                .xSmall
                                .copyWith(color: AppColor.grey),
                            hintText: StringConstants.kSearch,
                            contentPadding:
                                const EdgeInsets.all(xxxTinierSpacing),
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.lightGrey)),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.lightGrey)),
                            filled: true,
                            fillColor: AppColor.white));
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
            BlocConsumer<ChatBloc, ChatState>(
                listener: (context, state) {
                  if (state is EmployeesFetched &&
                      context.read<ChatBloc>().employeeListReachedMax) {
                    showCustomSnackBar(
                        context, StringConstants.kAllDataLoaded, '');
                  }
                },
                buildWhen: (previousState, currentState) =>
                    (currentState is FetchingEmployees && pageNo == 1) ||
                    (currentState is EmployeesFetched),
                builder: (context, state) {
                  if (state is FetchingEmployees) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.sizeOf(context).width * 0.6),
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  } else if (state is EmployeesFetched) {
                    return Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount:
                            (context.read<ChatBloc>().employeeListReachedMax)
                                ? state.employeeList.length
                                : state.employeeList.length + 1,
                        itemBuilder: (context, index) {
                          if (state.employeeList.isNotEmpty) {
                            if (index < state.employeeList.length) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomCard(
                                    child: ListTile(
                                        leading: const Icon(Icons.person,
                                            color: AppColor.deepBlue),
                                        title: Text(
                                            state.employeeList[index].name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .xSmall),
                                        subtitle: Text(
                                            (state.employeeList[index].type ==
                                                    1)
                                                ? 'System User'
                                                : 'Workforce'),
                                        trailing: (isCreateNewGroup)
                                            ? ShowCheckBox(employeeDetailsMap: {
                                                'rid': state
                                                    .employeeList[index].id
                                                    .toString(),
                                                'employee_name': state
                                                    .employeeList[index].name
                                              }, chatData: chatData)
                                            : IconButton(
                                                onPressed: () {
                                                  ChatMessagingScreen
                                                      .chatDetailsMap = {
                                                    'rid': state
                                                        .employeeList[index].id
                                                        .toString(),
                                                    'employee_name': state
                                                        .employeeList[index]
                                                        .name,
                                                    'rtype': state
                                                        .employeeList[index]
                                                        .type
                                                        .toString(),
                                                    'isReceiver': 0
                                                  };
                                                  Navigator.pushNamed(
                                                      context,
                                                      ChatMessagingScreen
                                                          .routeName);
                                                },
                                                icon: const Icon(
                                                    Icons.message_outlined))),
                                  ),
                                  const SizedBox(height: xxTinierSpacing)
                                ],
                              );
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
                            return NoRecordsText(
                                text: DatabaseUtil.getText('no_records_found'));
                          }
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: xxxTiniestSpacing);
                        },
                      ),
                    );
                  } else if (state is EmployeesNotFetched) {
                    return NoRecordsText(text: state.errorMessage);
                  } else {
                    return const SizedBox.shrink();
                  }
                })
          ],
        ),
      ),
    );
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
  bool changedValue = false;

  void addOrRemoveMember(bool changedValue) {
    if (changedValue) {
      widget.chatData.members.add(Members(
          id: int.parse(widget.employeeDetailsMap['employee_id']),
          name: widget.employeeDetailsMap['employee_name'],
          type: 2,
          isOwner: 0));
    } else {
      widget.chatData.members.removeWhere((element) =>
          element.id == int.parse(widget.employeeDetailsMap['employee_id']));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        activeColor: AppColor.deepBlue,
        value: changedValue,
        onChanged: (bool? val) {
          setState(() {
            changedValue = val ?? false;
            addOrRemoveMember(changedValue);
          });
        });
  }
}
