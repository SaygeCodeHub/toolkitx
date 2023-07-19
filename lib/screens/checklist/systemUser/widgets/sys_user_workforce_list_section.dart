import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../../../blocs/checklist/systemUser/changeRole/sys_user_checklist_change_role_bloc.dart';
import '../../../../blocs/checklist/systemUser/scheduleDatesResponse/checklist_schedule_dates_response_bloc.dart';
import '../../../../blocs/checklist/systemUser/scheduleDatesResponse/checklist_schedule_dates_response_events.dart';
import '../../../../blocs/checklist/systemUser/scheduleDatesResponse/checklist_schedule_dates_response_states.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../widgets/custom_card.dart';
import '../../../../widgets/error_section.dart';
import 'sys_user_fetch_pdf_section.dart';

class WorkForceListSection extends StatelessWidget {
  const WorkForceListSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocBuilder<CheckListScheduleDatesResponseBloc,
                CheckListScheduleDatesResponseStates>(
            buildWhen: (previousState, currentState) =>
                currentState is FetchingCheckListWorkforceList ||
                currentState is CheckListWorkforceListFetched ||
                currentState is CheckListWorkforceListError,
            builder: (context, state) {
              if (state is FetchingCheckListWorkforceList) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CheckListWorkforceListFetched) {
                return Expanded(
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount:
                            state.checkListWorkforceListModel.data!.length,
                        itemBuilder: (context, index) {
                          return CustomCard(
                              child: Padding(
                            padding: const EdgeInsets.only(top: tinierSpacing),
                            child: ListTile(
                                dense: true,
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                        state.checkListWorkforceListModel
                                            .data![index].name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .small
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: AppColor.black)),
                                    FetchPdfSection(
                                        responseId: context
                                            .read<
                                                CheckListScheduleDatesResponseBloc>()
                                            .responseId),
                                  ],
                                ),
                                subtitle: Padding(
                                  padding:
                                      const EdgeInsets.only(top: tinierSpacing),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${state.checkListWorkforceListModel.data![index].jobtitle} -- ${state.checkListWorkforceListModel.data![index].company}',
                                        ),
                                        const SizedBox(height: tinierSpacing),
                                        Text(
                                          '${StringConstants.kResponseDate} ${state.checkListWorkforceListModel.data![index].responsedate}',
                                        ),
                                        const SizedBox(height: tinierSpacing),
                                        Visibility(
                                            visible: state
                                                    .checkListWorkforceListModel
                                                    .data![index]
                                                    .approvalstatus ==
                                                1,
                                            child: Text(DatabaseUtil.getText(
                                                'Approved')))
                                      ]),
                                ),
                                trailing: Visibility(
                                    visible: state
                                            .checkListWorkforceListModel
                                            .data![index]
                                            .responseid
                                            .isNotEmpty &&
                                        state.checkListWorkforceListModel
                                                .data![index].isdeptapprove ==
                                            "0",
                                    child: Checkbox(
                                        value: state.selectedIResponseIdList
                                            .contains(state
                                                .checkListWorkforceListModel
                                                .data![index]
                                                .responseid),
                                        onChanged: (value) {
                                          context
                                              .read<
                                                  CheckListScheduleDatesResponseBloc>()
                                              .add(CheckListCheckBoxCheck(
                                                  responseId: state
                                                      .checkListWorkforceListModel
                                                      .data![index]
                                                      .responseid,
                                                  checkListWorkforceListModel: state
                                                      .checkListWorkforceListModel,
                                                  responseIdList: state
                                                      .selectedIResponseIdList));
                                        }))),
                          ));
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: tinierSpacing);
                        }));
              } else if (state is CheckListWorkforceListError) {
                return Center(
                  child: GenericReloadButton(
                    onPressed: () {
                      context.read<CheckListScheduleDatesResponseBloc>().add(
                          CheckCheckListScheduleDatesResponse(
                              getChecklistDetailsData: context
                                  .read<CheckListScheduleDatesResponseBloc>()
                                  .getChecklistDetailsData!,
                              scheduleId: context
                                  .read<CheckListScheduleDatesResponseBloc>()
                                  .scheduleId,
                              role: context.read<CheckListRoleBloc>().roleId));
                    },
                    textValue: StringConstants.kReload,
                  ),
                );
              } else {
                return const SizedBox();
              }
            }),
      ],
    ));
  }
}
