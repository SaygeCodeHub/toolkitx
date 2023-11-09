import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/assets/assets_bloc.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/models/assets/assets_master_model.dart';
import '../../../widgets/custom_choice_chip.dart';

class AssetsFailureCodeChips extends StatelessWidget {
  const AssetsFailureCodeChips(
      {super.key, required this.data, required this.assetsReportFailureMap});

  final List<List<Datum>> data;
  final Map assetsReportFailureMap;

  @override
  Widget build(BuildContext context) {

    return Wrap(spacing: kFilterTags, children: choiceChips());
  }

  List<Widget> choiceChips() {
    List<Widget> chips = [];
    for (int i = 0; i < data[4].length; i++) {
      log("dataIndex=================>${data[4][i].failureSetCode}");
      Widget item = BlocBuilder<AssetsBloc, AssetsState>(
          buildWhen: (previousState, currentState) =>
              currentState is AssetsSiteSelected,
          builder: (context, state) {
            if (state is AssetsSiteSelected) {
              String id = data[4][i].id.toString();
              assetsReportFailureMap['failureCode'] = state.id.toString();
              return CustomChoiceChip(
                label: data[4][i].failureSetCode,
                selected: (assetsReportFailureMap['failureCode'] == null)
                    ? false
                    : state.id == id,
                onSelected: (bool val) {
                  context
                      .read<AssetsBloc>()
                      .add(SelectAssetsFailureCode(id: id));
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          });
      chips.add(item);
    }
    return chips;
  }
}
