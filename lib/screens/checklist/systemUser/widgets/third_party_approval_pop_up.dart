import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/thirdPartyApprove/sys_user_checklist_third_party_approve_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/thirdPartyApprove/sys_user_checklist_third_party_approve_events.dart';
import 'package:toolkit/blocs/checklist/systemUser/thirdPartyApprove/sys_user_checklist_third_party_approve_states.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/profile/widgets/signature.dart';
import '../../../../blocs/checklist/systemUser/scheduleDates/sys_user_checklist_schedule_dates_bloc.dart';
import '../../../../configs/app_color.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../widgets/custom_snackbar.dart';
import '../../../../widgets/generic_text_field.dart';
import '../../../../widgets/progress_bar.dart';
import '../../../../widgets/text_button.dart';
import '../sys_user_schedule_dates_screen.dart';

class ThirdPartyApprovePopUp extends StatelessWidget {
  final String textValue;
  final List responseIdList;

  ThirdPartyApprovePopUp(
      {Key? key, required this.textValue, required this.responseIdList})
      : super(key: key);
  final Map thirdPartyApproveMap = {};

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckListThirdPartyApproveBloc,
            CheckListThirdPartyApproveStates>(
        listener: (BuildContext context, state) {
          if (state is CheckListThirdPartyApproving) {
            ProgressBar.show(context);
          } else if (state is CheckListThirdPartyApproved) {
            ProgressBar.dismiss(context);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pushReplacementNamed(
                context, SystemUserScheduleDatesScreen.routeName,
                arguments:
                    context.read<CheckListScheduleDatesBloc>().checklistId);
          } else if (state is CheckListThirdPartyNotApproved) {
            ProgressBar.dismiss(context);
            showCustomSnackBar(context, state.errorMessage, '');
          }
        },
        child: AlertDialog(
            titlePadding: const EdgeInsets.only(
                left: tinySpacing, top: tinySpacing, right: tinySpacing),
            buttonPadding: const EdgeInsets.all(tiniestSpacing),
            contentPadding: const EdgeInsets.only(
                left: xxTinySpacing,
                right: xxTinySpacing,
                top: xxTinySpacing,
                bottom: 0),
            actionsPadding: const EdgeInsets.only(
                right: xxTinySpacing, bottom: tiniestSpacing),
            title:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Enter your name',
                      style: Theme.of(context)
                          .textTheme
                          .small
                          .copyWith(color: AppColor.black)),
                  IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close_outlined, size: kIconSize))
                ],
              ),
              const SizedBox(height: xxTinierSpacing),
              TextFieldWidget(
                  textInputAction: TextInputAction.done,
                  maxLength: 50,
                  onTextFieldChanged: (String textValue) {
                    thirdPartyApproveMap["name"] = textValue;
                  }),
              const SizedBox(height: xxTinierSpacing),
              SignaturePad(map: thirdPartyApproveMap, mapKey: 'sign_text'),
            ]),
            actions: [
              CustomTextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  textValue: StringConstants.kRemove),
              CustomTextButton(
                  onPressed: () {
                    context.read<CheckListThirdPartyApproveBloc>().add(
                        ThirdPartyApproveCheckListEvent(
                            thirdPartyApproveMap: thirdPartyApproveMap,
                            responseIdList: responseIdList));
                  },
                  textValue: textValue)
            ]));
  }
}
