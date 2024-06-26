import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/chat/chat_bloc.dart';
import 'package:toolkit/blocs/chat/chat_event.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/assets/assets_list_screen.dart';
import 'package:toolkit/screens/calendar/calendar_screen.dart';
import 'package:toolkit/screens/certificates/certificates_list_screen.dart';
import 'package:toolkit/screens/documents/documents_list_screen.dart';
import 'package:toolkit/screens/tickets/ticket_list_screen.dart';
import 'package:toolkit/screens/trips/trips_list_screen.dart';
import 'package:toolkit/screens/workorder/workorder_list_screen.dart';

import '../../../blocs/client/client_bloc.dart';
import '../../../blocs/client/client_events.dart';
import '../../../blocs/client/client_states.dart';
import '../../../blocs/global/global_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_card.dart';
import '../../checklist/systemUser/sys_user_checklist_list_screen.dart';
import '../../checklist/workforce/workforce_list_screen.dart';
import '../../equipmentTraceability/equipment_trace_screen.dart';
import '../../expense/expense_list_screen.dart';
import '../../incident/incident_list_screen.dart';
import '../../leavesAndHolidays/leaves_and_holidays_screen.dart';
import '../../location/location_list_screen.dart';
import '../../logBook/logbook_list_screen.dart';
import '../../loto/loto_list_screen.dart';
import '../../permit/permit_list_screen.dart';
import '../../qualityManagement/qm_list_screen.dart';
import '../../safetyNotice/safety_notice_screen.dart';
import '../../signInQRCode/signin_list_screen.dart';
import '../../todo/todo_assigned_to_me_and_by_me_list_screen.dart';

class OnLineModules extends StatelessWidget {
  static bool isFirstTime = true;

