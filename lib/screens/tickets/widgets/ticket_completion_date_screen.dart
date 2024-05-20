import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/enums/ticket_status_enum.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../../blocs/tickets/tickets_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/primary_button.dart';
import '../../incident/widgets/date_picker.dart';

class TicketCompletionDateScreen extends StatelessWidget {
  const TicketCompletionDateScreen({super.key});

  static const routeName = 'TicketCompletionDateScreen';

  static String completionDate = '';

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
            Text(DatabaseUtil.getText('ticket_completiondate'),
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w500, color: AppColor.black)),
            const SizedBox(height: tiniestSpacing),
            DatePickerTextField(
              onDateChanged: (date) {
                completionDate = date;
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxTinierSpacing),
        child: PrimaryButton(
            onPressed: () {
              if (completionDate == '') {
                context.read<TicketsBloc>().add(UpdateTicketStatus(
                    edtHrs: 0,
                    completionDate: completionDate,
                    status: TicketStatusEnum.development.value));
              } else {
                Navigator.pop(context);
                context.read<TicketsBloc>().add(UpdateTicketStatus(
                    edtHrs: 0,
                    completionDate: completionDate,
                    status: TicketStatusEnum.development.value));
              }
            },
            textValue: DatabaseUtil.getText('buttonSave')),
      ),
    );
  }
}
