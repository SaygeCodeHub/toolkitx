import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/chatBox/chat_box_bloc.dart';
import 'package:toolkit/blocs/chatBox/chat_box_event.dart';
import 'package:toolkit/blocs/chatBox/chat_box_state.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/chatBox/new_chat_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_no_records_text.dart';

import '../../configs/app_color.dart';

class FetchEmployeesScreen extends StatelessWidget {
  static const routeName = 'FetchEmployeesScreen';
  final Map sendMessageMap = {};

  FetchEmployeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ChatBoxBloc>().add(FetchEmployees());
    return Scaffold(
      appBar: const GenericAppBar(title: StringConstants.kEmployees),
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
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: state.fetchEmployeesModel.data.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return CustomCard(
                    child: ListTile(
                      leading:
                          const Icon(Icons.person, color: AppColor.deepBlue),
                      title: Text(state.fetchEmployeesModel.data[index].name,
                          style: Theme.of(context).textTheme.xSmall),
                      trailing: IconButton(
                          onPressed: () {
                            NewChatScreen.employeeDetailsMap = {
                              "employee_name":
                                  state.fetchEmployeesModel.data[index].name,
                              'employee_id':
                                  state.fetchEmployeesModel.data[index].id
                            };
                            Navigator.pushNamed(
                              context,
                              NewChatScreen.routeName,
                            );
                          },
                          icon: const Icon(Icons.message_outlined)),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: xxTinierSpacing);
                },
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
