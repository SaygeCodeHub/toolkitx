import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/assets/assets_bloc.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/models/assets/assets_master_model.dart';
import '../../../widgets/custom_choice_chip.dart';

class AssetsSiteFilter extends StatelessWidget {
  const AssetsSiteFilter(
      {super.key, required this.assetsFilterMap, required this.data});
  final Map assetsFilterMap;
  final List<List<Datum>> data;

  @override
  Widget build(BuildContext context) {
    context
        .read<AssetsBloc>()
        .add(SelectAssetsSite(id: assetsFilterMap['site'] ?? ''));
    return Wrap(spacing: kFilterTags, children: choiceChips());
  }

  List<Widget> choiceChips() {
    List<Widget> chips = [];
    for (int i = 0; i < data[1].length; i++) {
      Widget item = BlocBuilder<AssetsBloc, AssetsState>(
          buildWhen: (previousState, currentState) =>
              currentState is AssetsSiteSelected,
          builder: (context, state) {
            if (state is AssetsSiteSelected) {
              String id = data[1][i].id.toString();
              assetsFilterMap['site'] = state.id.toString();
              return CustomChoiceChip(
                label: data[1][i].name,
                selected:
                    (assetsFilterMap['site'] == null) ? false : state.id == id,
                onSelected: (bool val) {
                  context.read<AssetsBloc>().add(SelectAssetsSite(id: id));
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
