import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/loto/loto_details/loto_details_bloc.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import '../../../configs/app_spacing.dart';

class StartRemoveLotoScreen extends StatelessWidget {
  static const routeName = "StartRemoveLotoScreen";
  const StartRemoveLotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kLotoStart),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: leftRightMargin),
            child: Column(children: [
              Text(DatabaseUtil.getText("LOTOREMOVEMESSAGEFORUSERS"),
                  textAlign: TextAlign.justify),
              const SizedBox(height: mediumSpacing),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                SizedBox(
                  height: kErrorButtonHeight,
                  width: xxxSizedBoxWidth,
                  child: PrimaryButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      textValue: DatabaseUtil.getText("buttonBack")),
                ),
                SizedBox(
                    height: kErrorButtonHeight,
                    width: xxSizedBoxWidth,
                    child: BlocListener<LotoDetailsBloc, LotoDetailsState>(
                        listener: (context, state) {
                          if (state is LotoRemoveStarting) {
                            ProgressBar.show(context);
                          } else if (state is LotoRemoveStarted) {
                            ProgressBar.dismiss(context);
                            showCustomSnackBar(context,
                                StringConstants.kLotoRemoveStarted, '');
                          } else if (state is LotoRemoveNotStarted) {
                            ProgressBar.dismiss(context);
                            showCustomSnackBar(context,
                                StringConstants.kSomethingWentWrong, '');
                          }
                        },
                        child: PrimaryButton(
                            onPressed: () {
                              context
                                  .read<LotoDetailsBloc>()
                                  .add(StartRemoveLotoEvent());
                            },
                            textValue:
                                DatabaseUtil.getText("StartRemoveLotoButton"))))
              ])
            ])));
  }
}
