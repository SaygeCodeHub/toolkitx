import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../blocs/login/login_bloc.dart';
import '../../blocs/login/login_events.dart';
import '../../blocs/login/login_states.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';
import '../../widgets/circle_avatar.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_text_field.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/progress_bar.dart';
import 'password_screen.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = 'LoginScreen';
  final Map emailMap = {};

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
                padding: const EdgeInsets.only(
                    left: leftRightMargin,
                    right: leftRightMargin,
                    top: topBottomPadding,
                    bottom: topBottomPadding),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatarWidget(imagePath: 'email.png'),
                      const SizedBox(height: xxxMediumSpacing),
                      CustomCard(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(kCardRadius)),
                          child: Padding(
                              padding: const EdgeInsets.all(kCardPadding),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(DatabaseUtil.getText('email'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .xSmall
                                            .copyWith(
                                                fontWeight: FontWeight.w600)),
                                    const SizedBox(height: xxxTinierSpacing),
                                    TextFieldWidget(
                                        textInputType:
                                            TextInputType.emailAddress,
                                        maxLength: 100,
                                        onTextFieldChanged: (String textField) {
                                          emailMap['email'] = textField;
                                        })
                                  ]))),
                      const SizedBox(height: xxxSmallerSpacing),
                      BlocListener<LoginBloc, LoginStates>(
                          listener: (context, state) {
                            if (state is ValidatingEmail) {
                              ProgressBar.show(context);
                            }
                            if (state is EmailValidated) {
                              ProgressBar.dismiss(context);
                              Navigator.pushNamed(
                                  context, PasswordScreen.routeName);
                            }
                            if (state is ValidateEmailError) {
                              ProgressBar.dismiss(context);
                              showCustomSnackBar(context, state.message, '');
                            }
                          },
                          child: PrimaryButton(
                              onPressed: () {
                                context.read<LoginBloc>().add(
                                    ValidateEmail(email: emailMap['email']));
                              },
                              textValue:
                                  DatabaseUtil.getText('nextButtonText')))
                    ]))));
  }
}
