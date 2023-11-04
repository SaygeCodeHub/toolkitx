import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/safetyNotice/safety_notice_bloc.dart';
import 'package:toolkit/blocs/safetyNotice/safety_notice_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../blocs/safetyNotice/safety_notice_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/enums/safety_notice_status_enum.dart';
import '../safety_notice_filter_screen.dart';

class SafetyNoticeStatusFilterExpansionTile extends StatelessWidget {
  const SafetyNoticeStatusFilterExpansionTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<SafetyNoticeBloc>().add(SelectSafetyNoticeStatus(
        statusId:
            SafetyNoticeFilterScreen.safetyNoticeFilterMap['status'] ?? '',
        status: ''));
    return BlocBuilder<SafetyNoticeBloc, SafetyNoticeStates>(
        buildWhen: (previousState, currentState) =>
            currentState is SafetyNoticeStatusSelected,
        builder: (context, state) {
          if (state is SafetyNoticeStatusSelected) {
            return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: AppColor.transparent),
                child: ExpansionTile(
                    maintainState: true,
                    key: GlobalKey(),
                    title: Text(
                        state.status.isEmpty
                            ? StringConstants.kSelect
                            : state.status,
                        style: Theme.of(context).textTheme.xSmall),
                    children: [
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: SafetyNoticeStatusEnum.values.length,
                          itemBuilder: (BuildContext context, int index) {
                            return RadioListTile(
                                contentPadding: const EdgeInsets.only(
                                    left: xxxTinierSpacing),
                                activeColor: AppColor.deepBlue,
                                title: Text(
                                    SafetyNoticeStatusEnum.values
                                        .elementAt(index)
                                        .status,
                                    style: Theme.of(context).textTheme.xSmall),
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                value: SafetyNoticeStatusEnum.values
                                    .elementAt(index)
                                    .value,
                                groupValue: state.statusId,
                                onChanged: (value) {
                                  SafetyNoticeFilterScreen
                                          .safetyNoticeFilterMap['status'] =
                                      SafetyNoticeStatusEnum.values
                                          .elementAt(index)
                                          .value;
                                  context.read<SafetyNoticeBloc>().add(
                                      SelectSafetyNoticeStatus(
                                          statusId: SafetyNoticeStatusEnum
                                              .values
                                              .elementAt(index)
                                              .value,
                                          status: SafetyNoticeStatusEnum.values
                                              .elementAt(index)
                                              .status));
                                });
                          })
                    ]));
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
