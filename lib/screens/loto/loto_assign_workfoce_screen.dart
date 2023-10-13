import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/screens/loto/widgets/loto_assign_workforce_body.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import 'package:toolkit/widgets/primary_button.dart';
import '../../blocs/loto/loto_details/loto_details_bloc.dart';
import '../../configs/app_spacing.dart';

class LotoAssignWorkforceScreen extends StatelessWidget {
  static const routeName = 'LotoAssignWorkforceScreen';
  static String name = '';
  static int pageNo = 1;
  const LotoAssignWorkforceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<LotoDetailsBloc>().add(FetchLotoAssignWorkforce(
        pageNo: 1,
        isRemove: context.read<LotoDetailsBloc>().isRemove,
        name: ''));
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText("assign_workforce")),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: leftRightMargin),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: TextFieldWidget(
                        onTextFieldChanged: (textField) {
                          name = textField;
                        },
                        hintText: StringConstants.kWorkforce)),
                const SizedBox(width: tinySpacing),
                SizedBox(
                    width: kApplyButtonWidth,
                    child: PrimaryButton(
                        onPressed: () {
                          LotoAssignWorkforceBody.isFirst = true;
                          pageNo = 1;
                          context.read<LotoDetailsBloc>().assignWorkforceDatum =
                              [];
                          context.read<LotoDetailsBloc>().lotoListReachedMax =
                              false;
                          context.read<LotoDetailsBloc>().add(
                              FetchLotoAssignWorkforce(
                                  pageNo: 1,
                                  isRemove:
                                      context.read<LotoDetailsBloc>().isRemove,
                                  name: name));
                        },
                        textValue: StringConstants.kApply)),
              ],
            ),
            const SizedBox(height: tinySpacing),
            const LotoAssignWorkforceBody(),
          ],
        ),
      ),
    );
  }
}
