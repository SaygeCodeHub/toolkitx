import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';
import 'package:toolkit/blocs/permit/permit_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/enums/transfer_permit_enum.dart';
import '../../../blocs/permit/permit_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../widgets/expansion_tile_border.dart';

typedef CreatedForTransfer = Function(String value);

class TransferToExpansionTile extends StatelessWidget {
  const TransferToExpansionTile({super.key, required this.createdForTransfer});
  final CreatedForTransfer createdForTransfer;

  @override
  Widget build(BuildContext context) {
    context.read<PermitBloc>().add(SelectTransferTo(
        transferType: TransferPermitEnum.workForce.type,
        transferValue: TransferPermitEnum.workForce.value));
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: AppColor.transparent),
        child: BlocBuilder<PermitBloc, PermitStates>(
          buildWhen: (previousState, currentState) =>
              currentState is TransferToSelected,
          builder: (context, state) {
            if (state is TransferToSelected) {
              return ExpansionTile(
                  collapsedShape:
                      ExpansionTileBorder().buildOutlineInputBorder(),
                  collapsedBackgroundColor: AppColor.white,
                  backgroundColor: AppColor.white,
                  shape: ExpansionTileBorder().buildOutlineInputBorder(),
                  maintainState: true,
                  key: GlobalKey(),
                  title: Text(
                      state.transferType == 'null'
                          ? TransferPermitEnum.workForce.type
                          : state.transferType,
                      style: Theme.of(context).textTheme.xSmall),
                  children: [
                    ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: TransferPermitEnum.values.length,
                        itemBuilder: (BuildContext context, int index) {
                          return RadioListTile(
                              contentPadding: const EdgeInsets.only(
                                  left: kRadioListTilePaddingLeft,
                                  right: kRadioListTilePaddingRight),
                              activeColor: AppColor.deepBlue,
                              title: Text(
                                  TransferPermitEnum.values
                                      .elementAt(index)
                                      .type,
                                  style: Theme.of(context).textTheme.xSmall),
                              controlAffinity: ListTileControlAffinity.trailing,
                              value: TransferPermitEnum.values
                                  .elementAt(index)
                                  .type,
                              groupValue: state.transferType,
                              onChanged: (value) {
                                value = TransferPermitEnum.values
                                    .elementAt(index)
                                    .type;
                                context.read<PermitBloc>().add(SelectTransferTo(
                                    transferType: value,
                                    transferValue: TransferPermitEnum.values
                                        .elementAt(index)
                                        .value));
                                createdForTransfer(TransferPermitEnum.values
                                    .elementAt(index)
                                    .value);
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
