import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/tickets/tickets_bloc.dart';
import '../../../blocs/tickets2/tickets2_bloc.dart';
import '../../../blocs/tickets2/tickets2_event.dart';
import '../../../blocs/tickets2/tickets2_state.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/generic_app_bar.dart';
import '../add_ticket2_screen.dart';
import '../ticket_two_filter_screen.dart';

class TicketTwoApplicationFilterList extends StatelessWidget {
  static const routeName = "TicketTwoApplicationFilterList";

  const TicketTwoApplicationFilterList(
      {super.key, required this.selectApplicationName});

  final String selectApplicationName;

  @override
  Widget build(BuildContext context) {
    context.read<Tickets2Bloc>().add(FetchTicket2Master(responsequeid: ''));
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kSelectApplication),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.only(
                  left: leftRightMargin, right: leftRightMargin),
              child: BlocBuilder<Tickets2Bloc, Tickets2States>(
                buildWhen: (previousState, currentState) =>
                    currentState is Ticket2MasterFetching ||
                    currentState is Ticket2MasterFetched ||
                    currentState is Ticket2MasterNotFetched,
                builder: (context, state) {
                  if (state is Ticket2MasterFetching) {
                    return Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 2.4),
                        child:
                            const Center(child: CircularProgressIndicator()));
                  } else if (state is Ticket2MasterFetched) {
                    var data = state.fetchTicket2MasterModel.data;
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: data[0].length,
                              itemBuilder: (context, index) {
                                return RadioListTile(
                                    contentPadding: EdgeInsets.zero,
                                    activeColor: AppColor.deepBlue,
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                    title: Text(data[0][index].name),
                                    value: data[0][index].id,
                                    groupValue: selectApplicationName,
                                    onChanged: (value) {
                                      TicketTwoFilterScreen
                                              .ticketsFilterMap["appname"] =
                                          data[0][index].id;
                                      AddTicket2Screen
                                              .saveTicketMap['application'] =
                                          data[0][index].id;
                                      context.read<Tickets2Bloc>().add(
                                          SelectTicket2Application(
                                              selectApplicationName:
                                                  data[0][index].id));
                                      context
                                              .read<Tickets2Bloc>()
                                              .selectApplicationName =
                                          data[0][index].name;
                                      Navigator.pop(context);
                                    });
                              }),
                          const SizedBox(height: xxxSmallerSpacing)
                        ]);
                  } else if (state is TicketMasterNotFetched) {
                    return const Center(
                        child: Text(StringConstants.kNoRecordsFound));
                  }
                  return const SizedBox.shrink();
                },
              )),
        ));
  }
}
