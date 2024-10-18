import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/enums/ticket_bug_enum.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../../blocs/tickets/tickets_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../widgets/expansion_tile_border.dart';

class TicketBugExpansionTile extends StatelessWidget {
  const TicketBugExpansionTile({
    Key? key,
    required this.saveTicketMap,
  }) : super(key: key);
  final Map saveTicketMap;

  @override
  Widget build(BuildContext context) {
    context.read<TicketsBloc>().add(SelectBugType(
        bugType: TicketBugEnum.no.option, bugValue: TicketBugEnum.no.value));
    saveTicketMap['isbug'] = TicketBugEnum.no.value;
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: AppColor.transparent),
        child: BlocBuilder<TicketsBloc, TicketsStates>(
          buildWhen: (previousState, currentState) =>
              currentState is BugTypeSelected,
          builder: (context, state) {
            if (state is BugTypeSelected) {
              return ExpansionTile(
                  collapsedShape:
                      ExpansionTileBorder().buildOutlineInputBorder(),
                  collapsedBackgroundColor: AppColor.white,
                  backgroundColor: AppColor.white,
                  shape: ExpansionTileBorder().buildOutlineInputBorder(),
                  maintainState: true,
                  key: GlobalKey(),
                  title: Text(
                      state.bugType == 'null'
                          ? TicketBugEnum.no.option
                          : state.bugType,
                      style: Theme.of(context).textTheme.xSmall),
                  children: [
                    ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: TicketBugEnum.values.length,
                        itemBuilder: (BuildContext context, int index) {
                          return RadioListTile(
                              contentPadding: const EdgeInsets.only(
                                  left: kRadioListTilePaddingLeft,
                                  right: kRadioListTilePaddingRight),
                              activeColor: AppColor.deepBlue,
                              title: Text(
                                  DatabaseUtil.getText(TicketBugEnum.values
                                      .elementAt(index)
                                      .option),
                                  style: Theme.of(context).textTheme.xSmall),
                              controlAffinity: ListTileControlAffinity.trailing,
                              value:
                                  TicketBugEnum.values.elementAt(index).option,
                              groupValue: state.bugType,
                              onChanged: (value) {
                                value = TicketBugEnum.values
                                    .elementAt(index)
                                    .option;
                                saveTicketMap['isbug'] =
                                    TicketBugEnum.values.elementAt(index).value;
                                context.read<TicketsBloc>().add(SelectBugType(
                                    bugType: value,
                                    bugValue: TicketBugEnum.values
                                        .elementAt(index)
                                        .value));
                              });
                        })
                  ]);
            } else {
              return const SizedBox.shrink();
            }
          },
        ));
  }
}
