import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/tickets/tickets_filter_screen.dart';
import 'package:toolkit/screens/tickets/add_ticket_screen.dart';
import 'package:toolkit/screens/tickets/widgets/ticket_list_body.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import '../../blocs/tickets2/tickets2_bloc.dart';
import '../../blocs/tickets2/tickets2_event.dart';
import '../../blocs/tickets2/tickets2_state.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/custom_icon_button_row.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_no_records_text.dart';

class TicketTwoListScreen extends StatelessWidget {
  static const routeName = 'TicketTwoListScreen';
  static int pageNo = 1;
  final bool isFromHome;

  const TicketTwoListScreen({super.key, required this.isFromHome});

  @override
  Widget build(BuildContext context) {
    pageNo = 1;
    context.read<Tickets2Bloc>().hasReachedMax = false;
    context.read<Tickets2Bloc>().ticketDatum.clear();
    context
        .read<Tickets2Bloc>()
        .add(FetchTickets2(pageNo: pageNo, isFromHome: isFromHome));
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('Ticket')),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, AddTicketScreen.routeName).then(
                  (_) => Navigator.pushReplacementNamed(
                      context, TicketTwoListScreen.routeName,
                      arguments: isFromHome));
            },
            child: const Icon(Icons.add)),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing,
                bottom: xxTinierSpacing),
            child: Column(children: [
              BlocBuilder<Tickets2Bloc, Tickets2States>(
                  buildWhen: (previousState, currentState) {
                if (currentState is Tickets2Fetching &&
                    pageNo == 1 &&
                    isFromHome == true) {
                  return true;
                } else if (currentState is Tickets2Fetched) {
                  return true;
                }
                return false;
              }, builder: (context, state) {
                if (state is Tickets2Fetched) {
                  return CustomIconButtonRow(
                      primaryOnPress: () {
                        Navigator.pushNamed(
                            context, TicketsFilterScreen.routeName);
                      },
                      secondaryOnPress: () {},
                      secondaryVisible: false,
                      clearVisible:
                          state.filterMap.isNotEmpty && isFromHome != true,
                      clearOnPress: () {
                        pageNo = 1;
                        context.read<Tickets2Bloc>().hasReachedMax = false;
                        context.read<Tickets2Bloc>().filters.clear();
                        context.read<Tickets2Bloc>().ticketDatum.clear();
                        context.read<Tickets2Bloc>().selectApplicationName = '';
                        // context.read<Tickets2Bloc>().add(ClearTicketsFilter());
                        context.read<Tickets2Bloc>().add(
                            FetchTickets2(pageNo: 1, isFromHome: isFromHome));
                      });
                } else {
                  return const SizedBox.shrink();
                }
              }),
              const SizedBox(height: xxTinierSpacing),
              BlocConsumer<Tickets2Bloc, Tickets2States>(
                  buildWhen: (previousState, currentState) =>
                      (currentState is Tickets2Fetching && pageNo == 1) ||
                      (currentState is Tickets2Fetched),
                  listener: (context, state) {
                    if (state is Tickets2Fetched &&
                        context.read<Tickets2Bloc>().hasReachedMax) {
                      showCustomSnackBar(
                          context, StringConstants.kAllDataLoaded, '');
                    }
                  },
                  builder: (context, state) {
                    if (state is Tickets2Fetching) {
                      return const Expanded(
                          child: Center(child: CircularProgressIndicator()));
                    } else if (state is Tickets2Fetched) {
                      if (state.ticketData.isNotEmpty) {
                        return Expanded(
                            child: TicketListBody(
                                ticketListDatum: state.ticketData));
                      } else {
                        return NoRecordsText(
                            text: DatabaseUtil.getText('no_records_found'));
                      }
                    } else {
                      return const SizedBox.shrink();
                    }
                  })
            ])));
  }
}
