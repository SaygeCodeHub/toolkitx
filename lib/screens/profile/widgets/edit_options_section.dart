import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../blocs/client/client_bloc.dart';
import '../../../blocs/client/client_events.dart';
import '../../../blocs/profile/profile_bloc.dart';
import '../../../blocs/profile/profile_events.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';
import '../../../utils/profile_util.dart';
import '../../../widgets/android_pop_up.dart';
import '../../onboarding/client_list_screen.dart';
import '../profile_edit_screen.dart';

class EditOptionsSection extends StatelessWidget {
  const EditOptionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      InkWell(
          onTap: () {
            Navigator.pushNamed(context, ProfileEditScreen.routeName);
          },
          child: Column(children: [
            Image.asset('${ProfileUtil.iconPath}' 'pen.png',
                height: kProfileImageHeight, width: kProfileImageWidth),
            const SizedBox(height: xxTiniestSpacing),
            Text(DatabaseUtil.getText('EditProfile'),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.xxSmall)
          ])),
      InkWell(
          onTap: () {
            Navigator.pushNamed(context, ClientListScreen.routeName,
                arguments: true);
            context.read<ClientBloc>().add(FetchClientList());
          },
          child: Column(children: [
            Image.asset('${ProfileUtil.iconPath}' 'exchange.png',
                height: kProfileImageHeight, width: kProfileImageWidth),
            const SizedBox(height: xxTiniestSpacing),
            Text(DatabaseUtil.getText('ChangeClient'),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.xxSmall)
          ])),
      InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AndroidPopUp(
                      titleValue: DatabaseUtil.getText('Logout'),
                      contentValue: DatabaseUtil.getText('LogoutMessage'),
                      onPrimaryButton: () {
                        Navigator.of(context);
                        context.read<ProfileBloc>().add(Logout());
                      });
                });
          },
          child: Column(children: [
            Image.asset('${ProfileUtil.iconPath}' 'logout.png',
                height: kProfileImageHeight, width: kProfileImageWidth),
            const SizedBox(height: xxTiniestSpacing),
            Text(DatabaseUtil.getText('Logout'),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.xxSmall)
          ]))
    ]);
  }
}
