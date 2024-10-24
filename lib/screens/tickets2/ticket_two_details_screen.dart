import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/tickets/tickets_bloc.dart';
import 'package:toolkit/screens/tickets2/widgets/ticket_details_pop_up_menu.dart';
import 'package:toolkit/screens/tickets2/widgets/ticket_two_comments_tab.dart';
import 'package:toolkit/screens/tickets2/widgets/ticket_two_details_tab.dart';
import 'package:toolkit/screens/tickets2/widgets/ticket_two_document_tab.dart';
import 'package:toolkit/screens/tickets2/widgets/ticket_two_logs_tab.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../blocs/tickets2/tickets2_bloc.dart';
import '../../blocs/tickets2/tickets2_event.dart';
import '../../blocs/tickets2/tickets2_state.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/status_tag_model.dart';
import '../../utils/ticketTwo/tickets_two_util.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/custom_tabbar_view.dart';
import '../../widgets/progress_bar.dart';
import '../../widgets/status_tag.dart';

class TicketTwoDetailsScreen extends StatelessWidget {
  static const routeName = 'TicketTwoDetailsScreen';

  const TicketTwoDetailsScreen({super.key, required this.ticketId});

  final String ticketId;

  @override
  Widget build(BuildContext context) {
    context
        .read<Tickets2Bloc>()
        .add(FetchTicket2Details(ticketId: ticketId, ticketTabIndex: 0));
    return Scaffold(
      appBar: GenericAppBar(
        actions: [
          BlocConsumer<Tickets2Bloc, Tickets2States>(
              listener: (context, state) {
                if (state is Ticket2StatusUpdating) {
                  ProgressBar.show(context);
                } else if (state is Ticket2StatusUpdated) {
                  ProgressBar.dismiss(context);
                  context.read<Tickets2Bloc>().add(FetchTicket2Details(
                      ticketId: context.read<Tickets2Bloc>().ticket2Id,
                      ticketTabIndex: 0));
                } else if (state is Ticket2StatusNotUpdated) {
                  ProgressBar.dismiss(context);
                  showCustomSnackBar(context, state.errorMessage, '');
                }

                if (state is RejectingTicketTwo) {
                  ProgressBar.show(context);
                } else if (state is TicketTwoRejected) {
                  ProgressBar.dismiss(context);
                  Navigator.pop(context);
                  context.read<Tickets2Bloc>().add(FetchTicket2Details(
                      ticketId: ticketId, ticketTabIndex: 0));
                } else if (state is TicketTwoNotRejected) {
                  ProgressBar.dismiss(context);
                  showCustomSnackBar(context, state.errorMessage, '');
                }
              },
              buildWhen: (previousState, currentState) =>
                  currentState is Ticket2DetailsFetched,
              builder: (context, state) {
                if (state is Ticket2DetailsFetched) {
                  return TicketTwoDetailsPopUpMenu(
                      popUpMenuItems: state.ticketPopUpMenu,
                      fetchTicketTwoDetailsModel:
                          state.fetchTicketTwoDetailsModel);
                } else {
                  return const SizedBox();
                }
              })
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxTinierSpacing),
          child: BlocBuilder<Tickets2Bloc, Tickets2States>(
            buildWhen: (previousState, currentState) =>
                currentState is Ticket2DetailsFetching ||
                currentState is Ticket2DetailsFetched ||
                currentState is Ticket2DetailsNotFetched,
            builder: (context, state) {
              if (state is Ticket2DetailsFetching) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is Ticket2DetailsFetched) {
                var data = state.fetchTicketTwoDetailsModel.data;
                return Column(children: [
                  Card(
                      color: AppColor.white,
                      elevation: kCardElevation,
                      child: ListTile(
                          title: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: xxTinierSpacing),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(data.ticketno),
                                    StatusTag(tags: [
                                      StatusTagModel(
                                          title: data.statusname,
                                          bgColor: AppColor.deepBlue)
                                    ])
                                  ])))),
                  const SizedBox(height: xxTinierSpacing),
                  const Divider(
                      height: kDividerHeight, thickness: kDividerWidth),
                  const SizedBox(height: xxTinierSpacing),
                  CustomTabBarView(
                      lengthOfTabs: 4,
                      tabBarViewIcons: TicketsTwoUtil().tabBarViewIcons,
                      initialIndex: context.read<Tickets2Bloc>().ticketTabIndex,
                      tabBarViewWidgets: [
                        TicketTwoDetailsTab(ticketTwoData: data),
                        TicketTwoCommentsTab(ticketTwoData: data),
                        TicketTwoDocumentsTab(
                            ticketTwoData: data, clientId: state.clientId),
                        TicketTwoLogTab(ticketTwoData: data)
                      ])
                ]);
              } else if (state is TicketDetailsNotFetched) {
                return const Center(child: Text(StringConstants.kNoData));
              }
              return const SizedBox.shrink();
            },
          )),
    );
  }
}
