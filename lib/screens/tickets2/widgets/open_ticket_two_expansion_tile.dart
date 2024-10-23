import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/tickets2/tickets2_bloc.dart';
import '../../../blocs/tickets2/tickets2_event.dart';
import '../../../blocs/tickets2/tickets2_state.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/enums/ticketTwo/open_ticket_two_enum.dart';
import '../../../widgets/expansion_tile_border.dart';

typedef CreatedForVoValue = Function(String value);

class OpenTicketTwoExpansionTile extends StatelessWidget {
  const OpenTicketTwoExpansionTile({
    super.key,
    required this.createdForVoValue,
  });

  final CreatedForVoValue createdForVoValue;

  @override
  Widget build(BuildContext context) {
    context.read<Tickets2Bloc>().add(SelectTicketTwoVoValue(value: '', vo: ''));
    return BlocBuilder<Tickets2Bloc, Tickets2States>(
        buildWhen: (previousState, currentState) =>
            currentState is TicketTwoVoValueSelected,
        builder: (context, state) {
          if (state is TicketTwoVoValueSelected) {
            return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: AppColor.transparent),
                child: ExpansionTile(
                    shape: ExpansionTileBorder().buildOutlineInputBorder(),
                    collapsedBackgroundColor: AppColor.white,
                    backgroundColor: AppColor.white,
                    collapsedShape:
                        ExpansionTileBorder().buildOutlineInputBorder(),
                    key: GlobalKey(),
                    title: Text(state.vo),
                    children: [
                      MediaQuery(
                          data: MediaQuery.of(context)
                              .removePadding(removeTop: true),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: 2,
                              itemBuilder: (context, index) {
                                return ListTile(
                                    contentPadding: const EdgeInsets.only(
                                        left: xxTinierSpacing),
                                    title: Text(OpenTicketTwoEnum.values
                                        .elementAt(index)
                                        .vo),
                                    onTap: () {
                                      context.read<Tickets2Bloc>().add(
                                          SelectTicketTwoVoValue(
                                              vo: OpenTicketTwoEnum.values
                                                  .elementAt(index)
                                                  .vo,
                                              value: OpenTicketTwoEnum.values
                                                  .elementAt(index)
                                                  .value));
                                      createdForVoValue(OpenTicketTwoEnum.values
                                          .elementAt(index)
                                          .value);
                                    });
                              }))
                    ]));
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
