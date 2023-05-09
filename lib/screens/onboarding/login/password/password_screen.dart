import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/onboarding/login/login_button.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../widgets/card.dart';
import '../../widgets/circle_avatar.dart';
import '../../widgets/text_field.dart';

class PasswordScreen extends StatelessWidget {
  static const routeName = 'PasswordScreen';

  const PasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: topBottomSpacing,
            bottom: topBottomSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Material(
              elevation: kEmailCardElevation,
              borderRadius: BorderRadius.all(
                  Radius.circular(MediaQuery.of(context).size.width * 0.3)),
              child: CircleAvatarWidget(
                  radius: MediaQuery.of(context).size.width * 0.15,
                  backgroundColor: AppColor.blueGrey,
                  child: Icon(Icons.lock,
                      size: MediaQuery.of(context).size.width * 0.1)),
            ),
            const SizedBox(height: largeSpacing),
            Text(StringConstants.kWelcome,
                style: Theme.of(context).textTheme.xLarge),
            const SizedBox(height: tinySpacing),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.48,
              width: double.infinity,
              child: CardWidget(
                  margin: EdgeInsets.zero,
                  elevation: kCardElevation,
                  shadowColor: AppColor.blueGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kCardRadius),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.042),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(StringConstants.kPassword,
                            style: Theme.of(context).textTheme.largeTitle),
                        const SizedBox(height: tinySpacing),
                        const TextFieldWidget(
                            textInputType: TextInputType.emailAddress,
                            maxLines: 1),
                        const SizedBox(height: mediumSpacing),
                        LoginButton(
                            onPressed: () {}, textValue: StringConstants.kLogin)
                      ],
                    ),
                  )),
            ),
            TextButton(
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                onPressed: () {},
                child: Text(StringConstants.kGenerateOtp,
                    style: Theme.of(context).textTheme.largeTitle.copyWith(
                        fontWeight: FontWeight.w500, color: AppColor.cyan)))
          ],
        ),
      ),
    );
  }
}
