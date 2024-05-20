import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/tickets/tickets_bloc.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/enums/open_ticket_enum.dart';
import '../../../widgets/expansion_tile_border.dart';

typedef CreatedForVoValue = Function(String value);

class OpenTicketExpansionTile extends StatelessWidget {
  const OpenTicketExpansionTile({
    super.key,
    required this.createdForVoValue,
  });

  final CreatedForVoValue createdForVoValue;

  @override
  Widget build(BuildContext context) {
    context.read<TicketsBloc>().add(SelectVoValue(value: '', vo: ''));
    return BlocBuilder<TicketsBloc, TicketsStates>(
        buildWhen: (previousState, currentState) =>
            currentState is VoValueSelected,
        builder: (context, state) {
          if (state is VoValueSelected) {
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
                                    title: Text(OpenTicketEnum.values
                                        .elementAt(index)
                                        .vo),
                                    onTap: () {
                                      context
                                          .read<TicketsBloc>()
                                          .add(
                                              SelectVoValue(
                                                  vo: OpenTicketEnum.values
                                                      .elementAt(index)
                                                      .vo,
                                                  value: OpenTicketEnum.values
                                                      .elementAt(index)
                                                      .value));
                                      createdForVoValue(OpenTicketEnum.values
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
