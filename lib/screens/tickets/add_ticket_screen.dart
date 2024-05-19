import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/tickets/widgets/priority_expansion_tile.dart';
import 'package:toolkit/screens/tickets/widgets/ticket_application_filter.dart';
import 'package:toolkit/screens/tickets/widgets/ticket_bug_expansion_tile.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../blocs/tickets/tickets_bloc.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/generic_text_field.dart';
import '../../widgets/primary_button.dart';

class AddTicketScreen extends StatelessWidget {
  static const routeName = 'AddTicketScreen';

  const AddTicketScreen({super.key});

  static Map saveTicketMap = {};

  @override
  Widget build(BuildContext context) {
    context.read<TicketsBloc>().add(FetchTicketMaster());
    context.read<TicketsBloc>().selectApplicationName = '';
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('ticket_addticket')),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(DatabaseUtil.getText('ticket_header'),
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w500, color: AppColor.black)),
            const SizedBox(height: tiniestSpacing),
            TextFieldWidget(
              onTextFieldChanged: (textField) {
                saveTicketMap['header'] = textField;
              },
            ),
            const SizedBox(height: xxTinierSpacing),
            TicketApplicationFilter(ticketsFilterMap: saveTicketMap),
            const SizedBox(height: xxTinierSpacing),
            Text(DatabaseUtil.getText('Priority'),
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w500, color: AppColor.black)),
            const SizedBox(height: tiniestSpacing),
            BlocBuilder<TicketsBloc, TicketsStates>(
              buildWhen: (previousState, currentState) =>
                  currentState is TicketMasterFetched,
              builder: (context, state) {
                if (state is TicketMasterFetched) {
                  return PriorityExpansionTile(
                      ticketMasterDatum: state.fetchTicketMasterModel.data,
                      saveTicketMap: saveTicketMap);
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            const SizedBox(height: xxTinierSpacing),
            Text(DatabaseUtil.getText('ticket_bug'),
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w500, color: AppColor.black)),
            const SizedBox(height: tiniestSpacing),
            TicketBugExpansionTile(saveTicketMap: saveTicketMap),
            const SizedBox(height: xxTinierSpacing),
            Text(DatabaseUtil.getText('Description'),
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w500, color: AppColor.black)),
            const SizedBox(height: tiniestSpacing),
            TextFieldWidget(
              maxLines: 3,
              onTextFieldChanged: (textField) {
                saveTicketMap['description'] = textField;
              },
            ),
          ]),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxTinierSpacing),
        child: BlocListener<TicketsBloc, TicketsStates>(
          listener: (context, state) {
            if (state is TicketSaving) {
              ProgressBar.show(context);
            } else if (state is TicketSaved) {
              ProgressBar.dismiss(context);
              Navigator.pop(context);
              context
                  .read<TicketsBloc>()
                  .add(FetchTickets(pageNo: 1, isFromHome: false));
            } else if (state is TicketNotSaved) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.errorMessage, '');
            }
          },
          child: PrimaryButton(
              onPressed: () {
                context
                    .read<TicketsBloc>()
                    .add(SaveTicket(saveTicketMap: saveTicketMap));
              },
              textValue: DatabaseUtil.getText('buttonSave')),
        ),
      ),
    );
  }
}
