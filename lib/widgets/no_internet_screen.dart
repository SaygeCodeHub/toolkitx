import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../configs/app_color.dart';
import '../configs/app_dimensions.dart';
import '../configs/app_spacing.dart';
import '../utils/constants/string_constants.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(leftRightMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/icons/no_wifi.png',
                  height: kLargeIconSize, width: kLargeIconSize),
              const SizedBox(height: xxxMediumSpacing),
              Text(DatabaseUtil.getText('something_went_wrong'),
                  style: Theme.of(context).textTheme.xxLarge.copyWith(
                      color: AppColor.black, fontWeight: FontWeight.w500)),
              const SizedBox(height: xxTinySpacing),
              Text(StringConstants.kNoInternetError,
                  style: Theme.of(context).textTheme.medium.copyWith(
                      fontWeight: FontWeight.normal, color: AppColor.grey),
                  textAlign: TextAlign.center),
              const SizedBox(height: xxxSmallerSpacing),
              PrimaryButton(
                  onPressed: () {}, textValue: StringConstants.kRefresh)
            ],
          ),
        ),
      ),
    );
  }
}
