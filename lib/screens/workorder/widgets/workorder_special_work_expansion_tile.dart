import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_states.dart';
import '../../../configs/app_color.dart';
import '../../../utils/constants/string_constants.dart';

class WorkOrderSpecialWorkExpansionTile extends StatelessWidget {
  final List data;
  final Map workOrderDetailsMap;

  const WorkOrderSpecialWorkExpansionTile(
      {Key? key, required this.data, required this.workOrderDetailsMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List specialIds = [];
    List specialName = [];
    specialIds = workOrderDetailsMap['specialwork'].toString().split(',');
    specialName = workOrderDetailsMap['specialworknames'].toString().split(',');
    context.read<WorkOrderTabDetailsBloc>().add(SelectSpecialWorkOptions(
        specialWorkName: '',
        specialWorkIdList: specialIds,
        specialWorkId: '',
        specialWorkNameList: specialName));
    return BlocBuilder<WorkOrderTabDetailsBloc, WorkOrderTabDetailsStates>(
        buildWhen: (previousState, currentState) =>
            currentState is SpecialWorkOptionsSelected,
        builder: (context, state) {
          if (state is SpecialWorkOptionsSelected) {
            workOrderDetailsMap['specialwork'] = state.specialWorkIdList
                .toString()
                .replaceAll("[", "")
                .replaceAll("]", "");
            return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: AppColor.transparent),
                child: ExpansionTile(
                    maintainState: true,
                    title: Text(
                        (specialName.isEmpty)
                            ? StringConstants.kSelect
                            : specialName
                                .toString()
                                .replaceAll('[', '')
                                .replaceAll(']', ''),
                        style: Theme.of(context).textTheme.xSmall),
                    children: [
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data[9].length,
                          itemBuilder: (BuildContext context, int index) {
                            return CheckboxListTile(
                                contentPadding: EdgeInsets.zero,
                                checkColor: AppColor.white,
                                activeColor: AppColor.deepBlue,
                                value: specialIds
                                    .contains(data[9][index].id.toString()),
                                title: Text(data[9][index].name),
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                onChanged: (isChecked) {
                                  context.read<WorkOrderTabDetailsBloc>().add(
                                      SelectSpecialWorkOptions(
                                          specialWorkName: data[9][index].name,
                                          specialWorkIdList: specialName,
                                          specialWorkId:
                                              data[9][index].id.toString(),
                                          specialWorkNameList: specialIds));
                                });
                          })
                    ]));
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
