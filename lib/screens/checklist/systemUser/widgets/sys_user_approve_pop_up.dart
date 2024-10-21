import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/scheduleDates/sys_user_checklist_schedule_dates_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import 'package:toolkit/widgets/text_button.dart';
import '../../../../blocs/checklist/systemUser/approve/sys_user_approve_checklist_bloc.dart';
import '../../../../blocs/checklist/systemUser/approve/sys_user_approve_checklist_events.dart';
import '../../../../blocs/checklist/systemUser/approve/sys_user_approve_checklist_states.dart';
import '../../../../configs/app_color.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../widgets/custom_snackbar.dart';
import '../../../../widgets/generic_text_field.dart';
import '../sys_user_schedule_dates_screen.dart';

class ApprovePopUp extends StatelessWidget {
  final String textValue;
  final List responseIdList;
  final Map approveMap = {};

  ApprovePopUp(
      {super.key, required this.textValue, required this.responseIdList});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckListApproveBloc, CheckListApproveStates>(
        listener: (BuildContext context, state) {
          if (state is ApprovingCheckList) {
            ProgressBar.show(context);
          } else if (state is CheckListApproved) {
            ProgressBar.dismiss(context);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pushReplacementNamed(
                context, SystemUserScheduleDatesScreen.routeName,
                arguments:
                    context.read<CheckListScheduleDatesBloc>().checklistId);
          } else if (state is CheckListNotApproved) {
            ProgressBar.dismiss(context);
            showCustomSnackBar(context, state.errorMessage, '');
          }
        },
        child: AlertDialog(
            titlePadding:
                const EdgeInsets.only(left: tinySpacing, top: tinySpacing),
            buttonPadding: const EdgeInsets.all(tiniestSpacing),
            contentPadding: const EdgeInsets.only(
                left: xxTinySpacing,
                right: xxTinySpacing,
                top: xxTinySpacing,
                bottom: 0),
            actionsPadding: const EdgeInsets.only(
                right: xxTinySpacing, bottom: xxTinySpacing),
            title: Text(StringConstants.kComments,
                style: Theme.of(context)
                    .textTheme
                    .small
                    .copyWith(color: AppColor.black)),
            content: TextFieldWidget(
                maxLength: 250,
                textInputAction: TextInputAction.done,
                onTextFieldChanged: (String textValue) {
                  approveMap["comment"] = textValue;
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
                    context.read<CheckListApproveBloc>().add(
                        ApproveCheckListEvent(
                            approveMap: approveMap,
                            responseIdList: responseIdList));
                  },
                  textValue: textValue)
            ]));
  }
}
