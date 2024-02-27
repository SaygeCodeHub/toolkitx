import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import '../../blocs/loto/loto_details/loto_details_bloc.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/progress_bar.dart';

class LotoAddCommentScreen extends StatelessWidget {
  static const routeName = 'LotoAddCommentScreen';
  static Map addLotoCommentMap = {};
  const LotoAddCommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText("AddComment")),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(leftRightMargin),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
              child: PrimaryButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  textValue: DatabaseUtil.getText("buttonBack")),
            ),
            const SizedBox(width: xxTinierSpacing),
            Expanded(
              child: BlocListener<LotoDetailsBloc, LotoDetailsState>(
                  listener: (context, state) {
                    if (state is LotoCommentAdding) {
                      ProgressBar.show(context);
                    } else if (state is LotoCommentAdded) {
                      ProgressBar.dismiss(context);
                      showCustomSnackBar(
                          context, StringConstants.kLotoCommentSaved, '');
                      Navigator.pop(context);
                    } else if (state is LotoCommentNotAdded) {
                      ProgressBar.dismiss(context);
                      showCustomSnackBar(context, state.getError, '');
                    }
                  },
                  child: PrimaryButton(
                      onPressed: () {
                        context.read<LotoDetailsBloc>().add(AddLotoComment(
                            comment: addLotoCommentMap["comments"]));
                      },
                      textValue: DatabaseUtil.getText("buttonSave"))),
            )
          ]),
        ),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxxSmallerSpacing),
            child: Column(children: [
              TextFieldWidget(
                  onTextFieldChanged: (textField) {
                    addLotoCommentMap["comments"] = textField;
                  },
                  maxLines: 3,
                  hintText: DatabaseUtil.getText("AddComment")),
            ])));
  }
}
