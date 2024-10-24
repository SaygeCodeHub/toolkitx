import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/chat/chat_bloc.dart';
import 'package:toolkit/blocs/chat/chat_event.dart';
import 'package:toolkit/blocs/chat/chat_state.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/chat/widgets/add_new_member_search_field.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/android_pop_up.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/secondary_button.dart';
import 'chat_member_checkbox_tile.dart';

class AddNewChatMemberButton extends StatelessWidget {
  const AddNewChatMemberButton({super.key, required this.groupId});

  final String groupId;

  static TextEditingController textEditingController = TextEditingController();
  static bool isSearchEnabled = false;
  static int pageNo = 1;
  static String userName = '';

  @override
  Widget build(BuildContext context) {
    userName = '';
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

    List selectedEmployeeList = [];
    return SecondaryButtonIcon(
        width: kAddChatGroupButtonWidth,
        onPressed: () {
          context
              .read<ChatBloc>()
              .add(FetchEmployees(pageNo: pageNo, searchedName: ''));
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                    actions: [
                      SizedBox(
                          height: kCreateGroupDialogHeight,
                          child: BlocListener<ChatBloc, ChatState>(
                            listener: (context, state) {
                              if (state is ChatMemberAdding) {
                                ProgressBar.show(context);
                              } else if (state is ChatMemberAdded) {
                                ProgressBar.dismiss(context);
                                Navigator.pop(context);
                                context
                                    .read<ChatBloc>()
                                    .add(FetchGroupDetails(groupId: groupId));
                              } else if (state is ChatMemberNotAdded) {
                                ProgressBar.dismiss(context);
                                showDialog(
                                    context: context,
                                    builder: (context) => AndroidPopUp(
                                          titleValue: '',
                                          contentValue: state.errorMessage,
                                          textValue: DatabaseUtil.getText('OK'),
                                          isNoVisible: false,
                                          onPrimaryButton: () {
                                            Navigator.pop(context);
                                          },
                                        ));
                              }
                            },
                            child: PrimaryButton(
                                onPressed: () {
                                  context.read<ChatBloc>().add(AddChatMember(
                                      groupId: groupId,
                                      membersList: selectedEmployeeList));
                                },
                                textValue:
                                    DatabaseUtil.getText('add_new_member')),
                          ))
                    ],
                    actionsAlignment: MainAxisAlignment.center,
                    actionsPadding: const EdgeInsets.symmetric(
                        vertical: tinySpacing, horizontal: xxxTinierSpacing),
                    contentTextStyle: Theme.of(context).textTheme.xSmall,
                    titlePadding: EdgeInsets.zero,
                    title: const AddNewMemberSearchField(),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: xxxTinySpacing, horizontal: tinierSpacing),
                    content: BlocConsumer<ChatBloc, ChatState>(
                      listener: (context, state) {
                        if (state is EmployeesFetched &&
                            context.read<ChatBloc>().employeeListReachedMax) {
                          const Center(
                              child: Text(StringConstants.kNoDataFound));
                        }
                      },
                      buildWhen: (previousState, currentState) =>
                          (currentState is FetchingEmployees && pageNo == 1) ||
                          (currentState is EmployeesFetched),
                      builder: (context, state) {
                        if (state is FetchingEmployees) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is EmployeesFetched) {
                          return SizedBox(
                            width: 200,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: (context
                                      .read<ChatBloc>()
                                      .employeeListReachedMax)
                                  ? state.employeeList.length
                                  : state.employeeList.length + 1,
                              itemBuilder: (context, index) {
                                if (index < state.employeeList.length) {
                                  return ChatMemberCheckBoxTile(
                                    employeesDatum: state.employeeList[index],
                                    selectedEmployeeList: selectedEmployeeList,
                                  );
                                } else {
                                  pageNo++;
                                  context.read<ChatBloc>().add(FetchEmployees(
                                      pageNo: pageNo, searchedName: userName));
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              },
                            ),
                          );
                        } else if (state is EmployeesNotFetched) {
                          return const Center(
                              child: Text(StringConstants.kNoDataFound));
                        }
                        return const SizedBox.shrink();
                      },
                    ));
              });
        },
        textValue: DatabaseUtil.getText('add_new_member'),
        icon: const Icon(Icons.add),
        iconAlignment: IconAlignment.start);
  }
}
