import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/leavesAndHolidays/leaves_and_holidays_bloc.dart';
import 'package:toolkit/blocs/leavesAndHolidays/leaves_and_holidays_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../blocs/leavesAndHolidays/leaves_and_holidays_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/leavesAndHolidays/fetch_leaves_and_holidays_master_model.dart';

class SelectLeaveTypeExpansionTile extends StatelessWidget {
  final List<LeavesMasterDatum> data;
  final Map applyForLeaveMap;

  const SelectLeaveTypeExpansionTile(
      {Key? key, required this.data, required this.applyForLeaveMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String typeName = '';
    return BlocBuilder<LeavesAndHolidaysBloc, LeavesAndHolidaysStates>(
        buildWhen: (previousState, currentState) =>
            currentState is LeaveTypeSelected,
        builder: (context, state) {
          if (state is LeaveTypeSelected) {
            applyForLeaveMap['type'] = state.leaveTypeId;
            return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                    maintainState: true,
                    key: GlobalKey(),
                    title: Text(
                        typeName == '' ? StringConstants.kSelect : typeName,
                        style: Theme.of(context).textTheme.xSmall),
                    children: [
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return RadioListTile(
                                contentPadding: const EdgeInsets.only(
                                    left: xxxTinierSpacing),
                                activeColor: AppColor.deepBlue,
                                title: Text(data[index].name,
                                    style: Theme.of(context).textTheme.xSmall),
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                value: data[index].id.toString(),
                                groupValue: state.leaveTypeId,
                                onChanged: (value) {
                                  value = data[index].id.toString();
                                  typeName = data[index].name;
                                  context
                                      .read<LeavesAndHolidaysBloc>()
                                      .add(SelectLeaveType(leaveTypeId: value));
                                });
                          })
                    ]));
          } else {
            return const SizedBox();
          }
        });
  }
}
