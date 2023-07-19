import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/changeRole/sys_user_checklist_change_role_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../../blocs/checklist/systemUser/scheduleDates/sys_user_checklist_schedule_dates_bloc.dart';
import '../../../../blocs/checklist/systemUser/scheduleDates/sys_user_checklist_schedule_dates_states.dart';
import '../../../../blocs/checklist/systemUser/scheduleDatesResponse/checklist_schedule_dates_response_bloc.dart';
import '../../../../blocs/checklist/systemUser/scheduleDatesResponse/checklist_schedule_dates_response_events.dart';
import '../../../../blocs/checklist/systemUser/scheduleDatesResponse/checklist_schedule_dates_response_states.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_dimensions.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../widgets/custom_card.dart';
import '../../../../widgets/custom_snackbar.dart';
import '../sys_user_workforce_list_screen.dart';

class ScheduleDatesSection extends StatelessWidget {
  final String checklistId;

  const ScheduleDatesSection({Key? key, required this.checklistId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckListScheduleDatesBloc,
        CheckListScheduleDatesStates>(builder: (context, state) {
      if (state is FetchingCheckListScheduleDates) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is CheckListDatesScheduled) {
        return BlocListener<CheckListScheduleDatesResponseBloc,
                CheckListScheduleDatesResponseStates>(
            listener: (context, state) {
              if (state is CheckListNoResponseFound) {
                showCustomSnackBar(
                    context, StringConstants.kNoResponseFound, '');
              } else if (state is FetchingCheckListWorkforceList) {
                Navigator.pushNamed(
                    context, SysUserWorkForceListScreen.routeName);
              }
            },
            child: Padding(
                padding: const EdgeInsets.only(
                    left: leftRightMargin,
                    right: leftRightMargin,
                    top: topBottomPadding,
                    bottom: topBottomPadding),
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                        state.checklistScheduledByDatesModel.data!.length,
                    itemBuilder: (context, index) {
                      return CustomCard(
                          child: Padding(
                        padding: const EdgeInsets.only(top: tinierSpacing),
                        child: ListTile(
                            title: Row(children: [
                              Image.asset("assets/icons/calendar.png",
                                  height: kProfileImageHeight,
                                  width: kProfileImageWidth),
                              const SizedBox(width: tinierSpacing),
                              Text(
                                  state.checklistScheduledByDatesModel
                                      .data![index].dates,
                                  style: Theme.of(context)
                                      .textTheme
                                      .small
                                      .copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.black))
                            ]),
                            subtitle: Padding(
                              padding:
                                  const EdgeInsets.only(top: tinierSpacing),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        '${state.checklistScheduledByDatesModel.data![index].responsecount} response out of ${state.checklistScheduledByDatesModel.data![index].totalworkforcecount}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .xxSmall
                                            .copyWith(color: AppColor.grey)),
                                    const SizedBox(height: tiniestSpacing),
                                    Visibility(
                                        visible: state
                                                .checklistScheduledByDatesModel
                                                .data![index]
                                                .approvalpendingcount !=
                                            0,
                                        child: const Icon(
                                            Icons.question_mark_outlined,
                                            color: AppColor.errorRed,
                                            size: kIconSize)),
                                    const SizedBox(height: tiniestSpacing),
                                  ]),
                            ),
                            onTap: () {
                              context
                                  .read<CheckListScheduleDatesResponseBloc>()
                                  .add(CheckCheckListScheduleDatesResponse(
                                      getChecklistDetailsData: state
                                          .checklistScheduledByDatesModel
                                          .data![index],
                                      scheduleId: state
                                          .checklistScheduledByDatesModel
                                          .data![index]
                                          .id,
                                      role: context
                                          .read<CheckListRoleBloc>()
                                          .roleId));
                            }),
                      ));
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: tinierSpacing);
                    })));
      } else if (state is CheckListDatesNotScheduled) {
        return Center(
            child: Text(state.noDatesScheduled,
                style: Theme.of(context).textTheme.medium));
      } else {
        return const SizedBox();
      }
    });
  }
}
