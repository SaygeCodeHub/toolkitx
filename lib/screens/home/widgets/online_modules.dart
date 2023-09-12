import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/calendar/calendar_screen.dart';
import 'package:toolkit/screens/loto/loto_list_screen.dart';
import 'package:toolkit/screens/certificates/certificates_list_screen.dart';
import 'package:toolkit/screens/workorder/workorder_list_screen.dart';

import '../../../blocs/client/client_bloc.dart';
import '../../../blocs/client/client_events.dart';
import '../../../blocs/client/client_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/error_section.dart';
import '../../checklist/systemUser/sys_user_checklist_list_screen.dart';
import '../../checklist/workforce/workforce_list_screen.dart';
import '../../incident/incident_list_screen.dart';
import '../../leavesAndHolidays/leaves_and_holidays_screen.dart';
import '../../logBook/logbook_list_screen.dart';
import '../../permit/permit_list_screen.dart';
import '../../qualityManagement/qm_list_screen.dart';
import '../../signInQRCode/signin_list_screen.dart';
import '../../todo/todo_assigned_to_me_and_by_me_list_screen.dart';

class OnLineModules extends StatelessWidget {
  static bool isFirstTime = true;

  const OnLineModules({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                          state.availableModules[index].key, context),
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
          } else if (state is FetchHomeScreenError) {
            return Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3.5),
                child: Center(
                    child: GenericReloadButton(
                        onPressed: () {
                          context.read<ClientBloc>().add(FetchHomeScreenData());
                        },
                        textValue: StringConstants.kReload)));
          } else {
            return const SizedBox();
          }
        });
  }

  navigateToModule(moduleKey, context) {
    switch (moduleKey) {
      case 'ptw':
        Navigator.pushNamed(context, PermitListScreen.routeName,
            arguments: true);
        break;
      case 'hse':
        Navigator.pushNamed(context, IncidentListScreen.routeName,
            arguments: true);
        break;
      case 'checklist':
        Navigator.pushNamed(context, SystemUserCheckListScreen.routeName,
            arguments: true);
        break;
      case 'wf_checklist':
        Navigator.pushNamed(context, WorkForceListScreen.routeName);
        break;
      case 'sl':
        Navigator.pushNamed(context, LogbookListScreen.routeName,
            arguments: true);
        break;
      case 'todo':
        Navigator.pushNamed(
            context, TodoAssignedByMeAndToMeListScreen.routeName);
        break;
      case 'timesheet':
        Navigator.pushNamed(context, LeavesAndHolidaysScreen.routeName);
        break;
      case 'wf_timesheet':
        Navigator.pushNamed(context, LeavesAndHolidaysScreen.routeName);
        break;
      case 'qareport':
        Navigator.pushNamed(context, QualityManagementListScreen.routeName,
            arguments: true);
        break;
      case 'tracking':
        Navigator.pushNamed(context, SignInListScreen.routeName);
        break;
      case 'calendar':
        Navigator.pushNamed(context, CalendarScreen.routeName);
        break;
      case 'workorder':
        Navigator.pushNamed(context, WorkOrderListScreen.routeName,
            arguments: true);
        break;
      case 'loto':
        Navigator.pushNamed(context, LotoListScreen.routeName, arguments: true);
        break;
      case 'certificates':
        Navigator.pushNamed(context, CertificatesListScreen.routeName,
            arguments: true);
        break;
    }
  }
}
