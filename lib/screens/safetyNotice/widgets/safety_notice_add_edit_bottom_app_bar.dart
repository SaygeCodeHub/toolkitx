import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/safetyNotice/safety_notice_bloc.dart';
import '../../../blocs/safetyNotice/safety_notice_events.dart';
import '../../../blocs/safetyNotice/safety_notice_states.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/generic_loading_popup.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/progress_bar.dart';
import '../add_and_edit_safety_notice_screen.dart';
import '../safety_notice_screen.dart';

class SafetyNoticeAddAndEditBottomAppBar extends StatelessWidget {
  final Map manageSafetyNoticeMap;

  const SafetyNoticeAddAndEditBottomAppBar(
      {Key? key, required this.manageSafetyNoticeMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: [
          Expanded(
              child: PrimaryButton(
            onPressed: () {
              Navigator.pop(context);
            },
            textValue: DatabaseUtil.getText('buttonBack'),
          )),
          const SizedBox(width: xxTinierSpacing),
          BlocListener<SafetyNoticeBloc, SafetyNoticeStates>(
            listener: (context, state) {
              if (state is AddingSafetyNotice) {
                ProgressBar.show(context);
              } else if (state is SafetyNoticeAdded) {
                ProgressBar.dismiss(context);
                if (manageSafetyNoticeMap['file_name'] == null) {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(
                      context, SafetyNoticeScreen.routeName,
                      arguments: false);
                }
              } else if (state is SafetyNoticeNotAdded) {
                ProgressBar.dismiss(context);
                showCustomSnackBar(context, state.errorMessage, '');
              }
              if (state is SavingSafetyNoticeFiles) {
                GenericLoadingPopUp.show(context, StringConstants.kUploadFiles);
              } else if (state is SafetyNoticeFilesSaved) {
                GenericLoadingPopUp.dismiss(context);
                Navigator.pop(context);
                Navigator.pushReplacementNamed(
                    context, SafetyNoticeScreen.routeName,
                    arguments: false);
              } else if (state is SafetyNoticeFilesNotSaved) {
                GenericLoadingPopUp.dismiss(context);
                showCustomSnackBar(context, state.filesNotSaved, '');
              }
              if (state is UpdatingSafetyNotice) {
                ProgressBar.show(context);
              } else if (state is SafetyNoticeUpdated) {
                ProgressBar.dismiss(context);
                if (manageSafetyNoticeMap['file_name'] == null) {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(
                      context, SafetyNoticeScreen.routeName,
                      arguments: false);
                }
              } else if (state is SafetyNoticeCouldNotUpdate) {
                ProgressBar.dismiss(context);
                showCustomSnackBar(context, state.noticeNotUpdated, '');
              }
            },
            child: Expanded(
                child: PrimaryButton(
                    onPressed: () {
                      if (AddAndEditSafetyNoticeScreen.isFromEditOption ==
                          true) {
                        context.read<SafetyNoticeBloc>().add(UpdateSafetyNotice(
                            updateSafetyNoticeMap: manageSafetyNoticeMap));
                      } else {
                        context.read<SafetyNoticeBloc>().add(AddSafetyNotice(
                            addSafetyNoticeMap: manageSafetyNoticeMap));
                      }
                    },
                    textValue: DatabaseUtil.getText('Save'))),
          )
        ],
      ),
    );
  }
}