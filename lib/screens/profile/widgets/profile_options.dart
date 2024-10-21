import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/profile_util.dart';
import '../../../widgets/in_app_web_view.dart';
import '../../onboarding/select_language_screen.dart';
import '../../onboarding/select_date_format_screen.dart';
import '../../onboarding/select_time_zone_screen.dart';
import '../select_change_password_screen.dart';

class ProfileOptions extends StatelessWidget {
  const ProfileOptions({super.key});

  void profileOptionsSwitchCase(context, index) async {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, SelectChangePasswordTypeScreen.routeName);
        break;
      case 1:
        Navigator.pushNamed(context, SelectLanguageScreen.routeName,
            arguments: true);
        break;
      case 2:
        Navigator.pushNamed(context, SelectTimeZoneScreen.routeName,
            arguments: true);
        break;
      case 3:
        Navigator.pushNamed(context, SelectDateFormatScreen.routeName,
            arguments: true);
        break;
      case 4:
        await launchUrl(Uri.parse("mailto:${StringConstants.kToolkitXEmail}"));
        break;
      case 5:
        Navigator.pushNamed(context, InAppWebViewScreen.routeName,
            arguments: StringConstants.kPrivacyPolicyUrl);
        break;
      case 6:
        Navigator.pushNamed(context, InAppWebViewScreen.routeName,
            arguments: StringConstants.kMaturityModelUrl);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(children: [
              const SizedBox(height: xxTiniestSpacing),
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: ProfileUtil.profileOptionsList().length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        contentPadding: EdgeInsets.zero,
                        horizontalTitleGap: 0.0,
                        leading: Image.asset(
                            ProfileUtil.profileOptionsList()
                                .elementAt(index)
                                .image,
                            height: kProfileImageHeight,
                            width: kProfileImageWidth),
                        title: Text(
                            ProfileUtil.profileOptionsList()
                                .elementAt(index)
                                .title,
                            style: Theme.of(context).textTheme.xSmall),
                        onTap: () async {
                          profileOptionsSwitchCase(context, index);
                        });
                  }),
              const SizedBox(height: xxxMediumSpacing),
              Center(
                  child: Text(
                      "${StringConstants.kAppVersion} ${ProfileUtil.packageInfo.version}",
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(color: AppColor.grey)))
            ])));
  }
}
