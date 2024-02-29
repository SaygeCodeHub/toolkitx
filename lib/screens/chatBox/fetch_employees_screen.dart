import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:toolkit/blocs/chatBox/chat_box_bloc.dart';
import 'package:toolkit/blocs/chatBox/chat_box_event.dart';
import 'package:toolkit/blocs/chatBox/chat_box_state.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/chatBox/fetch_employees_model.dart';
import 'package:toolkit/di/app_module.dart';
import 'package:toolkit/screens/chatBox/chat_box_screen.dart';
import 'package:toolkit/screens/chatBox/new_chat_screen.dart';
import 'package:toolkit/screens/chatBox/widgets/chat_data_model.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/android_pop_up.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_no_records_text.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../configs/app_color.dart';

class FetchEmployeesScreen extends StatelessWidget {
  static const routeName = 'FetchEmployeesScreen';
  final bool isCreateNewGroup;
  final Map sendMessageMap = {};
  final ChatData newGroupDetails = getIt<ChatData>();

  FetchEmployeesScreen({super.key, this.isCreateNewGroup = false});

  @override
  Widget build(BuildContext context) {
    print('chat----->${newGroupDetails.groupName}');
    context.read<ChatBoxBloc>().add(FetchEmployees());
    return Scaffold(
      appBar: const GenericAppBar(title: StringConstants.kEmployees),
      floatingActionButton: (isCreateNewGroup)
          ? BlocListener<ChatBoxBloc, ChatBoxState>(
              listener: (context, state) {
                if (state is CreatingChatGroup) {
                  ProgressBar.show(context);
                } else if (state is ChatGroupCreated) {
                  ProgressBar.dismiss(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  // Navigator.pushReplacementNamed(
                  //     context, ChatBoxScreen.routeName);
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
                                context
                                    .read<ChatBoxBloc>()
                                    .add(CreateChatGroup());
                                Navigator.pop(context);
                              });
                        });
                  },
                  child: const Icon(Icons.check)),
            )
          : null,
      body: BlocBuilder<ChatBoxBloc, ChatBoxState>(
        buildWhen: (previousState, currentState) =>
            currentState is FetchingEmployees ||
            currentState is EmployeesFetched ||
            currentState is EmployeesNotFetched,
        builder: (context, state) {
          if (state is FetchingEmployees) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EmployeesFetched) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: leftRightMargin, vertical: xxTinierSpacing),
              child: SearchableList(
                autoFocusOnSearch: false,
                closeKeyboardWhenScrolling: true,
                initialList: state.fetchEmployeesModel.data,
                builder: (List<EmployeesDatum> employeesList, index,
                    EmployeesDatum datum) {
                  return CustomCard(
                    child: ListTile(
                        leading:
                            const Icon(Icons.person, color: AppColor.deepBlue),
                        title: Text(datum.name,
                            style: Theme.of(context).textTheme.xSmall),
                        trailing: (isCreateNewGroup)
                            ? ShowCheckBox(employeeDetailsMap: {
                                'employee_id': datum.id,
                                'employee_name': datum.name
                              }, newGroupDetails: newGroupDetails)
                            : IconButton(
                                onPressed: () {
                                  NewChatScreen.employeeDetailsMap = {
                                    "employee_name": datum.name,
                                    'employee_id': datum.id
                                  };
                                  Navigator.pushNamed(
                                    context,
                                    NewChatScreen.routeName,
                                  );
                                },
                                icon: const Icon(Icons.message_outlined))),
                  );
                },
                emptyWidget: Text(DatabaseUtil.getText('no_records_found')),
                filter: (value) => state.fetchEmployeesModel.data
                    .where((element) => element.name
                        .toLowerCase()
                        .contains(value.toLowerCase().trim()))
                    .toList(),
                inputDecoration: InputDecoration(
                    suffix: const SizedBox(),
                    suffixIcon: const Icon(Icons.search_sharp, size: kIconSize),
                    hintText: 'Search employee',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(color: AppColor.grey),
                    contentPadding: const EdgeInsets.all(xxxTinierSpacing),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.lightGrey)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.lightGrey)),
                    filled: true,
                    fillColor: AppColor.white),
              ),
            );
          } else if (state is EmployeesNotFetched) {
            return NoRecordsText(text: state.errorMessage);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class ShowCheckBox extends StatefulWidget {
  final Map employeeDetailsMap;
  final ChatData newGroupDetails;

  const ShowCheckBox(
      {super.key,
      required this.employeeDetailsMap,
      required this.newGroupDetails});

  @override
  State<ShowCheckBox> createState() => _ShowCheckBoxState();
}

class _ShowCheckBoxState extends State<ShowCheckBox> {
  bool changedValue = false;

  void addOrRemoveMember(bool changedValue) {
    if (changedValue) {
      widget.newGroupDetails.members.add(Members(
          id: int.parse(widget.employeeDetailsMap['employee_id']),
          name: widget.employeeDetailsMap['employee_name'],
          type: 2,
          isOwner: 0));
    } else {
      widget.newGroupDetails.members.removeWhere((element) =>
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
