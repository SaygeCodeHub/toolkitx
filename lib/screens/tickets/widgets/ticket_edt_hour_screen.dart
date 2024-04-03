import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/enums/ticket_status_enum.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../../blocs/tickets/tickets_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/generic_text_field.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/progress_bar.dart';

class TicketEDTHoursScreen extends StatelessWidget {
  const TicketEDTHoursScreen({super.key});

  static const routeName = 'TicketEDTHoursScreen';

  static String hours = '';

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
            Text(DatabaseUtil.getText('ticket_edt'),
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w500, color: AppColor.black)),
            const SizedBox(height: tiniestSpacing),
            TextFieldWidget(
              textInputType: TextInputType.number,
              onTextFieldChanged: (textField) {
                hours = textField;
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxTinierSpacing),
        child: BlocListener<TicketsBloc, TicketsStates>(
          listener: (context, state) {
            if (state is TicketStatusUpdating) {
              ProgressBar.show(context);
            } else if (state is TicketStatusUpdated) {
              ProgressBar.dismiss(context);
              Navigator.pop(context);
              context.read<TicketsBloc>().add(FetchTicketDetails(
                  ticketId: context.read<TicketsBloc>().ticketId,
                  ticketTabIndex: 0));
            } else if (state is TicketStatusNotUpdated) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.errorMessage, '');
            }
          },
          child: PrimaryButton(
              onPressed: () {
                context.read<TicketsBloc>().add(UpdateTicketStatus(
                    edtHrs: hours,
                    completionDate: '',
                    status: TicketStatusEnum.waitingForDevelopment.value));
              },
              textValue: DatabaseUtil.getText('buttonSave')),
        ),
      ),
    );
  }
}
