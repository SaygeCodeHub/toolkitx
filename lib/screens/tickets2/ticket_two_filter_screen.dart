import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/tickets2/ticket_two_list_screen.dart';
import 'package:toolkit/screens/tickets2/widgets/ticket_two_application_filter.dart';
import 'package:toolkit/screens/tickets2/widgets/ticket_two_bug_filter.dart';
import 'package:toolkit/screens/tickets2/widgets/ticket_two_status_filter.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../blocs/tickets2/tickets2_bloc.dart';
import '../../blocs/tickets2/tickets2_event.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';

class TicketTwoFilterScreen extends StatelessWidget {
  static const routeName = 'TicketTwoFilterScreen';
  static Map ticketsFilterMap = {};

  const TicketTwoFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('Filters')),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(DatabaseUtil.getText('ticket_ticketno'),
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w500, color: AppColor.black)),
            const SizedBox(height: tiniestSpacing),
            TextFieldWidget(
              onTextFieldChanged: (textField) {
                ticketsFilterMap['ticket_no'] = textField;
              },
            ),
            const SizedBox(height: xxTinierSpacing),
            Text(DatabaseUtil.getText('Keywords'),
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w500, color: AppColor.black)),
            const SizedBox(height: tiniestSpacing),
            TextFieldWidget(
              onTextFieldChanged: (textField) {
                ticketsFilterMap['header'] = textField;
              },
            ),
            const SizedBox(height: xxTinierSpacing),
            TicketTwoApplicationFilter(ticketsFilterMap: ticketsFilterMap),
            const SizedBox(height: xxTinierSpacing),
            Text(DatabaseUtil.getText('Status'),
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w500, color: AppColor.black)),
            const SizedBox(height: tiniestSpacing),
            TicketTwoStatusFilter(ticketsFilterMap: ticketsFilterMap),
            const SizedBox(height: xxTinierSpacing),
            Text(DatabaseUtil.getText('ticket_bug'),
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w500, color: AppColor.black)),
            const SizedBox(height: tiniestSpacing),
            TicketTwoBugFilter(ticketsFilterMap: ticketsFilterMap),
          ]),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxTinierSpacing),
        child: PrimaryButton(
            onPressed: () {
              context
                  .read<Tickets2Bloc>()
                  .add(ApplyTickets2Filter(ticketsFilterMap: ticketsFilterMap));
              Navigator.pop(context);
              Navigator.pushReplacementNamed(
                  context, TicketTwoListScreen.routeName,
                  arguments: false);
            },
            textValue: StringConstants.kApply),
      ),
    );
  }
}
