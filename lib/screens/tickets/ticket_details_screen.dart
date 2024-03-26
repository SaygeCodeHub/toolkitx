import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/tickets/tickets_bloc.dart';
import 'package:toolkit/screens/tickets/widgets/ticket_comments_tab.dart';
import 'package:toolkit/screens/tickets/widgets/ticket_details_pop_up_menu.dart';
import 'package:toolkit/screens/tickets/widgets/ticket_details_tab.dart';
import 'package:toolkit/screens/tickets/widgets/ticket_documents_tab.dart';
import 'package:toolkit/screens/tickets/widgets/ticket_logs_tab.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/status_tag_model.dart';
import '../../utils/ticket_util.dart';
import '../../widgets/custom_tabbar_view.dart';
import '../../widgets/status_tag.dart';

class TicketDetailsScreen extends StatelessWidget {
  static const routeName = 'TicketDetailsScreen';

  const TicketDetailsScreen({super.key, required this.ticketId});

  final String ticketId;

  @override
  Widget build(BuildContext context) {
    context
        .read<TicketsBloc>()
        .add(FetchTicketDetails(ticketId: ticketId, ticketTabIndex: 0));
    return Scaffold(
      appBar: GenericAppBar(
        actions: [
          BlocBuilder<TicketsBloc, TicketsStates>(
              buildWhen: (previousState, currentState) =>
                  currentState is TicketDetailsFetched,
              builder: (context, state) {
                if (state is TicketDetailsFetched) {
                  return TicketsDetailsPopUpMenu(
                      popUpMenuItems: state.ticketPopUpMenu,
                      fetchTicketDetailsModel: state.fetchTicketDetailsModel);
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
          child: BlocBuilder<TicketsBloc, TicketsStates>(
            buildWhen: (previousState, currentState) =>
                currentState is TicketDetailsFetching ||
                currentState is TicketDetailsFetched ||
                currentState is TicketDetailsNotFetched,
            builder: (context, state) {
              if (state is TicketDetailsFetching) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TicketDetailsFetched) {
                var data = state.fetchTicketDetailsModel.data;
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
                      tabBarViewIcons: TicketsUtil().tabBarViewIcons,
                      initialIndex: context.read<TicketsBloc>().ticketTabIndex,
                      tabBarViewWidgets: [
                        TicketDetailsTab(ticketData: data),
                        TicketCommentsTab(ticketData: data),
                        TicketDocumentsTab(ticketData: data),
                        TicketLogTab(ticketData: data),
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
