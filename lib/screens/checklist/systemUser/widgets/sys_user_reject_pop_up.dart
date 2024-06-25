import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../../blocs/checklist/systemUser/reject/sys_user_reject_checklist_bloc.dart';
import '../../../../blocs/checklist/systemUser/reject/sys_user_reject_checklist_events.dart';
import '../../../../blocs/checklist/systemUser/reject/sys_user_reject_checklist_states.dart';
import '../../../../blocs/checklist/systemUser/scheduleDates/sys_user_checklist_schedule_dates_bloc.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../widgets/custom_snackbar.dart';
import '../../../../widgets/generic_text_field.dart';
import '../../../../widgets/progress_bar.dart';
import '../../../../widgets/text_button.dart';
import '../sys_user_schedule_dates_screen.dart';

class RejectPopUp extends StatelessWidget {
  final String textValue;
  final List responseIdList;
  final Map rejectMap = {};

  RejectPopUp({Key? key, required this.textValue, required this.responseIdList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<RejectCheckListBloc, RejectCheckListStates>(
        listener: (BuildContext context, state) {
          if (state is RejectingCheckList) {
            ProgressBar.show(context);
          } else if (state is CheckListRejected) {
            ProgressBar.dismiss(context);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pushReplacementNamed(
                context, SystemUserScheduleDatesScreen.routeName,
                arguments:
                    context.read<CheckListScheduleDatesBloc>().checklistId);
          } else if (state is CheckListNotRejected) {
            ProgressBar.dismiss(context);
            showCustomSnackBar(context, state.errorMessage, '');
          }
        },
        child: AlertDialog(
            titlePadding:
                const EdgeInsets.only(left: tinySpacing, top: tinySpacing),
            buttonPadding: const EdgeInsets.all(tiniestSpacing),
            contentPadding: const EdgeInsets.only(
                left: xxTinierSpacing,
                right: xxTinierSpacing,
                top: xxTinierSpacing,
                bottom: 0),
            actionsPadding: const EdgeInsets.only(
                right: xxTinierSpacing, bottom: tiniestSpacing),
            title: Text(StringConstants.kComments,
                style: Theme.of(context)
                    .textTheme
                    .small
                    .copyWith(color: AppColor.black)),
            content: TextFieldWidget(
                textInputAction: TextInputAction.done,
                maxLength: 250,
                onTextFieldChanged: (String textValue) {
                  rejectMap["comment"] = textValue;
                },
                maxLines: 7),
            titleTextStyle: Theme.of(context)
                .textTheme
                .large
                .copyWith(fontWeight: FontWeight.w500),
            actions: [
              CustomTextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  textValue: StringConstants.kRemove),
              CustomTextButton(
                  onPressed: () {
                    context.read<RejectCheckListBloc>().add(
                        RejectCheckListEvent(
                            rejectMap: rejectMap,
                            responseIdList: responseIdList));
                  },
                  textValue: textValue)
            ]));
  }
}
