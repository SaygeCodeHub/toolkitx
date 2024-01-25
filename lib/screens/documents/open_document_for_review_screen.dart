import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/documents/documents_events.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/incident/widgets/date_picker.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../blocs/documents/documents_bloc.dart';
import '../../blocs/documents/documents_states.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/progress_bar.dart';

class OpenDocumentForReviewScreen extends StatelessWidget {
  static const routeName = 'OpenDocumentForReviewScreen';
  static String dueDate = '';

  const OpenDocumentForReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('dms_openforreview')),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(DatabaseUtil.getText('Duedate'),
              style: Theme.of(context).textTheme.small.copyWith(
                  fontWeight: FontWeight.w500, color: AppColor.black)),
          const SizedBox(height: tiniestSpacing),
          DatePickerTextField(
            onDateChanged: (date) {
              dueDate = date;
            },
          )
        ]),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxTinierSpacing),
        child: BlocListener<DocumentsBloc, DocumentsStates>(
          listener: (context, state) {
            if (state is OpeningDocumentsForReview) {
              ProgressBar.show(context);
            }
            if (state is DocumentOpenedForReview) {
              ProgressBar.dismiss(context);
              Navigator.pop(context);
            }
            if (state is OpenDocumentsForReviewError) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.message, '');
            }
          },
          child: PrimaryButton(
              onPressed: () {
                context
                    .read<DocumentsBloc>()
                    .add(OpenDocumentsForReview(dueDate: dueDate));
              },
              textValue: StringConstants.kSave),
        ),
      ),
    );
  }
}
