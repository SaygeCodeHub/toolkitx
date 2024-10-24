import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../blocs/tickets2/tickets2_bloc.dart';
import '../../blocs/tickets2/tickets2_event.dart';
import '../../blocs/tickets2/tickets2_state.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_text_field.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/progress_bar.dart';

class AddTicketTwoCommentScreen extends StatelessWidget {
  const AddTicketTwoCommentScreen({super.key});

  static const routeName = 'AddTicketTwoCommentScreen';

  static String comment = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('AddComments')),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(DatabaseUtil.getText('Comments'),
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w500, color: AppColor.black)),
            const SizedBox(height: tiniestSpacing),
            TextFieldWidget(
              maxLines: 3,
              onTextFieldChanged: (textField) {
                comment = textField;
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxTinierSpacing),
        child: BlocListener<Tickets2Bloc, Tickets2States>(
          listener: (context, state) {
            if (state is Ticket2CommentSaving) {
              ProgressBar.show(context);
            } else if (state is Ticket2CommentSaved) {
              ProgressBar.dismiss(context);
              Navigator.pop(context);
              context.read<Tickets2Bloc>().add(FetchTicket2Details(
                  ticketId: context.read<Tickets2Bloc>().ticket2Id,
                  ticketTabIndex: 0));
            } else if (state is Ticket2CommentNotSaved) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.errorMessage, '');
            }
          },
          child: PrimaryButton(
              onPressed: () {
                if (comment.trim().isEmpty) {
                  showCustomSnackBar(
                      context, StringConstants.kPleaseAddComments, '');
                } else {
                  context
                      .read<Tickets2Bloc>()
                      .add(SaveTicket2Comment(comment: comment));
                }
              },
              textValue: DatabaseUtil.getText('buttonSave')),
        ),
      ),
    );
  }
}
