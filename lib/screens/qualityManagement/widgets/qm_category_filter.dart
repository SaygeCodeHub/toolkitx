import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/qm_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/qm_events.dart';
import 'package:toolkit/blocs/qualityManagement/qm_states.dart';
import '../../../configs/app_dimensions.dart';
import '../../../widgets/custom_choice_chip.dart';

class QMCategoryFilter extends StatefulWidget {
  const QMCategoryFilter({super.key, required this.qmFilterMap});

  final Map qmFilterMap;

  @override
  State<QMCategoryFilter> createState() => _QMCategoryFilterState();
}

class _QMCategoryFilterState extends State<QMCategoryFilter> {
  bool isSelected = false;
  String selectedValue = '';

  @override
  Widget build(BuildContext context) {
    context
        .read<QualityManagementBloc>()
        .add(FetchQualityManagementMaster(reportNewQAMap: {}));
    return BlocBuilder<QualityManagementBloc, QualityManagementStates>(
        buildWhen: (previousState, currentState) =>
            currentState is QualityManagementMasterFetched,
        builder: (context, state) {
          if (state is QualityManagementMasterFetched) {
            return Wrap(
                spacing: kFilterTags,
                children:
                    choiceChips(state.fetchQualityManagementMasterModel.data));
          } else {
            return const SizedBox.shrink();
          }
        });
  }

  List<Widget> choiceChips(data) {
    List<Widget> chips = [];
    for (int i = 0; i < data![4].length; i++) {
      Widget item = CustomChoiceChip(
        label: data![4][i].name,
        selected: (widget.qmFilterMap['cat'] == null)
            ? isSelected
            : selectedValue == data[4][i].id.toString(),
        onSelected: (bool value) {
          setState(() {
            isSelected = value;
            selectedValue = data[4][i].id.toString();
            widget.qmFilterMap['cat'] = selectedValue;
          });
        },
      );
      chips.add(item);
    }
    return chips;
  }
}
