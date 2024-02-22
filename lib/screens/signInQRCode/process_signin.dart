import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:toolkit/blocs/signInQRCode/signInProcess/sign_in_process_bloc.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/screens/signInQRCode/signin_list_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/android_pop_up.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import '../../configs/app_color.dart';

class ProcessSignInScreen extends StatefulWidget {
  static const routeName = 'ProcessSignInScreen';
  static bool isSignOut = false;

  const ProcessSignInScreen({Key? key}) : super(key: key);

  @override
  State<ProcessSignInScreen> createState() => _ProcessSignInScreenState();
}

class _ProcessSignInScreenState extends State<ProcessSignInScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String result = '';
  Barcode? qrCode;
  QRViewController? qRcontroller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      qRcontroller!.pauseCamera();
    } else if (Platform.isIOS) {
      qRcontroller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                  borderColor: AppColor.blueGrey,
                  borderRadius: kQRBorderRadius,
                  borderLength: kQRBorderLength,
                  borderWidth: kQRBorderWidth),
            ),
          ),
          Expanded(
            flex: 1,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(height: xxTinierSpacing),
              Center(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: xxLargeSpacing),
                      child:
                          BlocListener<SignInProcessBloc, SignInProcessState>(
                        listener: (context, state) {
                          if (state is SignInProcessing) {
                            ProgressBar.show(context);
                          }
                          if (state is SignInProcessed) {
                            ProgressBar.dismiss(context);
                            showCustomSnackBar(
                                context, StringConstants.kLoginSuccess, '');
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(
                                context, SignInListScreen.routeName);
                          }
                          if (state is SignInUnauthorizedPop) {
                            ProgressBar.dismiss(context);
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AndroidPopUp(
                                  onSecondaryButton: () {
                                    Navigator.pop(context);
                                  },
                                  titleValue: StringConstants.kWarning,
                                  contentValue: StringConstants.kUnauthorized,
                                  onPrimaryButton: () {
                                    context.read<SignInProcessBloc>().add(
                                        UnauthorizedSignIn(qRCode: result));
                                  },
                                  textValue: DatabaseUtil.getText('Yes'),
                                );
                              },
                            );
                          }
                          if (state is SignInProcessingError) {
                            ProgressBar.dismiss(context);
                            showCustomSnackBar(context, state.errorMsg, '');
                          }
                          if (state is SignOutProcessing) {
                            ProgressBar.show(context);
                          } else if (state is SignOutProcessed) {
                            ProgressBar.dismiss(context);
                            showCustomSnackBar(context,
                                StringConstants.kSignOutSuccessfully, '');
                            Navigator.pop(context);
                            Navigator.pop(context);
                          } else if (state is SignOutNotProcessed) {
                            ProgressBar.dismiss(context);
                            Navigator.pop(context);
                            showCustomSnackBar(
                                context, StringConstants.kNoActiveSignIn, '');
                          }
                          if (state is SignInUnauthorizedProcessing) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColor.deepBlue,
                                  ),
                                );
                              },
                            );
                          }
                          if (state is SignInUnauthorized) {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(
                                context, SignInListScreen.routeName);
                          }
                          if (state is SignInUnathorizedError) {
                            showCustomSnackBar(context,
                                StringConstants.kUnauthorizedError, '');
                          }
                        },
                        child: PrimaryButton(
                            onPressed: () {
                              ProcessSignInScreen.isSignOut != true
                                  ? context
                                      .read<SignInProcessBloc>()
                                      .add(SignInProcess(qRCode: result))
                                  : context
                                      .read<SignInProcessBloc>()
                                      .add(ProcessSignOut(qRCode: result));
                            },
                            textValue: StringConstants.kCapture),
                      )))
            ]),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    qRcontroller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData.code.toString();
      });
    });
  }

  @override
  void dispose() {
    qRcontroller?.dispose();
    super.dispose();
  }
}
