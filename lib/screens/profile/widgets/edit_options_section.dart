import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/profile/edit/edit_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import 'logout.dart';

class EditOptionsSection extends StatelessWidget {
  final String imagePath = 'assets/icons/';

  const EditOptionsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, EditScreen.routeName);
        },
        child: Column(children: [
          Image.asset('$imagePath' 'pen.png',
              height: kProfileImageHeight, width: kProfileImageWidth),
          const SizedBox(height: tiniestSpacing),
          Text(StringConstants.kEditProfile,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.xxSmall)
        ]),
      ),
      Column(children: [
        Image.asset('$imagePath' 'exchange.png',
            height: kProfileImageHeight, width: kProfileImageWidth),
        const SizedBox(height: tiniestSpacing),
        Text(StringConstants.kChangeClient,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.xxSmall)
      ]),
      GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return const Logout();
              });
        },
        child: Column(children: [
          Image.asset('$imagePath' 'logout.png',
              height: kProfileImageHeight, width: kProfileImageWidth),
          const SizedBox(height: tiniestSpacing),
          Text(StringConstants.kLogout,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.xxSmall)
        ]),
      )
    ]);
  }
}
