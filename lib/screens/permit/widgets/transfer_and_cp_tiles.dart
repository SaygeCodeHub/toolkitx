import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';
import 'package:toolkit/blocs/permit/permit_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/permit/widgets/transfer_cp_sap_expansion_tile.dart';
import 'package:toolkit/screens/permit/widgets/transfer_cp_workforce_expansion_tile.dart';
import 'package:toolkit/screens/permit/widgets/transfer_to_expansion_tile.dart';

import '../../../blocs/permit/permit_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/permit/fetch_data_for_change_permit_cp_model.dart';
import '../../../utils/constants/string_constants.dart';

class TransferAndCPTiles extends StatelessWidget {
  const TransferAndCPTiles({
    super.key,
    required this.data,
    required this.changePermitCPMap,
  });

  final List<List<GetDataForCPDatum>> data;
  final Map changePermitCPMap;

  @override
  Widget build(BuildContext context) {
    context.read<PermitBloc>().add(SelectTransferValue(value: '1'));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TransferToExpansionTile(
          createdForTransfer: (String value) {
            context.read<PermitBloc>().add(SelectTransferValue(value: value));
          },
        ),
        const SizedBox(height: xxTinierSpacing),
        BlocBuilder<PermitBloc, PermitStates>(
          buildWhen: (previous, current) => current is TransferValueSelected,
          builder: (context, state) {
            if (state is TransferValueSelected) {
              changePermitCPMap['sap'] = '';
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      state.value == '1'
                          ? StringConstants.kCP
                          : StringConstants.kSAP,
                      style: Theme.of(context).textTheme.xSmall.copyWith(
                          fontWeight: FontWeight.w500, color: AppColor.black)),
                  const SizedBox(height: tiniestSpacing),
                  Visibility(
                    visible: state.value == '1',
                    replacement: TransferCPSapExpansionTile(
                        createdForTransferCp: (id, name) {
                          changePermitCPMap['sap'] = id.toString();
                        },
                        getDataForCPDatum: data[2]),
                    child: TransferCPWorkForceExpansionTile(
                        createdForTransferCp: (id, name) {
                          changePermitCPMap['npw'] = id.toString();
                        },
                        getDataForCPDatum: data[1]),
                  ),
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
