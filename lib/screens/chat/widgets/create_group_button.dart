import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../blocs/chat/chat_bloc.dart';
import '../../../blocs/chat/chat_event.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/generic_text_field.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/secondary_button.dart';
import '../users_screen.dart';

class CreateGroupButton extends StatelessWidget {
  const CreateGroupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SecondaryButtonIcon(
        width: kAddChatGroupButtonWidth,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                    actions: [
                      SizedBox(
                          height: kCreateGroupDialogHeight,
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
                                  showCustomSnackBar(context,
                                      StringConstants.kEnterGroupName, '');
                                } else {
                                  Navigator.pop(context);
                                  context
                                      .read<ChatBloc>()
                                      .add(InitializeGroupChatMembers());
                                  Navigator.pushNamed(
                                      context, UsersScreen.routeName,
                                      arguments: true);
                                }
                              },
                              textValue: StringConstants.kSelectMembers))
                    ],
                    actionsAlignment: MainAxisAlignment.center,
                    actionsPadding: const EdgeInsets.symmetric(
                        vertical: tinySpacing, horizontal: xxxTinierSpacing),
                    contentTextStyle: Theme.of(context).textTheme.xSmall,
                    titlePadding: EdgeInsets.zero,
                    title: Container(
                        height: kCreateGroupTitleHeight,
                        color: AppColor.blueGrey,
                        child: Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.close)))),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: xxxTinySpacing, horizontal: tinierSpacing),
                    content: SizedBox(
                        height: kCreateGroupContentHeight,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(StringConstants.kGroupName,
                                  style: Theme.of(context).textTheme.xSmall),
                              const SizedBox(height: xxTinierSpacing),
                              TextFieldWidget(
                                  onTextFieldChanged: (String textValue) {
                                context
                                    .read<ChatBloc>()
                                    .groupDataMap['group_name'] = textValue;
                              }),
                              const SizedBox(height: tinySpacing),
                              Text(StringConstants.kGroupPurpose,
                                  style: Theme.of(context).textTheme.xSmall),
                              const SizedBox(height: xxTinierSpacing),
                              TextFieldWidget(
                                  maxLength: 255,
                                  onTextFieldChanged: (String textValue) {
                                    context
                                            .read<ChatBloc>()
                                            .groupDataMap['group_purpose'] =
                                        textValue;
                                  })
                            ])));
              });
        },
        textValue: StringConstants.kAddNewGroup,
        icon: const Icon(Icons.add),
        iconAlignment: IconAlignment.start);
  }
}
