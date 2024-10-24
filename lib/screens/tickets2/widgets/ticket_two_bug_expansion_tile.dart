import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../../blocs/tickets2/tickets2_bloc.dart';
import '../../../blocs/tickets2/tickets2_event.dart';
import '../../../blocs/tickets2/tickets2_state.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/enums/ticketTwo/ticket_two_bug_enum.dart';
import '../../../widgets/expansion_tile_border.dart';

class TicketTwoBugExpansionTile extends StatelessWidget {
  const TicketTwoBugExpansionTile({
    super.key,
    required this.saveTicketMap,
  });

  final Map saveTicketMap;

  String getButOption() {
    if (saveTicketMap['isbug'] != null) {
      var ele = TicketTwoBugEnum.values
          .firstWhere((element) => element.value == saveTicketMap['isbug']);
      if (ele.value.isNotEmpty) {
        return ele.option;
      } else {
        return TicketTwoBugEnum.no.option;
      }
    } else {
      return TicketTwoBugEnum.no.option;
    }
  }

  @override
  Widget build(BuildContext context) {
    context.read<Tickets2Bloc>().add(SelectTicketTwoBugType(
        bugType: getButOption(),
        bugValue: (saveTicketMap['isbug'] != null)
            ? saveTicketMap['isbug']
            : TicketTwoBugEnum.no.value));
    (saveTicketMap['isbug'] != null)
        ? null
        : saveTicketMap['isbug'] = TicketTwoBugEnum.no.value;
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: AppColor.transparent),
        child: BlocBuilder<Tickets2Bloc, Tickets2States>(
          buildWhen: (previousState, currentState) =>
              currentState is TicketTwoBugTypeSelected,
          builder: (context, state) {
            if (state is TicketTwoBugTypeSelected) {
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
                          ? TicketTwoBugEnum.no.option
                          : state.bugType,
                      style: Theme.of(context).textTheme.xSmall),
                  children: [
                    ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: TicketTwoBugEnum.values.length,
                        itemBuilder: (BuildContext context, int index) {
                          return RadioListTile(
                              contentPadding: const EdgeInsets.only(
                                  left: kRadioListTilePaddingLeft,
                                  right: kRadioListTilePaddingRight),
                              activeColor: AppColor.deepBlue,
                              title: Text(
                                  DatabaseUtil.getText(TicketTwoBugEnum.values
                                      .elementAt(index)
                                      .option),
                                  style: Theme.of(context).textTheme.xSmall),
                              controlAffinity: ListTileControlAffinity.trailing,
                              value: TicketTwoBugEnum.values
                                  .elementAt(index)
                                  .option,
                              groupValue: state.bugType,
                              onChanged: (value) {
                                value = TicketTwoBugEnum.values
                                    .elementAt(index)
                                    .option;
                                saveTicketMap['isbug'] = TicketTwoBugEnum.values
                                    .elementAt(index)
                                    .value;
                                context.read<Tickets2Bloc>().add(
                                    SelectTicketTwoBugType(
                                        bugType: value,
                                        bugValue: TicketTwoBugEnum.values
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
