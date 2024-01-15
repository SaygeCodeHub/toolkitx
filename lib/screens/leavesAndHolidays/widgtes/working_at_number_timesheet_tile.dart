import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/leavesAndHolidays/leaves_and_holidays_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/leavesAndHolidays/leaves_and_holidays_events.dart';
import '../../../blocs/leavesAndHolidays/leaves_and_holidays_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../widgets/expansion_tile_border.dart';

class WorkingAtNumberTimeSheetTile extends StatelessWidget {
  const WorkingAtNumberTimeSheetTile({super.key});

  static String workingAt = '';
  static String workingAtValue = '';

  @override
  Widget build(BuildContext context) {
    context.read<LeavesAndHolidaysBloc>().add(
        FetchTimeSheetWorkingAtNumberData(workingAt: '', workingAtValue: ''));
    return BlocBuilder<LeavesAndHolidaysBloc, LeavesAndHolidaysStates>(
        buildWhen: (previousState, currentState) =>
            currentState is TimeSheetWorkingAtFetched,
        builder: (context, state) {
          if (state is TimeSheetWorkingAtFetched) {
            return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: AppColor.transparent),
                child: ExpansionTile(
                  title: Text(state.workingAt,
                      style: Theme.of(context).textTheme.xSmall),
                  collapsedShape:
                      ExpansionTileBorder().buildOutlineInputBorder(),
                  collapsedBackgroundColor: AppColor.white,
                  backgroundColor: AppColor.white,
                  shape: ExpansionTileBorder().buildOutlineInputBorder(),
                  key: GlobalKey(),
                  children: [
                    ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.fetchWorkingAtTimeSheetModel.data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            contentPadding: const EdgeInsets.only(
                                left: kExpansionTileMargin,
                                right: kExpansionTileMargin),
                            title: Text(
                                state.fetchWorkingAtTimeSheetModel.data[index]
                                    .name,
                                style: Theme.of(context).textTheme.xSmall),
                            onTap: () {
                              workingAt = state.fetchWorkingAtTimeSheetModel
                                  .data[index].name;
                              workingAtValue = state
                                  .fetchWorkingAtTimeSheetModel.data[index].id;
                              context.read<LeavesAndHolidaysBloc>().add(
                                  FetchTimeSheetWorkingAtNumberData(
                                      workingAt: workingAt,
                                      workingAtValue: workingAtValue));
                            });
                      },
                    )
                  ],
                ));
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
