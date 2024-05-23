import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import '../../blocs/pickAndUploadImage/pick_and_upload_image_events.dart';
import '../../blocs/profile/profile_bloc.dart';
import '../../blocs/profile/profile_events.dart';
import '../../blocs/profile/profile_states.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/error_section.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/generic_text_field.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/progress_bar.dart';
import '../root/root_screen.dart';
import 'widgets/blood_group_expansion_tile.dart';
import 'widgets/signature.dart';

class ProfileEditScreen extends StatelessWidget {
  static const routeName = 'ProfileEditScreen';
  static Map copyProfileMap = {};

  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<PickAndUploadImageBloc>().add(UploadInitial());
    context.read<ProfileBloc>().add(DecryptUserProfileData());
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('MyProfile')),
        body: BlocConsumer<ProfileBloc, ProfileStates>(
            buildWhen: (previousState, currentState) =>
                currentState is EditProfileInitialized ||
                currentState is EditProfileInitializing ||
                currentState is EditProfileError,
            listener: (BuildContext context, state) {
              if (state is UserProfileUpdating) {
                ProgressBar.show(context);
              }
              if (state is UserProfileUpdated) {
                ProgressBar.dismiss(context);
                Navigator.pushReplacementNamed(context, RootScreen.routeName,
                    arguments: false);
              }
              if (state is UserProfileUpdateError) {
                ProgressBar.dismiss(context);
                showCustomSnackBar(context, state.message, '');
              }
              if (state is UserProfileUpdateCancel) {
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              if (state is EditProfileInitializing) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is EditProfileInitialized) {
                copyProfileMap = Map.of(state.profileDetailsMap);
                return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: leftRightMargin, right: leftRightMargin),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: xxxSmallerSpacing),
                              Text(DatabaseUtil.getText('FirstName'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .xSmall
                                      .copyWith(fontWeight: FontWeight.w600)),
                              const SizedBox(height: xxxTinierSpacing),
                              TextFieldWidget(
                                  value: state.profileDetailsMap['fname'],
                                  textInputAction: TextInputAction.next,
                                  maxLength: 50,
                                  hintText: DatabaseUtil.getText('FirstName'),
                                  onTextFieldChanged: (String textField) {
                                    copyProfileMap['fname'] = textField;
                                  }),
                              const SizedBox(height: xxTinySpacing),
                              Text(DatabaseUtil.getText('LastName'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .xSmall
                                      .copyWith(fontWeight: FontWeight.w600)),
                              const SizedBox(height: xxxTinierSpacing),
                              TextFieldWidget(
                                  value: state.profileDetailsMap['lname'],
                                  maxLength: 50,
                                  textInputAction: TextInputAction.next,
                                  hintText: DatabaseUtil.getText('LastName'),
                                  onTextFieldChanged: (String textField) {
                                    copyProfileMap['lname'] = textField;
                                  }),
                              const SizedBox(height: xxTinySpacing),
                              Text(DatabaseUtil.getText('Contact'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .xSmall
                                      .copyWith(fontWeight: FontWeight.w600)),
                              const SizedBox(height: xxxTinierSpacing),
                              TextFieldWidget(
                                  value: state.profileDetailsMap['contact'],
                                  textInputType: TextInputType.phone,
                                  textInputAction: TextInputAction.done,
                                  maxLength: 20,
                                  hintText: DatabaseUtil.getText('Contact'),
                                  onTextFieldChanged: (String textField) {
                                    copyProfileMap['contact'] = textField;
                                  }),
                              const SizedBox(height: xxTinySpacing),
                              Text(DatabaseUtil.getText('BloodGroup'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .xSmall
                                      .copyWith(fontWeight: FontWeight.w600)),
                              const SizedBox(height: xxxTinierSpacing),
                              BloodGroupExpansionTile(
                                  profileDetailsMap: copyProfileMap),
                              const SizedBox(height: xxTinySpacing),
                              SignaturePad(map: copyProfileMap, mapKey: 'sign'),
                              const SizedBox(height: xxxSmallerSpacing),
                              PrimaryButton(
                                  onPressed: () {
                                    context.read<ProfileBloc>().add(
                                        UpdateProfile(
                                            updateProfileMap: copyProfileMap));
                                  },
                                  textValue:
                                      DatabaseUtil.getText('buttonSave')),
                              const SizedBox(height: xxxSmallerSpacing)
                            ])));
              } else if (state is EditProfileError) {
                return Center(
                    child: GenericReloadButton(
                        onPressed: () {
                          context
                              .read<ProfileBloc>()
                              .add(DecryptUserProfileData());
                        },
                        textValue: StringConstants.kReload));
              } else {
                return const SizedBox();
              }
            }));
  }
}
