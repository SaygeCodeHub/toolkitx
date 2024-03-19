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
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_no_records_text.dart';

class TicketListScreen extends StatelessWidget {
  static const routeName = 'TicketListScreen';
  static int pageNo = 1;
  final bool isFromHome;

  const TicketListScreen({super.key, required this.isFromHome});

  @override
  Widget build(BuildContext context) {
    pageNo = 1;
    context.read<TicketsBloc>().filters = {};
    context
        .read<TicketsBloc>()
        .add(FetchTickets(pageNo: pageNo, isFromHome: isFromHome));
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('Ticket')),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing,
                bottom: xxTinierSpacing),
            child: BlocBuilder<TicketsBloc, TicketsStates>(
                buildWhen: (previousState, currentState) {
              if (currentState is TicketsFetching &&
                  pageNo == 1 &&
                  isFromHome == true) {
                return true;
              } else if (currentState is TicketsFetched) {
                return true;
              }
              return false;
            }, builder: (context, state) {
              if (state is TicketsFetching) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TicketsFetched) {
                return Column(children: [
                  CustomIconButtonRow(
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
                        context.read<TicketsBloc>().hasReachedMax = false;
                        context.read<TicketsBloc>().ticketDatum = [];
                        context.read<TicketsBloc>().filters = {};
                        context.read<TicketsBloc>().selectApplicationName = '';
                        context.read<TicketsBloc>().add(ClearTicketsFilter());
                        context.read<TicketsBloc>().add(
                            FetchTickets(pageNo: 1, isFromHome: isFromHome));
                      }),
                  BlocConsumer<TicketsBloc, TicketsStates>(
                      buildWhen: (previousState, currentState) =>
                          (currentState is TicketsFetching && pageNo == 1) ||
                          (currentState is TicketsFetched),
                      listener: (context, state) {
                        if (state is TicketsFetched) {
                          if (state.fetchTicketsModel.status == 204 &&
                              context
                                  .read<TicketsBloc>()
                                  .ticketDatum
                                  .isNotEmpty) {
                            showCustomSnackBar(
                                context, StringConstants.kAllDataLoaded, '');
                          }
                        }
                      },
                      builder: (context, state) {
                        if (state is TicketsFetching) {
                          return const Expanded(
                              child:
                                  Center(child: CircularProgressIndicator()));
                        } else if (state is TicketsFetched) {
                          if (context
                              .read<TicketsBloc>()
                              .ticketDatum
                              .isNotEmpty) {
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
                ]);
              } else if (state is TicketsNotFetched) {
                return const Center(
                    child: Text(StringConstants.kNoRecordsFound));
              }
              return const SizedBox.shrink();
            })));
  }
}
