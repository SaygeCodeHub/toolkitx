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

class StartLotoScreen extends StatelessWidget {
  static const routeName = "StartLotoScreen";
  const StartLotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText("StartLotoButton")),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(leftRightMargin),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(
              width: xxxSizedBoxWidth,
              child: PrimaryButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  textValue: DatabaseUtil.getText("buttonBack")),
            ),
            SizedBox(
                width: xxSizedBoxWidth,
                child: BlocListener<LotoDetailsBloc, LotoDetailsState>(
                    listener: (context, state) {
                      if (state is LotoStarting) {
                        ProgressBar.show(context);
                      } else if (state is LotoStarted) {
                        ProgressBar.dismiss(context);
                        showCustomSnackBar(
                            context, StringConstants.kLotoStarted, '');
                      } else if (state is LotoNotStarted) {
                        ProgressBar.dismiss(context);
                        showCustomSnackBar(
                            context, state.getError, '');
                      }
                    },
                    child: PrimaryButton(
                        onPressed: () {
                          context.read<LotoDetailsBloc>().add(StartLotoEvent());
                        },
                        textValue: DatabaseUtil.getText("StartLotoButton"))))
          ]),
        ),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: leftRightMargin),
            child: Column(children: [
              Text(DatabaseUtil.getText("LOTOREMOVEMESSAGEFORUSERS"),
                  textAlign: TextAlign.justify),
            ])));
  }
}
