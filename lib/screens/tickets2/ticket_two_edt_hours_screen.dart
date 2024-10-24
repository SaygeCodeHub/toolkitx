import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/generic_text_field.dart';
import '../../../widgets/primary_button.dart';
import '../../blocs/tickets2/tickets2_bloc.dart';
import '../../blocs/tickets2/tickets2_event.dart';
import '../../data/enums/ticketTwo/ticket_two_status_enum.dart';

class TicketTwoEDTHoursScreen extends StatelessWidget {
  const TicketTwoEDTHoursScreen({super.key});

  static const routeName = 'TicketTwoEDTHoursScreen';

  @override
  Widget build(BuildContext context) {
    int hours = 0;
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
                hours = int.tryParse(textField) ?? 0;
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxTinierSpacing),
        child: PrimaryButton(
            onPressed: () {
              if (hours <= 0) {
                context.read<Tickets2Bloc>().add(UpdateTicket2Status(
                    edtHrs: hours,
                    completionDate: '',
                    status: TicketTwoStatusEnum.waitingForDevelopment.value));
              } else {
                Navigator.pop(context);
                context.read<Tickets2Bloc>().add(UpdateTicket2Status(
                    edtHrs: hours,
                    completionDate: '',
                    status: TicketTwoStatusEnum.waitingForDevelopment.value));
              }
            },
            textValue: DatabaseUtil.getText('buttonSave')),
      ),
    );
  }
}
