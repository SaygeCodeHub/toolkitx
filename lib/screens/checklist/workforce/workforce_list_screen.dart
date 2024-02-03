import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../blocs/checklist/workforce/workforceList/workforce_list_bloc.dart';
import '../../../blocs/checklist/workforce/workforceList/workforce_list_events.dart';
import '../../../blocs/checklist/workforce/workforceList/workforce_list_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/error_section.dart';
import '../../../widgets/generic_app_bar.dart';
import '../widgets/custom_tag_container.dart';
import 'workforce_questions_list_screen.dart';

class WorkForceListScreen extends StatelessWidget {
  static const routeName = 'WorkForceListScreen';

  const WorkForceListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<WorkForceListBloc>().add(FetchWorkForceList());
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kChecklist),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing),
            child: BlocBuilder<WorkForceListBloc, WorkForceListStates>(
                builder: (context, state) {
              if (state is FetchingList) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ListFetched) {
                return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.workforceGetCheckListModel.data!.length,
                    itemBuilder: (context, index) {
                      return CustomCard(
                          child: Padding(
                        padding: const EdgeInsets.only(top: tinierSpacing),
                        child: ListTile(
                            title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                      state.workforceGetCheckListModel
                                          .data![index].name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .small
                                          .copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.black)),
                                  const SizedBox(width: tiniestSpacing),
                                  Visibility(
                                      visible: state.workforceGetCheckListModel
                                              .data![index].isdraft ==
                                          1,
                                      child: Text('[${StringConstants.kDraft}]',
                                          style: Theme.of(context)
                                              .textTheme
                                              .xSmall
                                              .copyWith(
                                                  color: AppColor.errorRed)))
                                ]),
                            subtitle: Padding(
                              padding:
                                  const EdgeInsets.only(top: tinierSpacing),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${DatabaseUtil.getText('Assignedate')}: ${state.workforceGetCheckListModel.data![index].submitdate}  -- ${DatabaseUtil.getText('Dueon')}: ${state.workforceGetCheckListModel.data![index].overduedate}',
                                    ),
                                    const SizedBox(height: xxTinierSpacing),
                                    Text(
                                      '${state.workforceGetCheckListModel.data![index].categoryname} -- ${state.workforceGetCheckListModel.data![index].subcategoryname}',
                                    ),
                                    const SizedBox(height: tinierSpacing),
                                    Visibility(
                                      visible: state.workforceGetCheckListModel
                                              .data![index].isrejected !=
                                          '0',
                                      child: const CustomTagContainer(
                                          color: AppColor.errorRed,
                                          textValue:
                                              StringConstants.kNotAccepted),
                                    ),
                                    Visibility(
                                      visible: state.workforceGetCheckListModel
                                              .data![index].isoverdue !=
                                          '0',
                                      child: const CustomTagContainer(
                                          color: AppColor.yellow,
                                          textValue: StringConstants.kOverdue),
                                    ),
                                    Visibility(
                                      visible: state.workforceGetCheckListModel
                                              .data![index].isdraft ==
                                          0,
                                      child: const CustomTagContainer(
                                          color: AppColor.lightGreen,
                                          textValue:
                                              StringConstants.kSubmitted),
                                    ),
                                    const SizedBox(height: tinierSpacing)
                                  ]),
                            ),
                            onTap: () {
                              context.read<WorkForceListBloc>().checkListMap = {
                                "scheduleId": state.workforceGetCheckListModel
                                    .data![index].scheduleid
                                    .toString(),
                                "checklistId": state
                                    .workforceGetCheckListModel.data![index].id,
                                "isDraft": state.workforceGetCheckListModel
                                    .data![index].isdraft,
                                "isRejected": state.workforceGetCheckListModel
                                    .data![index].isrejected
                              };
                              Navigator.pushNamed(context,
                                      WorkForceQuestionsScreen.routeName,
                                      arguments: context
                                          .read<WorkForceListBloc>()
                                          .checkListMap)
                                  .then((value) => context
                                      .read<WorkForceListBloc>()
                                      .add(FetchWorkForceList()));
                            }),
                      ));
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: tinierSpacing);
                    });
              } else if (state is ListNotFetched) {
                return GenericReloadButton(
                    onPressed: () {
                      context
                          .read<WorkForceListBloc>()
                          .add(FetchWorkForceList());
                    },
                    textValue: StringConstants.kReload);
              } else {
                return const SizedBox();
              }
            })));
  }
}
