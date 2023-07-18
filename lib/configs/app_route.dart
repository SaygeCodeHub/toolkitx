import 'package:flutter/material.dart';
import 'package:toolkit/screens/checklist/workforce/workforce_list_screen.dart';
import 'package:toolkit/screens/incident/incident_details_screen.dart';
import '../data/models/incident/fetch_incidents_list_model.dart';
import '../data/models/permit/permit_details_model.dart';
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
import '../screens/incident/add_injured_person_screen.dart';
import '../screens/incident/category_screen.dart';
import '../screens/incident/change_role_screen.dart';
import '../screens/incident/incident_filter_screen.dart';
import '../screens/incident/incident_health_and_safety_screen.dart';
import '../screens/incident/incident_injuries_screen.dart';
import '../screens/incident/incident_list_screen.dart';
import '../screens/incident/incident_location_screen.dart';
import '../screens/incident/report_new_incident_screen.dart';
import '../screens/leavesAndHolidays/leaves_and_holidays_screen.dart';
import '../screens/leavesAndHolidays/leaves_details_screen.dart';
import '../screens/leavesAndHolidays/leaves_summary_screen.dart';
import '../screens/logBook/logbook_list_screen.dart';
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
import '../screens/root/root_screen.dart';
import '../screens/todo/todo_assigned_to_me_and_by_me_list_screen.dart';
import '../screens/todo/todo_details_and_document_details_screen.dart';
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
        return _createRoute(
            ReportNewIncidentScreen(addIncidentMap: settings.arguments as Map));
      case IncidentLocationScreen.routeName:
        return _createRoute(
            IncidentLocationScreen(addIncidentMap: settings.arguments as Map));
      case IncidentHealthAndSafetyScreen.routeName:
        return _createRoute(IncidentHealthAndSafetyScreen(
            addIncidentMap: settings.arguments as Map));
      case AddInjuredPersonScreen.routeName:
        return _createRoute(
            AddInjuredPersonScreen(addIncidentMap: settings.arguments as Map));
      case IncidentInjuriesScreen.routeName:
        return _createRoute(
            IncidentInjuriesScreen(addIncidentMap: settings.arguments as Map));
      case LogbookListScreen.routeName:
        return _createRoute(const LogbookListScreen());
      case TodoAssignedByMeAndToMeListScreen.routeName:
        return _createRoute(const TodoAssignedByMeAndToMeListScreen());
      case ToDoDetailsAndDocumentDetailsScreen.routeName:
        return _createRoute(ToDoDetailsAndDocumentDetailsScreen(
            todoMap: settings.arguments as Map));
      case LeavesAndHolidaysScreen.routeName:
        return _createRoute(const LeavesAndHolidaysScreen());
      case LeavesSummaryScreen.routeName:
        return _createRoute(const LeavesSummaryScreen());
      case LeavesDetailsScreen.routeName:
        return _createRoute(const LeavesDetailsScreen());
      case ToDoDetailsAndDocumentDetailsScreen.routeName:
        return _createRoute(ToDoDetailsAndDocumentDetailsScreen(
            todoMap: settings.arguments as Map));
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
