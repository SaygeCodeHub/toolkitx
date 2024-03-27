import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../blocs/tickets/tickets_bloc.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_text_field.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/progress_bar.dart';

class AddTicketCommentScreen extends StatelessWidget {
  const AddTicketCommentScreen({super.key});

  static const routeName = 'AddTicketCommentScreen';

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
        child: BlocListener<TicketsBloc, TicketsStates>(
          listener: (context, state) {
            if (state is TicketCommentSaving) {
              ProgressBar.show(context);
            } else if (state is TicketCommentSaved) {
              ProgressBar.dismiss(context);
              Navigator.pop(context);
              context.read<TicketsBloc>().add(FetchTicketDetails(
                  ticketId: context.read<TicketsBloc>().ticketId,
                  ticketTabIndex: 0));
            } else if (state is TicketCommentNotSaved) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.errorMessage, '');
            }
          },
          child: PrimaryButton(
              onPressed: () {
                context
                    .read<TicketsBloc>()
                    .add(SaveTicketComment(comment: comment));
              },
              textValue: DatabaseUtil.getText('buttonSave')),
        ),
      ),
    );
  }
}
