import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toolkit/blocs/LogBook/logbook_bloc.dart';
import 'package:toolkit/blocs/assets/assets_bloc.dart';
import 'package:toolkit/blocs/calendar/calendar_bloc.dart';
import 'package:toolkit/blocs/certificates/cerficatesList/certificate_list_bloc.dart';
import 'package:toolkit/blocs/certificates/feedbackCertificates/feedback_certificate_bloc.dart';
import 'package:toolkit/blocs/certificates/startCourseCertificates/start_course_certificate_bloc.dart';
import 'package:toolkit/blocs/certificates/uploadCertificates/upload_certificate_bloc.dart';
import 'package:toolkit/blocs/chat/chat_bloc.dart';
import 'package:toolkit/blocs/documents/documents_bloc.dart';
import 'package:toolkit/blocs/equipmentTraceability/equipment_traceability_bloc.dart';
import 'package:toolkit/blocs/expense/expense_bloc.dart';
import 'package:toolkit/blocs/imagePickerBloc/image_picker_bloc.dart';
import 'package:toolkit/blocs/leavesAndHolidays/leaves_and_holidays_bloc.dart';
import 'package:toolkit/blocs/location/location_bloc.dart';
import 'package:toolkit/blocs/searchTextField/search_text_field_bloc.dart';
import 'package:toolkit/blocs/signInQRCode/SignInAssignToMe/sign_in_assign_to_me_bloc.dart';
import 'package:toolkit/blocs/signInQRCode/signInLocationDetails/sign_in_location_details_bloc.dart';
import 'package:toolkit/blocs/tickets/tickets_bloc.dart';
import 'package:toolkit/blocs/uploadImage/upload_image_bloc.dart';
import 'package:toolkit/blocs/workorder/workorder_bloc.dart';
import 'package:toolkit/utils/notifications/notification_util.dart';
import 'blocs/checklist/systemUser/approve/sys_user_approve_checklist_bloc.dart';
import 'blocs/checklist/systemUser/changeRole/sys_user_checklist_change_role_bloc.dart';
import 'blocs/checklist/systemUser/checkList/sys_user_checklist_bloc.dart';
import 'blocs/checklist/systemUser/pdf/sys_user_checklist_pdf_bloc.dart';
import 'blocs/checklist/systemUser/reject/sys_user_reject_checklist_bloc.dart';
import 'blocs/checklist/systemUser/scheduleDates/sys_user_checklist_schedule_dates_bloc.dart';
import 'blocs/checklist/systemUser/scheduleDatesResponse/checklist_schedule_dates_response_bloc.dart';
import 'blocs/checklist/systemUser/submitHeader/sys_user_checklist_header_bloc.dart';
import 'blocs/checklist/systemUser/thirdPartyApprove/sys_user_checklist_third_party_approve_bloc.dart';
import 'blocs/checklist/workforce/comments/workforce_checklist_comments_bloc.dart';
import 'blocs/checklist/workforce/editAnswer/workforce_checklist_edit_answer_bloc.dart';
import 'blocs/checklist/workforce/getQuestionsList/workforce_checklist_get_questions_list_bloc.dart';
import 'blocs/checklist/workforce/popUpMenu/workforce_checklist_pop_up_menu_bloc.dart';
import 'blocs/checklist/workforce/rejectReason/workforce_checklist_reject_reason_bloc.dart';
import 'blocs/checklist/workforce/submitAnswer/workforce_checklist_submit_answer_bloc.dart';
import 'blocs/checklist/workforce/workforceList/workforce_list_bloc.dart';
import 'blocs/client/client_bloc.dart';
import 'blocs/dateFormat/date_format_bloc.dart';
import 'blocs/global/global_bloc.dart';
import 'blocs/home/home_bloc.dart';
import 'blocs/incident/editIncidentDetails/edit_incident_details_bloc.dart';
import 'blocs/incident/incidentDetails/incident_details_bloc.dart';
import 'blocs/incident/incidentInjuryDetails/incident_injury_details_bloc.dart';
import 'blocs/incident/incidentListAndFilter/incident_list_and_filter_bloc.dart';
import 'blocs/incident/incidentRemoveLinkedPermit/incident_remove_linked_permit_bloc.dart';
import 'blocs/incident/reportNewIncident/report_new_incident_bloc.dart';
import 'blocs/language/language_bloc.dart';
import 'blocs/login/login_bloc.dart';
import 'blocs/loto/loto_details/loto_details_bloc.dart';
import 'blocs/loto/loto_list/loto_list_bloc.dart';
import 'blocs/notification/notification_bloc.dart';
import 'blocs/onboarding/onboarding_bloc.dart';
import 'blocs/onboarding/onboarding_events.dart';
import 'blocs/onboarding/onboarding_states.dart';
import 'blocs/permit/permit_bloc.dart';
import 'blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import 'blocs/profile/profile_bloc.dart';
import 'blocs/qualityManagement/qm_bloc.dart';
import 'blocs/safetyNotice/safety_notice_bloc.dart';
import 'blocs/signInQRCode/signInList/sign_in_list_bloc.dart';
import 'blocs/signInQRCode/signInProcess/sign_in_process_bloc.dart';
import 'blocs/timeZone/time_zone_bloc.dart';
import 'blocs/todo/todo_bloc.dart';
import 'blocs/wifiConnectivity/wifi_connectivity_bloc.dart';
import 'blocs/wifiConnectivity/wifi_connectivity_events.dart';
import 'blocs/wifiConnectivity/wifi_connectivity_states.dart';
import 'blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import 'configs/app_route.dart';
import 'configs/app_theme.dart';
import 'di/app_module.dart';
import 'screens/onboarding/client_list_screen.dart';
import 'screens/onboarding/login_screen.dart';
import 'screens/onboarding/select_date_format_screen.dart';
import 'screens/onboarding/select_time_zone_screen.dart';
import 'screens/onboarding/welcome_screen.dart';
import 'screens/root/root_screen.dart';
import 'utils/database_utils.dart';
import 'utils/profile_util.dart';

