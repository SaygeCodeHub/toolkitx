import 'package:flutter/material.dart';
import 'package:toolkit/screens/assets/add_assets_document_screen.dart';
import 'package:toolkit/screens/certificates/get_notes_certificate_screen.dart';
import 'package:toolkit/screens/certificates/upload_certificate_screen.dart';
import 'package:toolkit/screens/checklist/workforce/workforce_list_screen.dart';
import 'package:toolkit/screens/equipmentTraceability/equipment_save_images.dart';
import 'package:toolkit/screens/equipmentTraceability/equipment_set_parameter_screen.dart';
import 'package:toolkit/screens/equipmentTraceability/search_equipment_details_screen.dart';
import 'package:toolkit/screens/expense/expense_reject_screen.dart';
import 'package:toolkit/screens/incident/incident_details_screen.dart';
import 'package:toolkit/screens/leavesAndHolidays/timesheet_checkin_screen.dart';
import 'package:toolkit/screens/loto/loto_view_response_screen.dart';
import 'package:toolkit/screens/permit/accept_permit_request_screen.dart';
import 'package:toolkit/screens/permit/clear_permit_screen.dart';
import 'package:toolkit/screens/permit/permit_edit_safety_document_screen.dart';
import 'package:toolkit/screens/permit/permit_transfer_component_screen.dart';
import 'package:toolkit/screens/permit/prepare_permit_screen.dart';
import 'package:toolkit/screens/permit/surrender_permit_screen.dart';
import 'package:toolkit/screens/signInQRCode/signin_list_screen.dart';
import 'package:toolkit/screens/tickets/add_ticket_document_screen.dart';
import 'package:toolkit/screens/tickets/ticket_details_screen.dart';
import 'package:toolkit/screens/tickets/ticket_list_screen.dart';
import 'package:toolkit/screens/tickets/add_ticket_screen.dart';
import 'package:toolkit/screens/tickets/widgets/open_ticket_screen.dart';
import 'package:toolkit/screens/tickets/widgets/ticket_edt_hour_screen.dart';
import 'package:toolkit/screens/trips/trip_details_screen.dart';
import 'package:toolkit/screens/trips/trips_list_screen.dart';
import '../data/models/documents/documents_details_models.dart';
import '../data/models/permit/permit_details_model.dart';
import '../data/models/qualityManagement/fetch_qm_details_model.dart';
import '../screens/assets/assets_details_screen.dart';
import '../screens/assets/assets_filter_screen.dart';
import '../screens/assets/assets_list_screen.dart';
import '../screens/assets/assets_manage_comments_screen.dart';
import '../screens/assets/assets_manage_document_filter_screen.dart';
import '../screens/assets/assets_manage_document_screeen.dart';
import '../screens/assets/assets_manage_meter_reading_screen.dart';
import '../screens/assets/assets_report_failure_screen.dart';
import '../screens/assets/widgets/assets_add_and_edit_downtime_screen.dart';
import '../screens/assets/widgets/assets_add_comment_screen.dart';
import '../screens/assets/widgets/assets_document_filter_type_list.dart';
import '../screens/assets/widgets/assets_location_filter_list.dart';
import '../screens/assets/assets_manage_downtime_screen.dart';
import '../screens/assets/widgets/assets_report_failure_location_list.dart';
import '../screens/calendar/calendar_screen.dart';
import '../screens/certificates/edit_certifcate_feedback_screen.dart';
import '../screens/certificates/get_certificate_details_screen.dart';
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
import '../screens/documents/add_document_comments_screen.dart';
import '../screens/documents/attach_document_screen.dart';
import '../screens/documents/change_role_documents.dart';
import '../screens/documents/document_filter_screen.dart';
import '../screens/documents/documents_approve_and_reject_screen.dart';
import '../screens/documents/documents_details_screen.dart';
import '../screens/documents/documents_list_screen.dart';
import '../screens/documents/link_document_screen.dart';
import '../screens/documents/link_documents_filter_screen.dart';
import '../screens/documents/open_document_for_review_screen.dart';
import '../screens/documents/widgets/document_location_filter_list.dart';
import '../screens/equipmentTraceability/approve_equipment_request_screen.dart';
import '../screens/equipmentTraceability/enter_equipment_code_screen.dart';
import '../screens/equipmentTraceability/equipment_trace_screen.dart';
import '../screens/equipmentTraceability/search_equipment_filter_screen.dart';
import '../screens/equipmentTraceability/search_equipment_list_screen.dart';
import '../screens/equipmentTraceability/send_transfer_screen.dart';
import '../screens/equipmentTraceability/transfer_equipment_screen.dart';
import '../screens/equipmentTraceability/view_my_request_screen.dart';
import '../screens/expense/expense_filter_screen.dart';
import '../screens/expense/expense_details_screen.dart';
import '../screens/expense/expense_list_screen.dart';
import '../screens/expense/manage_expense_form_screen.dart';
import '../screens/expense/widgets/addItemsWidgets/expense_edit_form_three.dart';
import '../screens/expense/widgets/addItemsWidgets/expense_edit_form_two.dart';
import '../screens/expense/widgets/addItemsWidgets/expense_edit_items_screen.dart';
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
import '../screens/leavesAndHolidays/add_and_edit_timesheet_screen.dart';
import '../screens/location/location_details_screen.dart';
import '../screens/location/location_list_screen.dart';
import '../screens/location/widgets/location_filter_screen.dart';
import '../screens/logBook/logbook_details_screen.dart';
import '../screens/logBook/add_logbook_screen.dart';
import '../screens/logBook/logbook_filter_screen.dart';
import '../screens/logBook/logbook_list_screen.dart';
import '../screens/loto/loto_filter_screen.dart';
import '../screens/loto/loto_list_screen.dart';
import '../screens/loto/widgets/loto_location_list.dart';
import '../screens/loto/loto_add_comment_screen.dart';
import '../screens/loto/loto_assign_team_screen.dart';
import '../screens/loto/loto_assign_workfoce_screen.dart';
import '../screens/loto/loto_details_screen.dart';
import '../screens/loto/loto_upload_photos_screen.dart';
import '../screens/loto/loto_reject_screen.dart';
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
import '../screens/safetyNotice/add_and_edit_safety_notice_screen.dart';
import '../screens/safetyNotice/safety_notice_details_screen.dart';
import '../screens/safetyNotice/safety_notice_history_screen.dart';
import '../screens/safetyNotice/safety_notice_filter_screen.dart';
import '../screens/safetyNotice/safety_notice_screen.dart';
import '../screens/signInQRCode/process_signin.dart';
import '../screens/tickets/tickets_filter_screen.dart';
import '../screens/tickets/add_ticket_comment_screen.dart';
import '../screens/tickets/widgets/ticket_application_filter_list.dart';
import '../screens/tickets/widgets/ticket_completion_date_screen.dart';
import '../screens/todo/add_todo_screen.dart';
import '../screens/todo/todo_assigned_to_me_and_by_me_list_screen.dart';
import '../screens/todo/todo_details_and_document_details_screen.dart';
import '../screens/todo/todo_history_list_screen.dart';
import '../screens/todo/todo_settings_screen.dart';
import '../screens/workorder/assign_workforce_screen.dart';
import '../screens/workorder/workorder_add_parts_screen.dart';
import '../screens/workorder/start_and_complete_workorder_screen.dart';
import '../screens/workorder/workorder_add_comments_screen.dart';
import '../screens/workorder/workorder_assign_document_screen.dart';
import '../screens/workorder/workorder_add_mis_cost_screen.dart';
import '../screens/workorder/workorder_add_and_edit_down_time_screen.dart';
import '../screens/workorder/workorder_document_filter_screen.dart';
import '../screens/workorder/workorder_edit_items_screen.dart';
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
        return _createRoute(
            IncidentDetailsScreen(incidentId: settings.arguments.toString()));
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
            todoId: settings.arguments.toString()));
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
            qmId: settings.arguments.toString()));
      case LogBookFilterScreen.routeName:
        return _createRoute(const LogBookFilterScreen());
      case QualityManagementRolesScreen.routeName:
        return _createRoute(const QualityManagementRolesScreen());
      case CalendarScreen.routeName:
        return _createRoute(const CalendarScreen());
      case QualityManagementAddCommentsScreen.routeName:
        return _createRoute(QualityManagementAddCommentsScreen(
            fetchQualityManagementDetailsModel:
                settings.arguments as FetchQualityManagementDetailsModel));
      case QualityManagementFilterScreen.routeName:
        return _createRoute(QualityManagementFilterScreen());
      case WorkOrderFilterScreen.routeName:
        return _createRoute(const WorkOrderFilterScreen());
      case SignInListScreen.routeName:
        return _createRoute(const SignInListScreen());
      case CertificatesListScreen.routeName:
        return _createRoute(const CertificatesListScreen());
      case WorkOrderFormScreenOne.routeName:
        return _createRoute(WorkOrderFormScreenOne(
            workOrderDetailsMap: settings.arguments as Map));
      case UploadCertificateScreen.routeName:
        return _createRoute(UploadCertificateScreen(
            certificateItemsMap: settings.arguments as Map));
      case ProcessSignInScreen.routeName:
        return _createRoute(const ProcessSignInScreen());
      case WorkOrderFormScreenTwo.routeName:
        return _createRoute(WorkOrderFormScreenTwo(
            workOrderDetailsMap: settings.arguments as Map));
      case WorkOrderDetailsTabScreen.routeName:
        return _createRoute(WorkOrderDetailsTabScreen(
            workOrderId: settings.arguments.toString()));
      case LotoListScreen.routeName:
        return _createRoute(const LotoListScreen());
      case LotoFilterScreen.routeName:
        return _createRoute(LotoFilterScreen());
      case LotoLocationFilterList.routeName:
        return _createRoute(LotoLocationFilterList(
            selectLocationName: settings.arguments as String));
      case GetCourseCertificateScreen.routeName:
        return _createRoute(GetCourseCertificateScreen(
            certificateId: settings.arguments.toString()));
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
      case GetNotesCertificateScreen.routeName:
        return _createRoute(GetNotesCertificateScreen(
          getNotesMap: settings.arguments as Map,
        ));
      case FeedbackCertificateScreen.routeName:
        return _createRoute(FeedbackCertificateScreen(
            getdetailsMap: settings.arguments as Map));
      case WorkOrderAddMisCostScreen.routeName:
        return _createRoute(const WorkOrderAddMisCostScreen());
      case StartAndCompleteWorkOrderScreen.routeName:
        return _createRoute(StartAndCompleteWorkOrderScreen(
          isFromStart: settings.arguments as bool,
        ));
      case GetWorkforceScreen.routeName:
        return _createRoute(
            GetWorkforceScreen(workforceQuizMap: settings.arguments as Map));
      case WorkOrderAddAndEditDownTimeScreen.routeName:
        return _createRoute(const WorkOrderAddAndEditDownTimeScreen());
      case AssignWorkForceScreen.routeName:
        return _createRoute(const AssignWorkForceScreen());
      case WorkOrderAssignDocumentScreen.routeName:
        return _createRoute(const WorkOrderAssignDocumentScreen());
      case WorkOrderDocumentFilterScreen.routeName:
        return _createRoute(const WorkOrderDocumentFilterScreen());
      case QuizQuestionsScreen.routeName:
        return _createRoute(
            QuizQuestionsScreen(quizMap: settings.arguments as Map));
      case DocumentsListScreen.routeName:
        return _createRoute(
            DocumentsListScreen(isFromHome: settings.arguments as bool));
      case GetCertificateDetailsScreen.routeName:
        return _createRoute(GetCertificateDetailsScreen(
            certificateMap: settings.arguments as Map));
      case LotoDetailsScreen.routeName:
        return _createRoute(
            LotoDetailsScreen(lotoId: settings.arguments.toString()));
      case ChangeRoleDocumentsScreen.routeName:
        return _createRoute(const ChangeRoleDocumentsScreen());
      case WorkOrderAddPartsScreen.routeName:
        return _createRoute(const WorkOrderAddPartsScreen());
      case DocumentFilterScreen.routeName:
        return _createRoute(const DocumentFilterScreen());
      case LotoAssignTeamScreen.routeName:
        return _createRoute(const LotoAssignTeamScreen());
      case WorkOrderAddCommentsScreen.routeName:
        return _createRoute(const WorkOrderAddCommentsScreen());
      case DocumentLocationFilterList.routeName:
        return _createRoute(DocumentLocationFilterList(
            selectLocation: settings.arguments.toString()));
      case WorkOrderEditWorkForceScreen.routeName:
        return _createRoute(const WorkOrderEditWorkForceScreen());
      case SafetyNoticeScreen.routeName:
        return _createRoute(
            SafetyNoticeScreen(isFromHomeScreen: settings.arguments as bool));
      case LotoAssignWorkforceScreen.routeName:
        return _createRoute(const LotoAssignWorkforceScreen());
      case StartLotoScreen.routeName:
        return _createRoute(const StartLotoScreen());
      case LotoUploadPhotosScreen.routeName:
        return _createRoute(LotoUploadPhotosScreen());
      case LotoAddCommentScreen.routeName:
        return _createRoute(const LotoAddCommentScreen());
      case DocumentsDetailsScreen.routeName:
        return _createRoute(const DocumentsDetailsScreen());
      case AssetsListScreen.routeName:
        return _createRoute(const AssetsListScreen());
      case AssetsFilterScreen.routeName:
        return _createRoute(AssetsFilterScreen());
      case AssetsLocationFilterList.routeName:
        return _createRoute(AssetsLocationFilterList(
            selectLocationName: settings.arguments.toString()));
      case AssetsDetailsScreen.routeName:
        return _createRoute(const AssetsDetailsScreen());
      case AddAndEditSafetyNoticeScreen.routeName:
        return _createRoute(const AddAndEditSafetyNoticeScreen());
      case SafetyNoticeDetailsScreen.routeName:
        return _createRoute(SafetyNoticeDetailsScreen(
          safetyNoticeId: settings.arguments.toString(),
        ));
      case SafetyNoticeHistoryScreen.routeName:
        return _createRoute(const SafetyNoticeHistoryScreen());
      case LinkDocumentScreen.routeName:
        return _createRoute(const LinkDocumentScreen());
      case AssetsManageDownTimeScreen.routeName:
        return _createRoute(const AssetsManageDownTimeScreen());
      case AssetsReportFailureLocationList.routeName:
        return _createRoute(AssetsReportFailureLocationList(
            selectLocationName: settings.arguments.toString()));
      case AssetsAddAndEditDowntimeScreen.routeName:
        return _createRoute(AssetsAddAndEditDowntimeScreen(
            downtimeId: settings.arguments.toString()));
      case LinkDocumentsFilterScreen.routeName:
        return _createRoute(const LinkDocumentsFilterScreen());
      case AttachDocumentScreen.routeName:
        return _createRoute(AttachDocumentScreen(
            documentDetailsModel: settings.arguments as DocumentDetailsModel));
      case SafetyNoticeFilterScreen.routeName:
        return _createRoute(const SafetyNoticeFilterScreen());
      case ExpenseListScreen.routeName:
        return _createRoute(const ExpenseListScreen());
      case AssetsManageDocumentScreen.routeName:
        return _createRoute(const AssetsManageDocumentScreen());
      case AssetsManageCommentsScreen.routeName:
        return _createRoute(const AssetsManageCommentsScreen());
      case AssetsReportFailureScreen.routeName:
        return _createRoute(AssetsReportFailureScreen());
      case AssetsManageMeterReadingScreen.routeName:
        return _createRoute(const AssetsManageMeterReadingScreen());
      case AssetsAddCommentScreen.routeName:
        return _createRoute(const AssetsAddCommentScreen());
      case ExpenseFilterScreen.routeName:
        return _createRoute(const ExpenseFilterScreen());
      case LocationDetailsScreen.routeName:
        return _createRoute(
            LocationDetailsScreen(expenseId: settings.arguments.toString()));
      case LocationListScreen.routeName:
        return _createRoute(const LocationListScreen(isFromHome: true));
      case ExpenseDetailsScreen.routeName:
        return _createRoute(
            ExpenseDetailsScreen(expenseId: settings.arguments.toString()));
      case ManageExpenseFormScreen.routeName:
        return _createRoute(const ManageExpenseFormScreen());
      case AddAssetsDocumentScreen.routeName:
        return _createRoute(const AddAssetsDocumentScreen());
      case AssetsManageDocumentFilterScreen.routeName:
        return _createRoute(const AssetsManageDocumentFilterScreen());
      case LocationFilterScreen.routeName:
        return _createRoute(const LocationFilterScreen());
      case AssetsDocumentFilterTypeList.routeName:
        return _createRoute(AssetsDocumentFilterTypeList(
          selectedTypeName: settings.arguments.toString(),
        ));
      case LotoViewResponseScreen.routeName:
        return _createRoute(LotoViewResponseScreen(
          checklistId: settings.arguments.toString(),
        ));
      case LotoRejectScreen.routeName:
        return _createRoute(const LotoRejectScreen());
      case EquipmentTraceScreen.routeName:
        return _createRoute(const EquipmentTraceScreen());
      case SearchEquipmentListScreen.routeName:
        return _createRoute(SearchEquipmentListScreen(
          isFromHome: settings.arguments as bool,
        ));
      case SearchEquipmentDetailsScreen.routeName:
        return _createRoute(const SearchEquipmentDetailsScreen());

      case SearchEquipmentFilterScreen.routeName:
        return _createRoute(const SearchEquipmentFilterScreen());
      case EquipmentSetParameterScreen.routeName:
        return _createRoute(EquipmentSetParameterScreen(
          equipmentMap: settings.arguments as Map,
        ));
      case TransferEquipmentScreen.routeName:
        return _createRoute(const TransferEquipmentScreen());
      case ExpenseEditItemsScreen.routeName:
        return _createRoute(ExpenseEditItemsScreen(
            expenseItemId: settings.arguments.toString()));
      case ExpenseEditFormTwo.routeName:
        return _createRoute(
            ExpenseEditFormTwo(arguments: settings.arguments as List));
      case ExpenseEditFormThree.routeName:
        return _createRoute(const ExpenseEditFormThree());
      case EquipmentSaveImages.routeName:
        return _createRoute(EquipmentSaveImages());
      case EnterEquipmentCodeScreen.routeName:
        return _createRoute(const EnterEquipmentCodeScreen());
      case TimeSheetCheckInScreen.routeName:
        return _createRoute(
            TimeSheetCheckInScreen(timeSheetMap: settings.arguments as Map));
      case AddAndEditTimeSheetScreen.routeName:
        return _createRoute(const AddAndEditTimeSheetScreen());
      case ViewMyRequestScreen.routeName:
        return _createRoute(const ViewMyRequestScreen());
      case SendTransferScreen.routeName:
        return _createRoute(const SendTransferScreen());
      case ApproveEquipmentRequestScreen.routeName:
        return _createRoute(ApproveEquipmentRequestScreen(
            requestId: settings.arguments.toString()));
      case DocumentsApproveAndRejectScreen.routeName:
        return _createRoute(const DocumentsApproveAndRejectScreen());
      case AddDocumentCommentsScreen.routeName:
        return _createRoute(const AddDocumentCommentsScreen());
      case OpenDocumentForReviewScreen.routeName:
        return _createRoute(const OpenDocumentForReviewScreen());
      case ExpenseRejectScreen.routeName:
        return _createRoute(const ExpenseRejectScreen());
      case TicketListScreen.routeName:
        return _createRoute(
            TicketListScreen(isFromHome: settings.arguments as bool));
      case TicketsFilterScreen.routeName:
        return _createRoute(const TicketsFilterScreen());
      case TicketApplicationFilterList.routeName:
        return _createRoute(TicketApplicationFilterList(
            selectApplicationName: settings.arguments.toString()));
      case TicketDetailsScreen.routeName:
        return _createRoute(
            TicketDetailsScreen(ticketId: settings.arguments.toString()));
      case AddTicketScreen.routeName:
        return _createRoute(const AddTicketScreen());
      case AddTicketCommentScreen.routeName:
        return _createRoute(const AddTicketCommentScreen());
      case AddTicketDocumentScreen.routeName:
        return _createRoute(const AddTicketDocumentScreen());
      case TicketEDTHoursScreen.routeName:
        return _createRoute(const TicketEDTHoursScreen());
      case TicketCompletionDateScreen.routeName:
        return _createRoute(const TicketCompletionDateScreen());
      case WorkOrderEditItemsScreen.routeName:
        return _createRoute(WorkOrderEditItemsScreen(
          workOrderItemMap: settings.arguments as Map,
        ));
      case EditCertificateFeedbackScreen.routeName:
        return _createRoute(EditCertificateFeedbackScreen(
            getDetailsMap: settings.arguments as Map));
      case PreparePermitScreen.routeName:
        return _createRoute(
            PreparePermitScreen(permitId: settings.arguments.toString()));
      case AcceptPermitRequestScreen.routeName:
        return _createRoute(
            AcceptPermitRequestScreen(permitId: settings.arguments.toString()));
      case ClearPermitScreen.routeName:
        return _createRoute(
            ClearPermitScreen(permitId: settings.arguments.toString()));
      case PermitEditSafetyDocumentScreen.routeName:
        return _createRoute(PermitEditSafetyDocumentScreen(
            permitId: settings.arguments.toString()));
      case PermitTransferComponentScreen.routeName:
        return _createRoute(PermitTransferComponentScreen(
            permitId: settings.arguments.toString()));
      case SurrenderPermitScreen.routeName:
        return _createRoute(
            SurrenderPermitScreen(permitId: settings.arguments.toString()));
      case OpenTicketScreen.routeName:
        return _createRoute(const OpenTicketScreen());
      case TripsListScreen.routeName:
        return _createRoute(const TripsListScreen());
      case TripsDetailsScreen.routeName:
        return _createRoute(
            TripsDetailsScreen(tripId: settings.arguments.toString()));
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
