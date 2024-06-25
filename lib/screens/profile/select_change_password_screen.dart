import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/profile/profile_bloc.dart';
import '../../blocs/profile/profile_events.dart';
import '../../blocs/profile/profile_states.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../data/enums/change_password_type_enum.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/custom_card.dart';
import 'change_password_screen.dart';

class SelectChangePasswordTypeScreen extends StatelessWidget {
  static const routeName = 'SelectChangePasswordTypeScreen';

  const SelectChangePasswordTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(ChangePasswordType(changePasswordType: ''));
    return Scaffold(
      appBar: const GenericAppBar(title: StringConstants.kChangePassword),
      body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: topBottomPadding),
          child: BlocConsumer<ProfileBloc, ProfileStates>(
              buildWhen: (previousState, currentState) =>
                  currentState is ChangePasswordTypeLoaded,
              listener: (context, state) {
                if (state is ChangePasswordTypeChecked) {
                  Navigator.pushNamed(context, ChangePasswordScreen.routeName);
                }
              },
              builder: (context, state) {
                if (state is ChangePasswordTypeLoaded) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: xxTiniestSpacing),
                        CustomCard(
                            elevation: kZeroElevation,
                            child: ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.only(
                                    bottom: xxTiniestSpacing),
                                shrinkWrap: true,
                                itemCount: ChangePasswordTypeEnum.values.length,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                      height: xxxMediumSpacing,
                                      child: RadioListTile(
                                          dense: true,
                                          activeColor: AppColor.deepBlue,
                                          controlAffinity:
                                              ListTileControlAffinity.trailing,
                                          title: Text(ChangePasswordTypeEnum
                                              .values[index].type),
                                          value: ChangePasswordTypeEnum
                                              .values[index].type,
                                          groupValue: state.changePasswordType,
                                          onChanged: (value) {
                                            value = ChangePasswordTypeEnum
                                                .values[index].type;
                                            context.read<ProfileBloc>().add(
                                                ChangePasswordType(
                                                    changePasswordType: value));
                                          }));
                                },
                                separatorBuilder: (context, index) {
                                  return const Divider(
                                      thickness: kDividerThickness,
                                      height: kDividerHeight);
                                })),
                        const SizedBox(height: xxxSmallerSpacing),
                        PrimaryButton(
                            onPressed: () {
                              context.read<ProfileBloc>().add(
                                  CheckChangePasswordType(
                                      changePasswordOtp:
                                          state.changePasswordType ==
                                              'Change using OTP'));
                            },
                            textValue: DatabaseUtil.getText('nextButtonText')),
                        const SizedBox(height: xxxSmallerSpacing)
                      ]);
                } else {
                  return const SizedBox();
                }
              })),
    );
  }
}
