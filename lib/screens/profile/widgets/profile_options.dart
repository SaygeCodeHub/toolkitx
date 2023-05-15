import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/onboarding/selectLanguage/select_language_screen.dart';
import 'package:toolkit/screens/onboarding/selectTimeZone/select_time_zone_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/profile_util.dart';
import '../../onboarding/selectDateFormat/select_date_format_screen.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileOptions extends StatelessWidget {
  const ProfileOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          const SizedBox(height: tiniestSpacing),
          ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: ProfileUtil.profileOptionsList().length,
              itemBuilder: (context, index) {
                return ListTile(
                    onTap: () async {
                      switch (index.toString()) {
                        case '0':
                          break;
                        case '1':
                          Navigator.pushNamed(
                              context, SelectLanguageScreen.routeName);
                          break;
                        case '2':
                          Navigator.pushNamed(
                              context, SelectTimeZoneScreen.routeName);
                          break;
                        case '3':
                          Navigator.pushNamed(
                              context, SelectDateFormatScreen.routeName);
                          break;
                        case '4':
                          final String email = Uri.encodeComponent(
                              StringConstants.kToolkitXEmail);
                          Uri mail = Uri.parse("mailto:$email");
                          await launchUrl(mail);
                          break;
                        case '5':
                          launchUrlString(StringConstants.kPrivacyPolicyUrl,
                              mode: LaunchMode.inAppWebView);
                          break;
                        case '6':
                          launchUrlString(StringConstants.kMaturityModelUrl,
                              mode: LaunchMode.inAppWebView);
                          break;
                      }
                    },
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    horizontalTitleGap: 0.0,
                    leading:
                        ProfileUtil.profileOptionsList().elementAt(index).image,
                    title: Text(
                        ProfileUtil.profileOptionsList().elementAt(index).title,
                        style: Theme.of(context).textTheme.xSmall));
              }),
          const SizedBox(height: largeSpacing),
          Center(
              child: Text("App version 1.0.9",
                  style: Theme.of(context)
                      .textTheme
                      .xSmall
                      .copyWith(color: AppColor.grey)))
        ]),
      ),
    );
  }
}
