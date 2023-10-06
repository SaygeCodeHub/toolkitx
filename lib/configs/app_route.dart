import 'package:flutter/material.dart';
import 'package:toolkit/screens/certificates/upload_certificate_screen.dart';
import 'package:toolkit/screens/checklist/workforce/workforce_list_screen.dart';
import 'package:toolkit/screens/incident/incident_details_screen.dart';
import 'package:toolkit/screens/signInQRCode/signin_list_screen.dart';
import '../data/models/incident/fetch_incidents_list_model.dart';
import '../data/models/permit/permit_details_model.dart';
import '../data/models/qualityManagement/fetch_qm_details_model.dart';
import '../screens/calendar/calendar_screen.dart';
import '../screens/certificates/get_quiz_questions_screen.dart';
import '../screens/certificates/get_topics_certificate_screen.dart';
import '../screens/certificates/certificates_list_screen.dart';
import '../screens/certificates/get_course_certificate_screen.dart';
import '../screens/certificates/feedback_certificate_screen.dart';
import '../screens/certificates/get_workforce_quiz_screen.dart';
import '../screens/checklist/systemUser/sys_user_workforce_list_screen.dart';
import '../screens/checklist/workforce/add_image_and_comments_screen.dart';
import '../screens/checklist/workforce/workforce_edit_answer_screen.dart';
import '../screens/checklist/workforce/workforce_questions_list_screen.dart';
import 'package:toolkit/screens/checklist/systemUser/sys_user_edit_header_screen.dart';
import 'package:toolkit/screens/checklist/systemUser/sys_user_checklist_list_screen.dart';
import '../screens/checklist/systemUser/sys_user_change_role_screen.dart';
import '../screens/checklist/systemUser/sys_user_schedule_dates_screen.dart';
import '../screens/checklist/systemUser/sys_user_filters_screen.dart';
import '../screens/checklist/workforce/workforce_reject_reason_screen.dart';
import '../screens/documents/change_role_documents.dart';
import '../screens/documents/document_filter_screen.dart';
import '../screens/documents/documents_list_screen.dart';
import '../screens/documents/widgets/document_location_filter_list.dart';
import '../screens/incident/add_injured_person_screen.dart';
import '../screens/incident/category_screen.dart';
import '../screens/incident/change_role_screen.dart';
import '../screens/incident/incident_filter_screen.dart';
import '../screens/incident/incident_health_and_safety_screen.dart';
import '../screens/incident/incident_injuries_screen.dart';
import '../screens/incident/incident_list_screen.dart';
import '../screens/incident/incident_location_screen.dart';
import '../screens/incident/report_new_incident_screen.dart';
import '../screens/leavesAndHolidays/apply_for_leave_screen.dart';
import '../screens/leavesAndHolidays/leaves_and_holidays_screen.dart';
import '../screens/leavesAndHolidays/leaves_details_screen.dart';
import '../screens/leavesAndHolidays/leaves_summary_screen.dart';
import '../screens/logBook/logbook_details_screen.dart';
import '../screens/logBook/add_logbook_screen.dart';
import '../screens/logBook/logbook_filter_screen.dart';
import '../screens/logBook/logbook_list_screen.dart';
import '../screens/loto/loto_assign_team_screen.dart';
import '../screens/loto/loto_assign_workfoce_screen.dart';
import '../screens/loto/loto_filter_screen.dart';
import '../screens/loto/loto_list_screen.dart';
import '../screens/loto/loto_details_screen.dart';
import '../screens/loto/widgets/loto_location_list.dart';
import '../screens/loto/widgets/start_loto_screen.dart';
import '../screens/onboarding/client_list_screen.dart';
import '../screens/onboarding/select_language_screen.dart';
import '../screens/onboarding/login_screen.dart';
import '../screens/onboarding/password_screen.dart';
import '../screens/onboarding/select_date_format_screen.dart';
import '../screens/onboarding/select_time_zone_screen.dart';
import '../screens/onboarding/welcome_screen.dart';
import '../screens/permit/close_permit_screen.dart';
import '../screens/permit/open_permit_screen.dart';
import '../screens/permit/permit_filter_screen.dart';
import '../screens/profile/change_password_screen.dart';
import '../screens/profile/select_change_password_screen.dart';
import '../screens/profile/profile_edit_screen.dart';
import '../screens/permit/permit_details_screen.dart';
import '../screens/permit/permit_list_screen.dart';
import '../screens/permit/get_permit_roles_screen.dart';
import '../screens/qualityManagement/qm_add_comments_screen.dart';
import '../screens/qualityManagement/qm_custom_fields_screen.dart';

