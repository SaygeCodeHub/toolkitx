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

class TransferAndCPTiles extends StatefulWidget {
  const TransferAndCPTiles({
    super.key,
    required this.data,
  });

  final List<List<GetDataForCPDatum>> data;

  @override
  State<TransferAndCPTiles> createState() => _TransferAndCPTilesState();
}

class _TransferAndCPTilesState extends State<TransferAndCPTiles> {
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
        Text(StringConstants.kCP,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(fontWeight: FontWeight.w500, color: AppColor.black)),
        const SizedBox(height: tiniestSpacing),
        BlocBuilder<PermitBloc, PermitStates>(
          buildWhen: (previous, current) => current is TransferValueSelected,
          builder: (context, state) {
            if (state is TransferValueSelected) {
              return Visibility(
                visible: state.value == '1',
                replacement: TransferCPSapExpansionTile(
                    createdForTransferCp: (id, name) {},
                    getDataForCPDatum: widget.data[2]),
                child: TransferCPWorkForceExpansionTile(
                    createdForTransferCp: (id, name) {},
                    getDataForCPDatum: widget.data[1]),
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
