import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/android_pop_up.dart';

import '../../blocs/safetyNotice/safety_notice_bloc.dart';
import '../../blocs/safetyNotice/safety_notice_events.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';
import 'add_and_edit_safety_notice_screen.dart';

class SafetyNoticePopUpMenuScreen extends StatelessWidget {
  static const routeName = 'SafetyNoticePopUpMenuScreen';
  final List popUpMenuOptionsList;
  static Map safetyNoticeDetailsMap = {};

  const SafetyNoticePopUpMenuScreen(
      {Key? key, required this.popUpMenuOptionsList})
      : super(key: key);

  PopupMenuItem _buildPopupMenuItem(context, String title, String position) {
    return PopupMenuItem(
        value: position,
        child: Text(title, style: Theme.of(context).textTheme.xSmall));
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kCardRadius)),
      iconSize: kIconSize,
      icon: const Icon(Icons.more_vert_outlined),
      offset: const Offset(0, xxTinierSpacing),
      onSelected: (value) {
        if (value == DatabaseUtil.getText('Edit')) {
          AddAndEditSafetyNoticeScreen.isFromEditOption = true;
          AddAndEditSafetyNoticeScreen.manageSafetyNoticeMap =
              safetyNoticeDetailsMap;
          Navigator.pushNamed(context, AddAndEditSafetyNoticeScreen.routeName);
        }
        if (value == DatabaseUtil.getText('Issue')) {
          showDialog(
              context: context,
              builder: (context) {
                return AndroidPopUp(
                    titleValue: StringConstants.kSafetyNoticeIssue,
                    contentValue: '',
                    onPrimaryButton: () {
                      context.read<SafetyNoticeBloc>().add(IssueSafetyNotice());
                      Navigator.pop(context);
                    });
              });
        }
        if (value == DatabaseUtil.getText('Hold')) {
          showDialog(
              context: context,
              builder: (context) {
                return AndroidPopUp(
                    titleValue: StringConstants.kSafetyNoticeHold,
                    contentValue: '',
                    onPrimaryButton: () {
                      context.read<SafetyNoticeBloc>().add(HoldSafetyNotice());
                      Navigator.pop(context);
                    });
              });
        }
        if (value == DatabaseUtil.getText('Cancel')) {
          showDialog(
              context: context,
              builder: (context) {
                return AndroidPopUp(
                    titleValue: StringConstants.kSafetyNoticeCancel,
                    contentValue: '',
                    onPrimaryButton: () {
                      context
                          .read<SafetyNoticeBloc>()
                          .add(CancelSafetyNotice());
                      Navigator.pop(context);
                    });
              });
        }
        if (value == DatabaseUtil.getText('Close')) {
          showDialog(
              context: context,
              builder: (context) {
                return AndroidPopUp(
                    titleValue: StringConstants.kSafetyNoticeClose,
                    contentValue: '',
                    onPrimaryButton: () {
                      context.read<SafetyNoticeBloc>().add(CloseSafetyNotice());
                      Navigator.pop(context);
                    });
              });
        }
        if (value == DatabaseUtil.getText('ReIssue')) {
          showDialog(
              context: context,
              builder: (context) {
                return AndroidPopUp(
                    titleValue: StringConstants.kSafetyNoticeReissue,
                    contentValue: '',
                    onPrimaryButton: () {
                      context
                          .read<SafetyNoticeBloc>()
                          .add(ReIssueSafetyNotice());
                      Navigator.pop(context);
                    });
              });
        }
      },
      position: PopupMenuPosition.under,
      itemBuilder: (BuildContext context) => [
        for (int i = 0; i < popUpMenuOptionsList.length; i++)
          _buildPopupMenuItem(
              context, popUpMenuOptionsList[i], popUpMenuOptionsList[i])
      ],
    );
  }
}
