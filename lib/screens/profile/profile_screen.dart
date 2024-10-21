import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../blocs/profile/profile_bloc.dart';
import '../../blocs/profile/profile_events.dart';
import '../../blocs/profile/profile_states.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/circle_avatar.dart';
import '../../widgets/error_section.dart';
import '../../widgets/custom_card.dart';
import '../onboarding/welcome_screen.dart';
import 'widgets/edit_options_section.dart';
import 'widgets/profile_options.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = 'ProfileScreen';

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(FetchUserProfile());
    return PopScope(
        onPopInvokedWithResult: (pop, _) async {
          return;
        },
        child: Scaffold(
            body: Padding(
                padding: const EdgeInsets.only(
                    left: leftRightMargin,
                    right: leftRightMargin,
                    top: topBottomPadding),
                child: BlocConsumer<ProfileBloc, ProfileStates>(
                    buildWhen: (previousState, currentState) =>
                        currentState is UserProfileFetching ||
                        currentState is UserProfileFetched ||
                        currentState is UserProfileFetchError,
                    listener: (context, state) {
                      if (state is LoggedOut) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, WelcomeScreen.routeName, (route) => true);
                      }
                    },
                    builder: (context, state) {
                      if (state is UserProfileFetching) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is UserProfileFetched) {
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: xxxSmallerSpacing),
                              CustomCard(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(kCardRadius)),
                                  child: Padding(
                                      padding:
                                          const EdgeInsets.all(xxTinySpacing),
                                      child: Column(children: [
                                        const CircleAvatarWidget(
                                            imagePath: 'mechanic_person.png'),
                                        const SizedBox(
                                            height: xxxSmallerSpacing),
                                        Text(state.userName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .large,
                                            textAlign: TextAlign.center),
                                        const SizedBox(height: tiniestSpacing),
                                        Text(
                                            DatabaseUtil.getText(
                                                state.userType),
                                            style: Theme.of(context)
                                                .textTheme
                                                .xSmall),
                                        const SizedBox(
                                            height: xxxSmallerSpacing),
                                        const EditOptionsSection()
                                      ]))),
                              const SizedBox(height: xxTinySpacing),
                              const ProfileOptions()
                            ]);
                      }
                      if (state is UserProfileFetchError) {
                        return Center(
                            child: GenericReloadButton(
                                onPressed: () {
                                  context
                                      .read<ProfileBloc>()
                                      .add(FetchUserProfile());
                                },
                                textValue: StringConstants.kReload));
                      } else {
                        return const SizedBox();
                      }
                    }))));
  }
}