  const OnLineModules({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context
        .read<ClientBloc>()
        .add(FetchHomeScreenData(isFirstTime: isFirstTime));
    final globalBloc = context.read<GlobalBloc>();
    final clientBloc = context.read<ClientBloc>();
    return BlocBuilder<ClientBloc, ClientStates>(
        buildWhen: (previousState, currentState) =>
            currentState is HomeScreenFetching && isFirstTime == true ||
            currentState is HomeScreenFetched ||
            currentState is FetchHomeScreenError,
        builder: (context, state) {
          if (state is HomeScreenFetching) {
            return Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3.5),
                child: const Center(child: CircularProgressIndicator()));
          }
          if (state is HomeScreenFetched) {
            context
                .read<ChatBloc>()
                .add(FetchEmployees(pageNo: 1, searchedName: ''));
            isFirstTime = false;
            return GridView.builder(
                primary: false,
                itemCount: state.availableModules.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1 / 1.08,
                    crossAxisCount: 3,
                    crossAxisSpacing: xxTinierSpacing),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                      borderRadius: BorderRadius.circular(kCardRadius),
                      onTap: () => navigateToModule(
                          state.availableModules[index].key,
                          state.availableModules[index].moduleName,
                          context,
                          globalBloc,
                          clientBloc),
                      child: CustomCard(
                          color: AppColor.transparent,
                          elevation: kZeroElevation,
                          margin: EdgeInsets.zero,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      CustomCard(
                                          margin: const EdgeInsets.all(
                                              kModuleCardMargin),
                                          color: AppColor.lightestBlue,
                                          shadowColor: AppColor.ghostWhite,
                                          child: Padding(
                                              padding: const EdgeInsets.all(
                                                  kModuleImagePadding),
                                              child: Image.asset(
                                                  state.availableModules[index]
                                                      .moduleImage,
                                                  height: kModuleIconSize,
                                                  width: kModuleIconSize))),
                                      if ('${state.homeScreenModel.data!.badges!.indexWhere((element) => element.type == state.availableModules[index].key)}' !=
                                              '-1' ||
                                          '${state.homeScreenModel.data!.badges!.indexWhere((element) => element.type == state.availableModules[index].notificationKey)}' !=
                                              '-1')
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                left: kModulesBadgePadding),
                                            child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Container(
                                                      height: kModulesBadgeSize,
                                                      width: kModulesBadgeSize,
                                                      decoration:
                                                          const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: AppColor
                                                                  .errorRed)),
                                                  Text(
                                                      ('${state.homeScreenModel.data!.badges!.indexWhere((element) => element.type == state.availableModules[index].notificationKey)}' !=
                                                              '-1')
                                                          ? '${state.homeScreenModel.data!.badges![state.homeScreenModel.data!.badges!.indexWhere((element) => element.type == state.availableModules[index].notificationKey)].count}'
                                                          : '${state.homeScreenModel.data!.badges![state.homeScreenModel.data!.badges!.indexWhere((element) => element.type == state.availableModules[index].key)].count}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .xxxSmall
                                                          .copyWith(
                                                              fontSize: 8))
                                                ]))
                                    ]),
                                const SizedBox(height: tiniestSpacing),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: xxTiniestSpacing,
                                        right: xxTiniestSpacing),
                                    child: Text(
                                        DatabaseUtil.getText(state
                                            .availableModules[index]
                                            .moduleName),
                                        textAlign: TextAlign.center))
                              ])));
                });
          } else {
            return Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3.5),
                child: const Center(child: CircularProgressIndicator()));
          }
        });
  }

  navigateToModule(moduleKey, moduleName, context, globalBloc, clientBloc) {
    switch (moduleKey) {
      case 'ptw':
        globalBloc.add(UpdateCount(type: 'permit'));
        Navigator.pushNamed(context, PermitListScreen.routeName,
                arguments: true)
            .then((_) =>
                clientBloc.add(FetchHomeScreenData(isFirstTime: isFirstTime)));
        break;
      case 'hse':
        globalBloc.add(UpdateCount(type: 'hse'));
        Navigator.pushNamed(context, IncidentListScreen.routeName,
                arguments: true)
            .then((_) =>
                clientBloc.add(FetchHomeScreenData(isFirstTime: isFirstTime)));
        break;
      case 'checklist':
        globalBloc.add(UpdateCount(type: 'checklist'));
        Navigator.pushNamed(context, SystemUserCheckListScreen.routeName,
                arguments: true)
            .then((_) =>
                clientBloc.add(FetchHomeScreenData(isFirstTime: isFirstTime)));
        break;
      case 'wf_checklist':
        globalBloc.add(UpdateCount(type: 'checklist'));
        Navigator.pushNamed(context, WorkForceListScreen.routeName).then((_) =>
            clientBloc.add(FetchHomeScreenData(isFirstTime: isFirstTime)));
        break;
      case 'sl':
        globalBloc.add(UpdateCount(type: 'sl'));
        Navigator.pushNamed(context, LogbookListScreen.routeName,
                arguments: true)
            .then((_) =>
                clientBloc.add(FetchHomeScreenData(isFirstTime: isFirstTime)));
        break;
      case 'todo':
        globalBloc.add(UpdateCount(type: 'todo'));
        Navigator.pushNamed(
                context, TodoAssignedByMeAndToMeListScreen.routeName)
            .then((_) =>
                clientBloc.add(FetchHomeScreenData(isFirstTime: isFirstTime)));
        break;
      case 'timesheet':
        if (moduleName == 'Expense') {
          globalBloc.add(UpdateCount(type: 'expensereport'));
          Navigator.pushNamed(context, ExpenseListScreen.routeName,
                  arguments: true)
              .then((_) => clientBloc
                  .add(FetchHomeScreenData(isFirstTime: isFirstTime)));
        } else {
          globalBloc.add(UpdateCount(type: 'wf_timesheet'));
          Navigator.pushNamed(context, LeavesAndHolidaysScreen.routeName).then(
              (_) => clientBloc
                  .add(FetchHomeScreenData(isFirstTime: isFirstTime)));
        }
        break;
      case 'wf_timesheet':
        if (moduleName == 'Expense') {
          globalBloc.add(UpdateCount(type: 'expensereport'));
          Navigator.pushNamed(context, ExpenseListScreen.routeName).then((_) =>
              clientBloc.add(FetchHomeScreenData(isFirstTime: isFirstTime)));
        } else {
          globalBloc.add(UpdateCount(type: 'wf_timesheet'));
          Navigator.pushNamed(context, LeavesAndHolidaysScreen.routeName).then(
              (_) => clientBloc
                  .add(FetchHomeScreenData(isFirstTime: isFirstTime)));
        }
        break;
      case 'qareport':
        globalBloc.add(UpdateCount(type: 'qareport'));
        Navigator.pushNamed(context, QualityManagementListScreen.routeName,
                arguments: true)
            .then((_) =>
                clientBloc.add(FetchHomeScreenData(isFirstTime: isFirstTime)));
        break;
      case 'tracking':
        Navigator.pushNamed(context, SignInListScreen.routeName);
        break;
      case 'calendar':
      case 'wf_calendar':
        Navigator.pushNamed(context, CalendarScreen.routeName);
        break;

      case 'workorder':
        globalBloc.add(UpdateCount(type: 'workorder'));
        Navigator.pushNamed(context, WorkOrderListScreen.routeName,
                arguments: true)
            .then((_) =>
                clientBloc.add(FetchHomeScreenData(isFirstTime: isFirstTime)));
        break;
      case 'certificates':
        globalBloc.add(UpdateCount(type: 'certificatecourse'));
        Navigator.pushNamed(context, CertificatesListScreen.routeName,
                arguments: true)
            .then((_) =>
                clientBloc.add(FetchHomeScreenData(isFirstTime: isFirstTime)));
        break;
      case 'loto':
        globalBloc.add(UpdateCount(type: 'loto'));
        Navigator.pushNamed(context, LotoListScreen.routeName, arguments: true)
            .then((_) =>
                clientBloc.add(FetchHomeScreenData(isFirstTime: isFirstTime)));
        break;
      case 'dms':
        globalBloc.add(UpdateCount(type: 'dms'));
        Navigator.pushNamed(context, DocumentsListScreen.routeName,
                arguments: true)
            .then((_) =>
                clientBloc.add(FetchHomeScreenData(isFirstTime: isFirstTime)));
        break;
      case 'safetyNotice':
        globalBloc.add(UpdateCount(type: 'safetynotice'));
        Navigator.pushNamed(context, SafetyNoticeScreen.routeName,
                arguments: true)
            .then((_) =>
                clientBloc.add(FetchHomeScreenData(isFirstTime: isFirstTime)));
        break;
      case 'eam':
        if (moduleName == 'Location') {
          Navigator.pushNamed(context, LocationListScreen.routeName);
        } else {
          Navigator.pushNamed(context, AssetsListScreen.routeName);
        }
        break;
      case 'expensereport':
        globalBloc.add(UpdateCount(type: 'expensereport'));
        Navigator.pushNamed(context, ExpenseListScreen.routeName).then((_) =>
            clientBloc.add(FetchHomeScreenData(isFirstTime: isFirstTime)));
        break;
      case 'trace':
        globalBloc.add(UpdateCount(type: 'trace'));
        Navigator.pushNamed(context, EquipmentTraceScreen.routeName).then((_) =>
            clientBloc.add(FetchHomeScreenData(isFirstTime: isFirstTime)));
        break;
      case 'meetingRoom':
        globalBloc.add(UpdateCount(type: 'meetingroom'));

        break;
      case 'tickets':
        globalBloc.add(UpdateCount(type: 'tickets'));
        Navigator.pushNamed(context, TicketListScreen.routeName,
                arguments: true)
            .then((_) =>
                clientBloc.add(FetchHomeScreenData(isFirstTime: isFirstTime)));
        break;
      case 'hf':
        globalBloc.add(UpdateCount(type: 'manifest'));
        Navigator.pushNamed(context, TripsListScreen.routeName, arguments: true)
            .then((_) =>
                clientBloc.add(FetchHomeScreenData(isFirstTime: isFirstTime)));
        break;
      case 'wf_trips':
        globalBloc.add(UpdateCount(type: 'manifest'));
        Navigator.pushNamed(context, TripsListScreen.routeName, arguments: true)
            .then((_) =>
                clientBloc.add(FetchHomeScreenData(isFirstTime: isFirstTime)));
        break;
    }
  }
}