void main() async {
  await _initApp();
  await _initDependencies();
  await _initFirebase();
  runApp(const MyApp());
}

_initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Hive.initFlutter();
  DatabaseUtil.box = await Hive.openBox('languages_box');
  ProfileUtil.packageInfo = await PackageInfo.fromPlatform();
}

_initFirebase() async {
  await Firebase.initializeApp();
  await NotificationUtil().initNotifications();
}

_initDependencies() async {
  configurableDependencies();
  await getIt.isReady<SharedPreferences>();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              lazy: false,
              create: (context) =>
                  WifiConnectivityBloc()..add(ObserveNetwork())),
          BlocProvider(lazy: false, create: (context) => LanguageBloc()),
          BlocProvider(lazy: false, create: (context) => DateFormatBloc()),
          BlocProvider(lazy: false, create: (context) => HomeBloc()),
          BlocProvider(lazy: false, create: (context) => PermitBloc()),
          BlocProvider(lazy: false, create: (context) => LoginBloc()),
          BlocProvider(lazy: false, create: (context) => TimeZoneBloc()),
          BlocProvider(lazy: false, create: (context) => LoginBloc()),
          BlocProvider(lazy: false, create: (context) => ClientBloc()),
          BlocProvider(lazy: false, create: (context) => ProfileBloc()),
          BlocProvider(lazy: false, create: (context) => WorkForceListBloc()),
          BlocProvider(lazy: false, create: (context) => LocationBloc()),
          BlocProvider(
              lazy: false,
              create: (context) => WorkForceCheckListCommentBloc()),
          BlocProvider(
              lazy: false, create: (context) => WorkForceQuestionsListBloc()),
          BlocProvider(
              lazy: false,
              create: (context) => WorkForceCheckListPopUpMenuItemsBloc()),
          BlocProvider(
              lazy: false,
              create: (context) => WorkForceCheckListEditAnswerBloc()),
          BlocProvider(
              lazy: false, create: (context) => SysUserCheckListBloc()),
          BlocProvider(
              lazy: false, create: (context) => CheckListScheduleDatesBloc()),
          BlocProvider(
              lazy: false,
              create: (context) => CheckListScheduleDatesResponseBloc()),
          BlocProvider(lazy: false, create: (context) => CheckListRoleBloc()),
          BlocProvider(
              lazy: false, create: (context) => CheckListApproveBloc()),
          BlocProvider(lazy: false, create: (context) => RejectCheckListBloc()),
          BlocProvider(
              lazy: false,
              create: (context) => CheckListThirdPartyApproveBloc()),
          BlocProvider(lazy: false, create: (context) => CheckListHeaderBloc()),
          BlocProvider(
              lazy: false, create: (context) => FetchCheckListPdfBloc()),
          BlocProvider(lazy: false, create: (context) => SubmitAnswerBloc()),
          BlocProvider(
              lazy: false,
              create: (context) => WorkForceCheckListSaveRejectBloc()),
          BlocProvider(
              lazy: false, create: (context) => PickAndUploadImageBloc()),
          BlocProvider(
              lazy: false, create: (context) => IncidentLisAndFilterBloc()),
          BlocProvider(
              lazy: false, create: (context) => PickAndUploadImageBloc()),
          BlocProvider(lazy: true, create: (context) => IncidentDetailsBloc()),
          BlocProvider(create: (context) => LogbookBloc()),
          BlocProvider(
              lazy: false, create: (context) => PickAndUploadImageBloc()),
          BlocProvider(lazy: false, create: (context) => IncidentDetailsBloc()),
          BlocProvider(
              lazy: false,
              create: (context) => IncidentRemoveLinkedPermitBloc()),
          BlocProvider(
              lazy: true, create: (context) => ReportNewIncidentBloc()),
          BlocProvider(lazy: false, create: (context) => InjuryDetailsBloc()),
          BlocProvider(lazy: false, create: (context) => ToDoBloc()),
          BlocProvider(
              lazy: true, create: (context) => LeavesAndHolidaysBloc()),
          BlocProvider(
              lazy: true, create: (context) => EditIncidentDetailsBloc()),
          BlocProvider(
              lazy: true, create: (context) => QualityManagementBloc()),
          BlocProvider(lazy: true, create: (context) => CalendarBloc()),
          BlocProvider(lazy: true, create: (context) => WorkOrderBloc()),
          BlocProvider(lazy: true, create: (context) => WorkOrderBloc()),
          BlocProvider(lazy: true, create: (context) => SignInProcessBloc()),
          BlocProvider(lazy: true, create: (context) => SafetyNoticeBloc()),
          BlocProvider(lazy: true, create: (context) => ExpenseBloc()),
          BlocProvider(
              lazy: true, create: (context) => SignInLocationDetailsBloc()),
          BlocProvider(
              lazy: true, create: (context) => WorkOrderTabDetailsBloc()),
          BlocProvider(
              lazy: false,
              create: (context) =>
                  OnBoardingBloc()..add(CheckClientSelected())),
          BlocProvider(lazy: false, create: (context) => SignInListBloc()),
          BlocProvider(
              lazy: false, create: (context) => SignInAssignToMeBloc()),
          BlocProvider(
              lazy: false, create: (context) => SignInLocationDetailsBloc()),
          BlocProvider(lazy: false, create: (context) => LotoListBloc()),
          BlocProvider(lazy: true, create: (context) => CertificateListBloc()),
          BlocProvider(
              lazy: true, create: (context) => StartCourseCertificateBloc()),
          BlocProvider(
              lazy: true, create: (context) => UploadCertificateBloc()),
          BlocProvider(
              lazy: true, create: (context) => FeedbackCertificateBloc()),
          BlocProvider(lazy: true, create: (context) => DocumentsBloc()),
          BlocProvider(lazy: true, create: (context) => ImagePickerBloc()),
          BlocProvider(lazy: true, create: (context) => LotoDetailsBloc()),
          BlocProvider(lazy: true, create: (context) => SearchTextFieldBloc()),
          BlocProvider(lazy: true, create: (context) => AssetsBloc()),
          BlocProvider(lazy: true, create: (context) => UploadImageBloc()),
          BlocProvider(lazy: true, create: (context) => UploadImageBloc()),
          BlocProvider(lazy: false, create: (context) => ChatBloc()),
          BlocProvider(
              lazy: false, create: (context) => EquipmentTraceabilityBloc()),
          BlocProvider(lazy: true, create: (context) => TicketsBloc()),
          BlocProvider(lazy: true, create: (context) => NotificationBloc()),
          BlocProvider(lazy: true, create: (context) => GlobalBloc()),
        ],
        child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                onGenerateRoute: AppRoutes.onGenerateRoutes,
                theme: appTheme,
                home: BlocBuilder<WifiConnectivityBloc, WifiConnectivityState>(
                    builder: (context, state) {
                  return BlocBuilder<OnBoardingBloc, OnBoardingStates>(
                      builder: (context, state) {
                    if (state is ClientSelected) {
                      return const RootScreen(isFromClientList: false);
                    } else if (state is LoggedIn) {
                      return const ClientListScreen(isFromProfile: false);
                    } else if (state is LanguageSelected) {
                      return const SelectTimeZoneScreen();
                    } else if (state is TimeZoneSelected) {
                      return const SelectDateFormatScreen();
                    } else if (state is DateFormatSelected) {
                      return LoginScreen();
                    } else {
                      return const WelcomeScreen();
                    }
                  });
                }))));
  }
}
