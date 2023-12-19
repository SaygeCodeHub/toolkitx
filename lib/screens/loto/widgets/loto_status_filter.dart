import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/enums/loto_status_enum.dart';
import 'package:toolkit/data/models/loto/loto_master_model.dart';
import 'package:toolkit/widgets/custom_choice_chip.dart';

import '../../../blocs/loto/loto_list/loto_list_bloc.dart';
import '../../../configs/app_dimensions.dart';

class LotoStatusFilter extends StatelessWidget {
  final List<List<LotoMasterDatum>> data;
  final Map lotoFilterMap;

  const LotoStatusFilter(
      {super.key, required this.data, required this.lotoFilterMap});

  @override
  Widget build(BuildContext context) {
    context.read<LotoListBloc>().add(
        SelectLotoStatusFilter(selectedIndex: lotoFilterMap["status"] ?? ''));
    return Wrap(spacing: kFilterTags, children: choiceChips());
  }

  List<Widget> choiceChips() {
    List<Widget> chips = [];
    for (int i = 0; i < LotoStatusEnum.values.length; i++) {
      String id = LotoStatusEnum.values[i].value.toString();
      Widget item = BlocBuilder<LotoListBloc, LotoListState>(
        buildWhen: (previousState, currentState) =>
            currentState is LotoStatusFilterSelected,
        builder: (context, state) {
          if (state is LotoStatusFilterSelected) {
            lotoFilterMap["status"] = state.selectedIndex;
            return CustomChoiceChip(
                label: LotoStatusEnum.values[i].name,
                selected: (lotoFilterMap["status"] == null)
                    ? false
                    : lotoFilterMap["status"] == id,
                onSelected: (bool value) {
                  context
                      .read<LotoListBloc>()
                      .add(SelectLotoStatusFilter(selectedIndex: id));
                });
          } else {
            return const SizedBox.shrink();
          }
        },
      );
      chips.add(item);
    }
    return chips;
  }
}
