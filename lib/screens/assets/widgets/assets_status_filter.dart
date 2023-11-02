import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/assets/assets_bloc.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/models/assets/assets_master_model.dart';
import '../../../widgets/custom_choice_chip.dart';

class AssetsStatusFilter extends StatelessWidget {
  const AssetsStatusFilter(
      {super.key, required this.assetsFilterMap, required this.data});
  final Map assetsFilterMap;
  final List<List<Datum>> data;

  @override
  Widget build(BuildContext context) {
    context
        .read<AssetsBloc>()
        .add(SelectAssetsStatus(id: assetsFilterMap['status'] ?? ''));
    return Wrap(spacing: kFilterTags, children: choiceChips());
  }

  List<Widget> choiceChips() {
    List<Widget> chips = [];
    for (int i = 0; i < data[2].length; i++) {
      Widget item = BlocBuilder<AssetsBloc, AssetsState>(
          buildWhen: (previousState, currentState) =>
              currentState is AssetsStatusSelected,
          builder: (context, state) {
            if (state is AssetsStatusSelected) {
              String id = data[2][i].id.toString();
              assetsFilterMap["status"] = state.id;
              return CustomChoiceChip(
                label: data[2][i].assetstatus,
                selected: (assetsFilterMap['status'] == null)
                    ? false
                    : state.id == id,
                onSelected: (bool val) {
                  context.read<AssetsBloc>().add(SelectAssetsStatus(id: id));
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
