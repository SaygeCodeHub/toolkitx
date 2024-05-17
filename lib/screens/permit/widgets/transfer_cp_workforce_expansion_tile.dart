import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';
import 'package:toolkit/blocs/permit/permit_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../blocs/permit/permit_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/models/permit/fetch_data_for_change_permit_cp_model.dart';
import '../../../widgets/expansion_tile_border.dart';

typedef CreatedForTransferCP = Function(int id, String name);

class TransferCPWorkForceExpansionTile extends StatelessWidget {
  const TransferCPWorkForceExpansionTile(
      {Key? key,
      required this.createdForTransferCp,
      required this.getDataForCPDatum})
      : super(key: key);
  final CreatedForTransferCP createdForTransferCp;
  final List<GetDataForCPDatum> getDataForCPDatum;

  @override
  Widget build(BuildContext context) {
    context.read<PermitBloc>().add(SelectTransferCPWorkForce(id: 0, name: ''));
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: AppColor.transparent),
        child: BlocBuilder<PermitBloc, PermitStates>(
          buildWhen: (previousState, currentState) =>
              currentState is TransferCPWorkforceSelected,
          builder: (context, state) {
            if (state is TransferCPWorkforceSelected) {
              return ExpansionTile(
                  collapsedShape:
                      ExpansionTileBorder().buildOutlineInputBorder(),
                  collapsedBackgroundColor: AppColor.white,
                  backgroundColor: AppColor.white,
                  shape: ExpansionTileBorder().buildOutlineInputBorder(),
                  maintainState: true,
                  key: GlobalKey(),
                  title: Text(
                      state.name == '' ? StringConstants.kSelect : state.name,
                      style: Theme.of(context).textTheme.xSmall),
                  children: [
                    ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: getDataForCPDatum.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                              contentPadding: const EdgeInsets.only(
                                  left: kRadioListTilePaddingLeft,
                                  right: kRadioListTilePaddingRight),
                              title: Text(getDataForCPDatum[index].name!),
                              onTap: () {
                                context.read<PermitBloc>().add(
                                    SelectTransferCPWorkForce(
                                        name: getDataForCPDatum[index].name!,
                                        id: getDataForCPDatum[index]
                                            .constructionId!));
                                createdForTransferCp(
                                    getDataForCPDatum[index].constructionId!,
                                    getDataForCPDatum[index].name!);
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
