import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/tickets/tickets_bloc.dart';
import 'package:toolkit/screens/tickets/tickets_filter_screen.dart';
import 'package:toolkit/screens/tickets/widgets/ticket_list_body.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/custom_icon_button_row.dart';

class TicketListScreen extends StatelessWidget {
  static const routeName = 'TicketListScreen';
  static int pageNo = 1;

  const TicketListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TicketsBloc>().add(FetchTickets(pageNo: pageNo));
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('Ticket')),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing,
                bottom: xxTinierSpacing),
            child: BlocBuilder<TicketsBloc, TicketsStates>(
                builder: (context, state) {
              if (state is TicketsFetching) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TicketsFetched) {
                var data = state.fetchTicketsModel.data;
                return Column(children: [
                  CustomIconButtonRow(
                      primaryOnPress: () {
                        Navigator.pushNamed(
                            context, TicketsFilterScreen.routeName);
                      },
                      secondaryVisible: false,
                      isEnabled: true,
                      secondaryOnPress: () {},
                      clearOnPress: () {}),
                  Expanded(child: TicketListBody(ticketListDatum: data))
                ]);
              } else if (state is TicketsNotFetched) {
                return const Center(
                    child: Text(StringConstants.kNoRecordsFound));
              }
              return const SizedBox.shrink();
            })));
  }
}
