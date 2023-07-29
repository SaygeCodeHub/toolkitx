import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/circle_avatar.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../widgets/primary_button.dart';
import 'select_language_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = 'WelcomeScreen';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: MediaQuery.of(context).size.width * 0.25),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatarWidget(imagePath: 'mechanic_person.png'),
                  const SizedBox(height: xxxMediumSpacing),
                  Text(StringConstants.kWelcomeToToolkitX,
                      style: Theme.of(context).textTheme.xxLarge),
                  const SizedBox(height: xxTinySpacing),
                  Text(StringConstants.kAppIntroductionNoSpacing,
                      style: Theme.of(context)
                          .textTheme
                          .medium
                          .copyWith(fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center),
                  const SizedBox(height: xxLargerSpacing),
                  PrimaryButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, SelectLanguageScreen.routeName,
                            arguments: false);
                      },
                      textValue: StringConstants.kStartNow)
                ])));
  }
}
