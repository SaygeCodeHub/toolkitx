import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/tickets/tickets_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/tickets/ticket_list_screen.dart';
import 'package:toolkit/screens/tickets/widgets/ticket_application_filter.dart';
import 'package:toolkit/screens/tickets/widgets/ticket_bug_filter.dart';
import 'package:toolkit/screens/tickets/widgets/ticket_status_filter.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';

class TicketsFilterScreen extends StatelessWidget {
  static const routeName = 'TicketsFilterScreen';
  static Map ticketsFilterMap = {};

  const TicketsFilterScreen({super.key});

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
            TicketApplicationFilter(ticketsFilterMap: ticketsFilterMap),
            const SizedBox(height: xxTinierSpacing),
            Text(DatabaseUtil.getText('Status'),
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w500, color: AppColor.black)),
            const SizedBox(height: tiniestSpacing),
            TicketStatusFilter(ticketsFilterMap: ticketsFilterMap),
            const SizedBox(height: xxTinierSpacing),
            Text(DatabaseUtil.getText('ticket_bug'),
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w500, color: AppColor.black)),
            const SizedBox(height: tiniestSpacing),
            TicketBugFilter(ticketsFilterMap: ticketsFilterMap),
          ]),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxTinierSpacing),
        child: PrimaryButton(
            onPressed: () {
              context
                  .read<TicketsBloc>()
                  .add(ApplyTicketsFilter(ticketsFilterMap: ticketsFilterMap));
              Navigator.pop(context);
              Navigator.pushReplacementNamed(
                  context, TicketListScreen.routeName,
                  arguments: false);
            },
            textValue: StringConstants.kApply),
      ),
    );
  }
}
