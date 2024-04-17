import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/di/app_module.dart';
import 'package:toolkit/screens/chat/employees_screen.dart';
import 'package:toolkit/screens/chat/widgets/chat_data_model.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../../blocs/chat/chat_bloc.dart';

class ChatPopUpMenu extends StatelessWidget {
  final ChatData chatData = getIt<ChatData>();

  ChatPopUpMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(itemBuilder: (context) {
      return [
        PopupMenuItem(
          value: 'option1',
          child: Text('New group', style: Theme.of(context).textTheme.xxSmall),
          onTap: () {
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
                                          .groupDataMap['group_name'] ==
                                      null ||
                                  context
                                          .read<ChatBloc>()
                                          .groupDataMap['group_name'] ==
                                      '') {
                                showCustomSnackBar(
                                    context, 'Please enter group name!', '');
                              } else {
                                Navigator.pop(context);
                                context
                                        .read<ChatBloc>()
                                        .groupDataMap['members'] =
                                    <Map<String, dynamic>>[
                                  {
                                    'id': int.parse(context
                                        .read<ChatBloc>()
                                        .groupDataMap['user_id']),
                                    'type': int.parse(context
                                        .read<ChatBloc>()
                                        .groupDataMap['user_type']),
                                    'name': context
                                        .read<ChatBloc>()
                                        .groupDataMap['user_name'],
                                    'isowner': 1
                                  }
                                ];
                                Navigator.pushNamed(
                                    context, EmployeesScreen.routeName,
                                    arguments: true);
                              }
                            },
                            textValue: 'Click to select members'),
                      )
                    ],
                    actionsAlignment: MainAxisAlignment.center,
                    actionsPadding: const EdgeInsets.symmetric(
                        vertical: tinySpacing, horizontal: xxxTinierSpacing),
                    contentTextStyle: Theme.of(context).textTheme.xSmall,
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
                            icon: const Icon(Icons.close)),
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: xxxTinySpacing, horizontal: tinierSpacing),
                    content: SizedBox(
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Name of Group',
                              style: Theme.of(context).textTheme.xSmall),
                          const SizedBox(height: xxTinierSpacing),
                          TextFieldWidget(
                              onTextFieldChanged: (String textValue) {
                            context
                                .read<ChatBloc>()
                                .groupDataMap['group_name'] = textValue;
                          }),
                          const SizedBox(height: tinySpacing),
                          Text('Purpose of the Group',
                              style: Theme.of(context).textTheme.xSmall),
                          const SizedBox(height: xxTinierSpacing),
                          TextFieldWidget(
                              onTextFieldChanged: (String textValue) {
                            context
                                .read<ChatBloc>()
                                .groupDataMap['group_purpose'] = textValue;
                          }),
                        ],
                      ),
                    ),
                  );
                });
          },
        )
      ];
    });
  }
}
