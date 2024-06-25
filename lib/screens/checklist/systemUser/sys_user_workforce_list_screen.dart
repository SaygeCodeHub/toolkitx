import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/scheduleDatesResponse/checklist_schedule_dates_response_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/scheduleDatesResponse/checklist_schedule_dates_response_states.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/checklist/widgets/checklist_app_bar.dart';
import 'package:toolkit/screens/checklist/systemUser/sys_user_pop_up_menu_screen.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import 'widgets/sys_user_workforce_list_section.dart';

class SysUserWorkForceListScreen extends StatelessWidget {
  static const routeName = 'SysUserWorkForceListScreen';

  const SysUserWorkForceListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ChecklistAppBar(
            title: BlocBuilder<CheckListScheduleDatesResponseBloc,
                    CheckListScheduleDatesResponseStates>(
                buildWhen: (previousState, currentState) =>
                    currentState is FetchingCheckListWorkforceList ||
                    currentState is CheckListWorkforceListFetched ||
                    currentState is CheckListWorkforceListError,
                builder: (context, state) {
                  if (state is CheckListWorkforceListFetched) {
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        state
                            .checkListWorkforceListModel.data![0].checklistname,
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
            actions: [
              BlocBuilder<CheckListScheduleDatesResponseBloc,
                      CheckListScheduleDatesResponseStates>(
                  buildWhen: (previousState, currentState) =>
                      currentState is FetchingCheckListWorkforceList ||
                      currentState is CheckListWorkforceListFetched ||
                      currentState is CheckListWorkforceListError,
                  builder: (context, state) {
                    if (state is CheckListWorkforceListFetched) {
                      return PopUpMenu(
                          responseIdList: state.selectedIResponseIdList,
                          scheduleId: context
                              .read<CheckListScheduleDatesResponseBloc>()
                              .responseId,
                          popUpMenuBuilder: state.popUpMenuBuilder);
                    } else {
                      return const SizedBox();
                    }
                  })
            ]),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: topBottomPadding),
            child: Column(children: [
              BlocBuilder<CheckListScheduleDatesResponseBloc,
                      CheckListScheduleDatesResponseStates>(
                  buildWhen: (previousState, currentState) =>
                      currentState is FetchingCheckListWorkforceList ||
                      currentState is CheckListWorkforceListFetched ||
                      currentState is CheckListWorkforceListError,
                  builder: (context, state) {
                    if (state is CheckListWorkforceListFetched) {
                      return Align(
                          alignment: Alignment.topLeft,
                          child: Row(children: [
                            Image.asset("assets/icons/calendar.png",
                                height: kProfileImageHeight,
                                width: kProfileImageWidth),
                            const SizedBox(width: xxTinierSpacing),
                            Text(
                                '${state.checkListWorkforceListModel.data![0].startdate} - ${state.checkListWorkforceListModel.data![0].enddate}',
                                style: Theme.of(context)
                                    .textTheme
                                    .small
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.black))
                          ]));
                    } else {
                      return const SizedBox();
                    }
                  }),
              const SizedBox(height: xxTinySpacing),
              const WorkForceListSection()
            ])));
  }
}
