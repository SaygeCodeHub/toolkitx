import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/tickets/widgets/priority_expansion_tile.dart';
import 'package:toolkit/screens/tickets/widgets/ticket_application_filter.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../../blocs/tickets/tickets_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/generic_text_field.dart';
import '../../../widgets/primary_button.dart';

class AddTicketScreen extends StatelessWidget {
  static const routeName = 'AddTicketScreen';

  const AddTicketScreen({super.key});

  static Map saveTicketMap = {};

  @override
  Widget build(BuildContext context) {
    context.read<TicketsBloc>().add(FetchTicketMaster());
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('ticket_addticket')),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: SingleChildScrollView(
          child: BlocBuilder<TicketsBloc, TicketsStates>(
            buildWhen: (previousState, currentState) =>
                currentState is TicketMasterFetching ||
                currentState is TicketMasterFetched ||
                currentState is TicketMasterNotFetched,
            builder: (context, state) {
              log('state==========>$state');
              if (state is TicketMasterFetching) {
                return Center(child: CircularProgressIndicator());
              } else if (state is TicketMasterFetched) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(DatabaseUtil.getText('ticket_header'),
                          style: Theme.of(context).textTheme.small.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColor.black)),
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
                              fontWeight: FontWeight.w500,
                              color: AppColor.black)),
                      const SizedBox(height: tiniestSpacing),
                      PriorityExpansionTile(
                          ticketMasterDatum: state.fetchTicketMasterModel.data,
                          saveTicketMap: saveTicketMap),
                      const SizedBox(height: xxTinierSpacing),
                      Text(DatabaseUtil.getText('ticket_bug'),
                          style: Theme.of(context).textTheme.small.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColor.black)),
                      const SizedBox(height: tiniestSpacing),
                      const SizedBox(height: xxTinierSpacing),
                      Text(DatabaseUtil.getText('Description'),
                          style: Theme.of(context).textTheme.small.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColor.black)),
                      const SizedBox(height: tiniestSpacing),
                      TextFieldWidget(
                        onTextFieldChanged: (textField) {
                          saveTicketMap['description'] = textField;
                        },
                      ),
                    ]);
              } else if (state is TicketMasterNotFetched) {
                return Center(child: Text(StringConstants.kNoRecordsFound));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxTinierSpacing),
        child: PrimaryButton(
            onPressed: () {
              log('map====================>$saveTicketMap');
            },
            textValue: DatabaseUtil.getText('buttonSave')),
      ),
    );
  }
}
