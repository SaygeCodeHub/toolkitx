import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/loto/loto_details/loto_details_bloc.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/screens/loto/widgets/start_loto_body.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import '../../../blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import '../../../blocs/pickAndUploadImage/pick_and_upload_image_events.dart';
import '../../../configs/app_spacing.dart';

class StartLotoScreen extends StatelessWidget {
  static const routeName = "StartLotoScreen";
  static Map startLotoMap = {};
  static Map saveLotoChecklistMap = {};
  static bool isFromStartRemoveLoto = false;

  const StartLotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PickAndUploadImageBloc>().isInitialUpload = true;
    context.read<PickAndUploadImageBloc>().add(UploadInitial());
    context.read<LotoDetailsBloc>().isFromFirst = true;
    context.read<LotoDetailsBloc>().add(FetchLotoChecklistQuestions(
        isRemoveOperation: isFromStartRemoveLoto ? "1" : "0"));
    context.read<LotoDetailsBloc>().answerList = [];
    startLotoMap = {};
    return Scaffold(
        appBar: GenericAppBar(
            title: isFromStartRemoveLoto
                ? DatabaseUtil.getText("StartRemoveLotoButton")
                : DatabaseUtil.getText("StartLotoButton")),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(leftRightMargin),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: xxxSizedBoxWidth,
                      child: PrimaryButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          textValue: DatabaseUtil.getText("buttonBack"))),
                  SizedBox(
                      width: xxSizedBoxWidth,
                      child: BlocListener<LotoDetailsBloc, LotoDetailsState>(
                        listener: (context, state) {
                          if (state is LotoStarting) {
                            ProgressBar.show(context);
                          } else if (state is LotoStarted) {
                            ProgressBar.dismiss(context);
                            Navigator.pop(context);
                            showCustomSnackBar(
                                context, StringConstants.kLotoStarted, '');
                          } else if (state is LotoNotStarted) {
                            ProgressBar.dismiss(context);
                            showCustomSnackBar(context, state.getError, '');
                          }
                          if (state is LotoRemoveStarting) {
                            ProgressBar.show(context);
                          } else if (state is LotoRemoveStarted) {
                            ProgressBar.dismiss(context);
                            Navigator.pop(context);
                            showCustomSnackBar(context,
                                StringConstants.kLotoRemoveStarted, '');
                          } else if (state is LotoRemoveNotStarted) {
                            ProgressBar.dismiss(context);
                            showCustomSnackBar(context, state.getError, '');
                          }
                        },
                        child: isFromStartRemoveLoto == false
                            ? Visibility(
                                visible: context
                                            .read<LotoDetailsBloc>()
                                            .checklistArrayIdList
                                            .length ==
                                        1 ||
                                    context
                                        .read<LotoDetailsBloc>()
                                        .checklistArrayIdList
                                        .isEmpty,
                                replacement: PrimaryButton(
                                    onPressed: () {
                                      context
                                          .read<LotoDetailsBloc>()
                                          .add(SaveLotoChecklist());
                                    },
                                    textValue:
                                        DatabaseUtil.getText("nextButtonText")),
                                child: PrimaryButton(
                                    onPressed: () {
                                      context
                                          .read<LotoDetailsBloc>()
                                          .add(StartLotoEvent());
                                    },
                                    textValue: DatabaseUtil.getText(
                                        "StartLotoButton")),
                              )
                            : SizedBox(
                                width: xxSizedBoxWidth,
                                child: PrimaryButton(
                                    onPressed: () {
                                      context
                                          .read<LotoDetailsBloc>()
                                          .add(StartRemoveLotoEvent());
                                    },
                                    textValue: DatabaseUtil.getText(
                                        "StartRemoveLotoButton")),
                              ),
                      ))
                ])),
        body: const StartLotoBody());
  }
}
