import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/todo/todo_bloc.dart';
import 'package:toolkit/blocs/todo/todo_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import '../../blocs/todo/todo_event.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/primary_button.dart';
import 'widgets/todo_settings_send_mail_expansion_tile.dart';
import 'widgets/todo_settings_send_notification_expansion_tile.dart';

class ToDoSettingsScreen extends StatelessWidget {
  static const routeName = 'ToDoSettingsScreen';
  final Map todoMap;

  const ToDoSettingsScreen({super.key, required this.todoMap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('Settings')),
      bottomNavigationBar: BottomAppBar(
        child: BlocListener<ToDoBloc, ToDoStates>(
          listener: (context, state) {
            if (state is SavingToDoSettings) {
              ProgressBar.show(context);
            } else if (state is ToDoSettingsSaved) {
              ProgressBar.dismiss(context);
              Navigator.pop(context);
              context
                  .read<ToDoBloc>()
                  .add(FetchTodoAssignedToMeAndByMeListEvent());
            } else if (state is ToDoSettingsNotSaved) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.settingsNotSaved, '');
            }
          },
          child: PrimaryButton(
              onPressed: () {
                context
                    .read<ToDoBloc>()
                    .add(SaveToDoSettings(todoMap: todoMap));
              },
              textValue: DatabaseUtil.getText('buttonSave')),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(DatabaseUtil.getText('SendemailafterToDoassigned'),
                style: Theme.of(context)
                    .textTheme
                    .xSmall
                    .copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: xxxTinierSpacing),
            ToDoSettingsSendMailExpansionTile(todoMap: todoMap),
            const SizedBox(height: xxTinySpacing),
            Text(DatabaseUtil.getText('SendnotificationafterToDocompleted'),
                style: Theme.of(context)
                    .textTheme
                    .xSmall
                    .copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: xxxTinierSpacing),
            ToDoSettingsSendNotificationExpansionTile(todoMap: todoMap)
          ],
        ),
      ),
    );
  }
}
