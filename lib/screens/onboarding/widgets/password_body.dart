import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../../blocs/login/login_bloc.dart';
import '../../../blocs/login/login_events.dart';
import '../../../blocs/login/login_states.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/enums/user_type_emun.dart';
import '../../../widgets/circle_avatar.dart';
import '../../../widgets/generic_text_field.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/text_button.dart';
import '../../../widgets/custom_card.dart';
import 'type_expansion_tile.dart';

class PasswordBody extends StatelessWidget {
  final Map loginMap = {};

  PasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<LoginBloc>().add(ChangeUserType(
        userType: UserType.workForce.type,
        typeValue: UserType.workForce.value));
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      const CircleAvatarWidget(imagePath: 'reset-password.png'),
      const SizedBox(height: xxxMediumSpacing),
      Text(DatabaseUtil.getText('welcomeOtp'),
          style: Theme.of(context).textTheme.xLarge),
      const SizedBox(height: xxTinierSpacing),
      CustomCard(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kCardRadius)),
          child: Padding(
              padding: const EdgeInsets.all(kCardPadding),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${DatabaseUtil.getText('password')}/OTP',
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: xxxTinierSpacing),
                    TextFieldWidget(
                        obscureText: true,
                        maxLength: 30,
                        onTextFieldChanged: (String textField) {
                          loginMap['password'] = textField;
                        }),
                    BlocBuilder<LoginBloc, LoginStates>(
                        buildWhen: (previousState, currentState) =>
                            currentState is UserTypeChanged,
                        builder: (context, state) {
                          if (state is UserTypeChanged) {
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: xxTinySpacing),
                                  Text(DatabaseUtil.getText('type'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .xSmall
                                          .copyWith(
                                              fontWeight: FontWeight.w600)),
                                  const SizedBox(height: xxxTinierSpacing),
                                  UserTypeExpansionTile(
                                      typeValue: state.typeValue,
                                      usertype: state.userType)
                                ]);
                          } else {
                            return const SizedBox();
                          }
                        })
                  ]))),
      CustomTextButton(
          onPressed: () {
            context.read<LoginBloc>().add(GenerateLoginOtp());
          },
          textValue: DatabaseUtil.getText('generateotp')),
      PrimaryButton(
          onPressed: () {
            context.read<LoginBloc>().add(LoginEvent(loginMap: loginMap));
          },
          textValue: DatabaseUtil.getText('logins'))
    ]);
  }
}
