import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/login/login_bloc.dart';
import '../../blocs/login/login_states.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/progress_bar.dart';
import 'client_list_screen.dart';
import 'widgets/password_body.dart';

class PasswordScreen extends StatelessWidget {
  static const routeName = 'PasswordScreen';
  final Map loginMap = {};

  PasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
                padding: const EdgeInsets.only(
                    left: leftRightMargin,
                    right: leftRightMargin,
                    top: topBottomPadding,
                    bottom: topBottomPadding),
                child: BlocListener<LoginBloc, LoginStates>(
                    listener: (BuildContext context, state) {
                      if (state is LoginLoading) {
                        ProgressBar.show(context);
                      }
                      if (state is LoginLoaded) {
                        ProgressBar.dismiss(context);
                        Navigator.pushNamedAndRemoveUntil(
                            context,
                            ClientListScreen.routeName,
                            (Route<dynamic> route) => false,
                            arguments: false);
                      }
                      if (state is LoginError) {
                        ProgressBar.dismiss(context);
                        showCustomSnackBar(context, state.message, '');
                      }
                      if (state is GeneratingOtpLogin) {
                        ProgressBar.show(context);
                      }
                      if (state is LoginOtpGenerated) {
                        ProgressBar.dismiss(context);
                        if (state.generateOtpLoginModel.message == '1') {
                          showCustomSnackBar(context,
                              DatabaseUtil.getText('OTPSentMessage'), '');
                        } else {
                          showCustomSnackBar(
                              context, StringConstants.kTryAgainInSomeTime, '');
                        }
                      }
                      if (state is GenerateOtpLoginError) {
                        ProgressBar.dismiss(context);
                        showCustomSnackBar(
                            context, StringConstants.kTryAgainInSomeTime, '');
                      }
                    },
                    child: PasswordBody()))));
  }
}
