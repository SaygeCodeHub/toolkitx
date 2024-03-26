import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/tickets/add_ticket_screen.dart';
import '../../../blocs/tickets/tickets_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/generic_app_bar.dart';
import '../tickets_filter_screen.dart';

class TicketApplicationFilterList extends StatelessWidget {
  static const routeName = "TicketApplicationFilterList";

  const TicketApplicationFilterList(
      {super.key, required this.selectApplicationName});

  final String selectApplicationName;

  @override
  Widget build(BuildContext context) {
    context.read<TicketsBloc>().add(FetchTicketMaster());
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kSelectApplication),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.only(
                  left: leftRightMargin, right: leftRightMargin),
              child: BlocBuilder<TicketsBloc, TicketsStates>(
                buildWhen: (previousState, currentState) =>
                    currentState is TicketMasterFetching ||
                    currentState is TicketMasterFetched ||
                    currentState is TicketMasterNotFetched,
                builder: (context, state) {
                  if (state is TicketMasterFetching) {
                    return Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 2.4),
                        child:
                            const Center(child: CircularProgressIndicator()));
                  } else if (state is TicketMasterFetched) {
                    var data = state.fetchTicketMasterModel.data;
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
                                    title: Text(data[0][index].appname),
                                    value: data[0][index].id,
                                    groupValue: selectApplicationName,
                                    onChanged: (value) {
                                      TicketsFilterScreen
                                              .ticketsFilterMap["appname"] =
                                          data[0][index].id;
                                      AddTicketScreen
                                              .saveTicketMap['application'] =
                                          data[0][index].id;
                                      context.read<TicketsBloc>().add(
                                          SelectTicketApplication(
                                              selectApplicationName:
                                                  data[0][index].id));
                                      context
                                              .read<TicketsBloc>()
                                              .selectApplicationName =
                                          data[0][index].appname;
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
