import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/enums/ticket_status_enum.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../../blocs/tickets/tickets_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/generic_text_field.dart';
import '../../../widgets/primary_button.dart';

class TicketEDTHoursScreen extends StatelessWidget {
  const TicketEDTHoursScreen({super.key});

  static const routeName = 'TicketEDTHoursScreen';

  @override
  Widget build(BuildContext context) {
    int? hours = 0;
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
                hours = int.tryParse(textField);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxTinierSpacing),
        child: PrimaryButton(
            onPressed: () {
              if (hours! <= 0) {
                context.read<TicketsBloc>().add(UpdateTicketStatus(
                    edtHrs: hours!,
                    completionDate: '',
                    status: TicketStatusEnum.waitingForDevelopment.value));
              } else {
                Navigator.pop(context);
                context.read<TicketsBloc>().add(UpdateTicketStatus(
                    edtHrs: hours!,
                    completionDate: '',
                    status: TicketStatusEnum.waitingForDevelopment.value));
              }
            },
            textValue: DatabaseUtil.getText('buttonSave')),
      ),
    );
  }
}