import '../screens/qualityManagement/qm_details_screen.dart';
import '../screens/qualityManagement/qm_list_screen.dart';
import '../screens/qualityManagement/qm_location_screen.dart';
import '../screens/qualityManagement/report_new_qm.dart';
import '../screens/qualityManagement/qm_roles_screen.dart';
import '../screens/qualityManagement/qm_filters_screen.dart';
import '../screens/root/root_screen.dart';
import '../screens/signInQRCode/process_signin.dart';
import '../screens/todo/add_todo_screen.dart';
import '../screens/todo/todo_assigned_to_me_and_by_me_list_screen.dart';
import '../screens/todo/todo_details_and_document_details_screen.dart';
import '../screens/todo/todo_history_list_screen.dart';
import '../screens/todo/todo_settings_screen.dart';
import '../screens/workorder/assign_workforce_screen.dart';
import '../screens/workorder/widgets/workorder_add_parts_screen.dart';
import '../screens/workorder/start_workorder_screen.dart';
import '../screens/workorder/workorder_assign_document_screen.dart';
import '../screens/workorder/workorder_add_mis_cost_screen.dart';
import '../screens/workorder/workorder_add_and_edit_down_time_screen.dart';
import '../screens/workorder/workorder_document_filter_screen.dart';
import '../screens/workorder/workorder_edit_workforce_screen.dart';
import '../screens/workorder/workorder_form_screen_four.dart';
import '../screens/workorder/workorder_form_one_screen.dart';
import '../screens/workorder/workorder_form_screen_three.dart';
import '../screens/workorder/workorder_filter_screen.dart';
import '../screens/workorder/workorder_form_screen_two.dart';
import '../screens/workorder/workorder_details_tab_screen.dart';
import '../screens/workorder/workorder_list_screen.dart';
import '../widgets/in_app_web_view.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case WelcomeScreen.routeName:
        return _createRoute(const WelcomeScreen());
      case SelectLanguageScreen.routeName:
        return _createRoute(
            SelectLanguageScreen(isFromProfile: settings.arguments as bool));
      case SelectTimeZoneScreen.routeName:
        return _createRoute(
            SelectTimeZoneScreen(isFromProfile: settings.arguments as bool));
      case SelectDateFormatScreen.routeName:
        return _createRoute(
            SelectDateFormatScreen(isFromProfile: settings.arguments as bool));
      case LoginScreen.routeName:
        return _createRoute(LoginScreen());
      case PasswordScreen.routeName:
        return _createRoute(PasswordScreen());
      case RootScreen.routeName:
        return _createRoute(
            RootScreen(isFromClientList: settings.arguments as bool));
      case ProfileEditScreen.routeName:
        return _createRoute(const ProfileEditScreen());
      case SystemUserScheduleDatesScreen.routeName:
        return _createRoute(SystemUserScheduleDatesScreen(
            checkListId: settings.arguments.toString()));
      case SystemUserCheckListScreen.routeName:
        return _createRoute(
            SystemUserCheckListScreen(isFromHome: settings.arguments as bool));
      case WorkForceListScreen.routeName:
        return _createRoute(const WorkForceListScreen());
      case ChangeRoleScreen.routeName:
        return _createRoute(const ChangeRoleScreen());
      case FiltersScreen.routeName:
        return _createRoute(const FiltersScreen());
      case EditHeaderScreen.routeName:
        return _createRoute(EditHeaderScreen());
      case IncidentListScreen.routeName:
        return _createRoute(
            IncidentListScreen(isFromHome: settings.arguments as bool));
      case IncidentFilterScreen.routeName:
        return _createRoute(IncidentFilterScreen());
      case IncidentChangeRoleScreen.routeName:
        return _createRoute(const IncidentChangeRoleScreen());
      case CategoryScreen.routeName:
        return _createRoute(const CategoryScreen());
      case PermitListScreen.routeName:
        return _createRoute(
            PermitListScreen(isFromHome: settings.arguments as bool));
      case PermitDetailsScreen.routeName:
        return _createRoute(
            PermitDetailsScreen(permitId: settings.arguments as String));
      case GetPermitRolesScreen.routeName:
        return _createRoute(const GetPermitRolesScreen());
      case PermitFilterScreen.routeName:
        return _createRoute(PermitFilterScreen());
      case ClientListScreen.routeName:
        return _createRoute(
            ClientListScreen(isFromProfile: settings.arguments as bool));
      case SelectChangePasswordTypeScreen.routeName:
        return _createRoute(const SelectChangePasswordTypeScreen());
      case ChangePasswordScreen.routeName:
        return _createRoute(ChangePasswordScreen());
      case AddImageAndCommentScreen.routeName:
        return _createRoute(AddImageAndCommentScreen(
            questionResponseId: settings.arguments.toString()));
      case SysUserWorkForceListScreen.routeName:
        return _createRoute(const SysUserWorkForceListScreen());
      case WorkForceQuestionsScreen.routeName:
        return _createRoute(WorkForceQuestionsScreen(
            checklistDataMap: settings.arguments as Map));
      case RejectReasonsScreen.routeName:
        return _createRoute(
            RejectReasonsScreen(checklistDataMap: settings.arguments as Map));
      case EditAnswerListScreen.routeName:
        return _createRoute(
            EditAnswerListScreen(checklistDataMap: settings.arguments as Map));
      case InAppWebViewScreen.routeName:
        return _createRoute(
            InAppWebViewScreen(url: settings.arguments as String));
      case ClosePermitScreen.routeName:
        return _createRoute(ClosePermitScreen(
            permitDetailsModel: settings.arguments as PermitDetailsModel));
      case OpenPermitScreen.routeName:
        return _createRoute(OpenPermitScreen(
            permitDetailsModel: settings.arguments as PermitDetailsModel));
      case IncidentDetailsScreen.routeName:
        return _createRoute(IncidentDetailsScreen(
            incidentListDatum: settings.arguments as IncidentListDatum));
      case ReportNewIncidentScreen.routeName:
        return _createRoute(ReportNewIncidentScreen(
            addAndEditIncidentMap: settings.arguments as Map));
      case IncidentLocationScreen.routeName:
        return _createRoute(IncidentLocationScreen(
            addAndEditIncidentMap: settings.arguments as Map));
      case IncidentHealthAndSafetyScreen.routeName:
        return _createRoute(IncidentHealthAndSafetyScreen(
            addAndEditIncidentMap: settings.arguments as Map));
      case AddInjuredPersonScreen.routeName:
        return _createRoute(AddInjuredPersonScreen(
            addAndEditIncidentMap: settings.arguments as Map));
      case IncidentInjuriesScreen.routeName:
        return _createRoute(
            IncidentInjuriesScreen(addIncidentMap: settings.arguments as Map));
      case LogbookListScreen.routeName:
        return _createRoute(
            LogbookListScreen(isFromHome: settings.arguments as bool));
      case TodoAssignedByMeAndToMeListScreen.routeName:
        return _createRoute(TodoAssignedByMeAndToMeListScreen());
      case ToDoDetailsAndDocumentDetailsScreen.routeName:
        return _createRoute(ToDoDetailsAndDocumentDetailsScreen(
            todoMap: settings.arguments as Map));
      case LeavesAndHolidaysScreen.routeName:
        return _createRoute(const LeavesAndHolidaysScreen());
      case LeavesSummaryScreen.routeName:
        return _createRoute(const LeavesSummaryScreen());
      case LeavesDetailsScreen.routeName:
        return _createRoute(const LeavesDetailsScreen());
      case ApplyForLeaveScreen.routeName:
        return _createRoute(ApplyForLeaveScreen());
      case AddToDoScreen.routeName:
        return _createRoute(AddToDoScreen(todoMap: settings.arguments as Map));
      case ToDoHistoryListScreen.routeName:
        return _createRoute(
            ToDoHistoryListScreen(todoMap: settings.arguments as Map));
      case ToDoSettingsScreen.routeName:
        return _createRoute(
            ToDoSettingsScreen(todoMap: settings.arguments as Map));
      case LogBookDetailsScreen.routeName:
        return _createRoute(
            LogBookDetailsScreen(logId: settings.arguments.toString()));
      case AddLogBookScreen.routeName:
        return _createRoute(const AddLogBookScreen());
      case ReportNewQA.routeName:
        return _createRoute(const ReportNewQA());
      case WorkOrderListScreen.routeName:
        return _createRoute(
            WorkOrderListScreen(isFromHome: settings.arguments as bool));
      case QualityManagementLocationScreen.routeName:
        return _createRoute(QualityManagementLocationScreen(
            reportNewQMMap: settings.arguments as Map));
      case QualityManagementCustomFieldsScreen.routeName:
        return _createRoute(QualityManagementCustomFieldsScreen(
            reportNewQAMap: settings.arguments as Map));
      case QualityManagementListScreen.routeName:
        return _createRoute(QualityManagementListScreen(
            isFromHome: settings.arguments as bool));
      case QualityManagementDetailsScreen.routeName:
        return _createRoute(QualityManagementDetailsScreen(
            qmListMap: settings.arguments as Map));
      case LogBookFilterScreen.routeName:
        return _createRoute(LogBookFilterScreen());
      case QualityManagementRolesScreen.routeName:
        return _createRoute(const QualityManagementRolesScreen());
      case CalendarScreen.routeName:
        return _createRoute(CalendarScreen());
      case QualityManagementAddCommentsScreen.routeName:
        return _createRoute(QualityManagementAddCommentsScreen(
            fetchQualityManagementDetailsModel:
                settings.arguments as FetchQualityManagementDetailsModel));
      case QualityManagementFilterScreen.routeName:
        return _createRoute(QualityManagementFilterScreen());
      case WorkOrderFilterScreen.routeName:
        return _createRoute(WorkOrderFilterScreen());
      case SignInListScreen.routeName:
        return _createRoute(const SignInListScreen());
      case CertificatesListScreen.routeName:
        return _createRoute(const CertificatesListScreen());
      case WorkOrderFormScreenOne.routeName:
        return _createRoute(WorkOrderFormScreenOne(
            workOrderDetailsMap: settings.arguments as Map));
      case UploadCertificateScreen.routeName:
        return _createRoute(UploadCertificateScreen(
          certificateItemsMap: settings.arguments as Map,
        ));
      case ProcessSignInScreen.routeName:
        return _createRoute(const ProcessSignInScreen());
      case WorkOrderFormScreenTwo.routeName:
        return _createRoute(WorkOrderFormScreenTwo(
            workOrderDetailsMap: settings.arguments as Map));
      case WorkOrderDetailsTabScreen.routeName:
        return _createRoute(const WorkOrderDetailsTabScreen());
      case LotoListScreen.routeName:
        return _createRoute(const LotoListScreen());
      case LotoFilterScreen.routeName:
        return _createRoute(LotoFilterScreen());
      case LotoLocationFilterList.routeName:
        return _createRoute(LotoLocationFilterList(
            selectLocationName: settings.arguments as String));
      case GetCourseCertificateScreen.routeName:
        return _createRoute(GetCourseCertificateScreen(
          certificateId: settings.arguments.toString(),
        ));
      case WorkOrderFormScreenThree.routeName:
        return _createRoute(WorkOrderFormScreenThree(
            workOrderDetailsMap: settings.arguments as Map));
      case WorkOrderFormScreenFour.routeName:
        return _createRoute(WorkOrderFormScreenFour(
            workOrderDetailsMap: settings.arguments as Map));
      case GetTopicCertificateScreen.routeName:
        return _createRoute(GetTopicCertificateScreen(
          courseId: settings.arguments.toString(),
        ));
      case FeedbackCertificateScreen.routeName:
        return _createRoute(FeedbackCertificateScreen(
          getdetailsMap: settings.arguments as Map,
        ));
      case WorkOrderAddMisCostScreen.routeName:
        return _createRoute(const WorkOrderAddMisCostScreen());
      case StartWorkOrderScreen.routeName:
        return _createRoute(const StartWorkOrderScreen());
      case GetWorkforceScreen.routeName:
        return _createRoute(
            GetWorkforceScreen(workforceQuizMap: settings.arguments as Map));
      case WorkOrderAddAndEditDownTimeScreen.routeName:
        return _createRoute(const WorkOrderAddAndEditDownTimeScreen());
      case AssignWorkForceScreen.routeName:
        return _createRoute(const AssignWorkForceScreen());
      case WorkOrderAddDocumentScreen.routeName:
        return _createRoute(const WorkOrderAddDocumentScreen());
      case WorkOrderDocumentFilterScreen.routeName:
        return _createRoute(const WorkOrderDocumentFilterScreen());
      case QuizQuestionsScreen.routeName:
        return _createRoute(QuizQuestionsScreen(
          quizMap: settings.arguments as Map,
        ));
      case DocumentsListScreen.routeName:
        return _createRoute(DocumentsListScreen(
          isFromHome: settings.arguments as bool,
        ));
      case LotoDetailsScreen.routeName:
        return _createRoute(const LotoDetailsScreen());
      case ChangeRoleDocumentsScreen.routeName:
        return _createRoute(const ChangeRoleDocumentsScreen());
      case WorkOrderAddPartsScreen.routeName:
        return _createRoute(const WorkOrderAddPartsScreen());
      case DocumentFilterScreen.routeName:
        return _createRoute(const DocumentFilterScreen());
      case LotoAssignTeamScreen.routeName:
        return _createRoute(const LotoAssignTeamScreen());
      case DocumentLocationFilterList.routeName:
        return _createRoute(DocumentLocationFilterList(
          selectLocation: settings.arguments.toString(),
        ));
      case WorkOrderEditWorkForceScreen.routeName:
        return _createRoute(const WorkOrderEditWorkForceScreen());
      case LotoAssignWorkforceScreen.routeName:
        return _createRoute(const LotoAssignWorkforceScreen());
      case StartLotoScreen.routeName:
        return _createRoute(const StartLotoScreen());
      default:
        return _createRoute(const WelcomeScreen());
    }
  }

  static Route<dynamic> _createRoute(Widget view) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => view,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
              position: animation.drive(tween), child: child);
        });
  }
}
