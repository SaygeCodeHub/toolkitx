import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/documents/documents_bloc.dart';
import 'package:toolkit/blocs/documents/documents_events.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../blocs/documents/documents_states.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/progress_bar.dart';

class DocumentsApproveAndRejectScreen extends StatelessWidget {
  const DocumentsApproveAndRejectScreen({super.key});

  static const routeName = 'DocumentsAddCommentsScreen';
  static bool isFromReject = false;
  static String comment = '';

  @override
  Widget build(BuildContext context) {
    comment = '';
    return Scaffold(
      appBar: GenericAppBar(
          title: isFromReject == true
              ? DatabaseUtil.getText("dms_rejectdocument")
              : DatabaseUtil.getText("dms_approvedocument")),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(StringConstants.kComments,
                style: Theme.of(context).textTheme.xSmall.copyWith(
                    fontWeight: FontWeight.w500, color: AppColor.black)),
            const SizedBox(height: tiniestSpacing),
            TextFieldWidget(
              maxLines: 4,
              onTextFieldChanged: (textField) {
                comment = textField;
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxTinierSpacing),
        child: BlocListener<DocumentsBloc, DocumentsStates>(
          listener: (context, state) {
            if (state is ApprovingDocuments) {
              ProgressBar.show(context);
            }
            if (state is DocumentsApproved) {
              ProgressBar.dismiss(context);
              Navigator.pop(context);
            }
            if (state is ApproveDocumentsError) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.message, '');
            }
          },
          child: PrimaryButton(
              onPressed: () {
                isFromReject == true
                    ? null
                    : context
                        .read<DocumentsBloc>()
                        .add(ApproveDocument(comment: comment));
              },
              textValue: isFromReject == true
                  ? DatabaseUtil.getText('Reject')
                  : DatabaseUtil.getText('approve')),
        ),
      ),
    );
  }
}
