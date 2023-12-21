import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/loto/loto_details_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../blocs/loto/loto_details/loto_details_bloc.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/progress_bar.dart';

class LotoRejectScreen extends StatelessWidget {
  static const routeName = 'LotoRejectScreen';

  const LotoRejectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String remark = '';
    return Scaffold(
        appBar: const GenericAppBar(),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Comments",
                  style: Theme.of(context).textTheme.small.copyWith(
                      fontWeight: FontWeight.w800, color: AppColor.black)),
              const SizedBox(height: xxxTinierSpacing),
              TextFieldWidget(
                  onTextFieldChanged: (textField) {
                    remark = textField;
                  },
                  maxLines: 4),
              const SizedBox(height: xxxSmallestSpacing),
              Row(children: [
                SizedBox(
                    width: kApplyButtonWidth,
                    child: PrimaryButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        textValue: StringConstants.kBack)),
                const SizedBox(width: xxTinierSpacing),
                SizedBox(
                    width: xxxSizedBoxWidth,
                    child: BlocListener<LotoDetailsBloc, LotoDetailsState>(
                      listener: (context, state) {
                        if (state is LotoRejecting) {
                          ProgressBar.show(context);
                        } else if (state is LotoRejected) {
                          ProgressBar.dismiss(context);
                          Navigator.pushReplacementNamed(
                              context, LotoDetailsScreen.routeName);
                          Navigator.pop(context);
                          showCustomSnackBar(
                              context, StringConstants.kLotoRejected, '');
                        } else if (state is LotoNotRejected) {
                          ProgressBar.dismiss(context);
                          showCustomSnackBar(
                              context, StringConstants.kSomethingWentWrong, '');
                        }
                      },
                      child: PrimaryButton(
                          onPressed: () {
                            context
                                .read<LotoDetailsBloc>()
                                .add(RejectLotoEvent(remark: remark));
                          },
                          textValue: DatabaseUtil.getText('RejectButton')),
                    )),
              ])
            ])));
  }
}
