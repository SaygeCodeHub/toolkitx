import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/chat/chat_bloc.dart';
import 'package:toolkit/blocs/chat/chat_event.dart';
import 'package:toolkit/blocs/chat/chat_state.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/chat/widgets/add_new_chat_member_button.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

class AddNewMemberSearchField extends StatelessWidget {
  const AddNewMemberSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        color: AppColor.blueGrey,
        child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: tiniestSpacing, horizontal: xxxTinierSpacing),
            child: BlocBuilder<ChatBloc, ChatState>(
                buildWhen: (previousState, currentState) =>
                    currentState is EmployeesFetched,
                builder: (context, state) {
                  if (state is EmployeesFetched) {
                    return Row(children: [
                      SizedBox(
                          width: 260,
                          child: TextFormField(
                              controller:
                                  AddNewChatMemberButton.textEditingController,
                              decoration: InputDecoration(
                                  suffix: const SizedBox(),
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .xSmall
                                      .copyWith(color: AppColor.grey),
                                  hintText: StringConstants.kSearch,
                                  contentPadding:
                                      const EdgeInsets.all(xxxTinierSpacing),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColor.lightGrey)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColor.lightGrey)),
                                  filled: true,
                                  fillColor: AppColor.white))),
                      SizedBox(
                          width: 20,
                          child: IconButton(
                              onPressed: () {
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                String searchText = AddNewChatMemberButton
                                    .textEditingController.text
                                    .trim();
                                if (searchText.isNotEmpty) {
                                  context.read<ChatBloc>().isSearchEnabled =
                                      true;
                                  AddNewChatMemberButton.pageNo = 1;
                                  context.read<ChatBloc>().employeeList.clear();
                                  context
                                      .read<ChatBloc>()
                                      .employeeListReachedMax = false;
                                  AddNewChatMemberButton.userName = searchText;
                                  context.read<ChatBloc>().add(FetchEmployees(
                                      pageNo: AddNewChatMemberButton.pageNo,
                                      searchedName:
                                          AddNewChatMemberButton.userName));
                                }
                              },
                              icon: const Icon(Icons.search)))
                    ]);
                  } else {
                    return const SizedBox.shrink();
                  }
                })));
  }
}
