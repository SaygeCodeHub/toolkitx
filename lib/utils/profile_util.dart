import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../configs/app_spacing.dart';
import '../data/models/profile/profile_options_model.dart';
import '../widgets/text_button.dart';

abstract class ProfileUtil {
  static const String iconPath = 'assets/icons/';
  static const String imagePath = 'assets/images/';
  static late PackageInfo packageInfo;

  static List<ProfileOptions> profileOptionsList() {
    return [
      ProfileOptions(
          title: StringConstants.kChangePassword,
          image: "${iconPath}reset-password.png"),
      ProfileOptions(
          title: DatabaseUtil.getText('LanguageTanslate'),
          image: "${iconPath}languages.png"),
      ProfileOptions(
          title: DatabaseUtil.getText('changetimezone'),
          image: "${iconPath}time_zone.png"),
      ProfileOptions(
          title: DatabaseUtil.getText('changedateformat'),
          image: "${iconPath}calendar.png"),
      ProfileOptions(
          title: DatabaseUtil.getText('MailUs'), image: "${iconPath}email.png"),
      ProfileOptions(
          title: DatabaseUtil.getText('PrivacyPolicies'),
          image: "${iconPath}compliant.png"),
      ProfileOptions(
          title: DatabaseUtil.getText('MaturityModel'),
          image: "${iconPath}shield.png")
    ];
  }

  static Future<bool> showExitPopup(map1, map2, context) async {
    if (!mapEquals(map1, map2)) {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                StringConstants.kDiscardChanges,
                style: Theme.of(context).textTheme.large,
              ),
              titlePadding: const EdgeInsets.fromLTRB(smallestSpacing,
                  smallestSpacing, smallestSpacing, xxxTinierSpacing),
              actionsPadding: const EdgeInsets.only(
                  left: xxTinySpacing, bottom: xxTiniestSpacing),
              actionsAlignment: MainAxisAlignment.start,
              actions: [
                CustomTextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  textValue: StringConstants.kCancel,
                ),
                CustomTextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  textValue: StringConstants.kDiscard,
                ),
              ],
            ),
          ) ??
          false;
    } else {
      Navigator.pop(context);
    }
    return false;
  }
}
