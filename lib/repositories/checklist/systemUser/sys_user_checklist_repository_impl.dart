import '../../../data/models/checklist/systemUser/sys_user_approve_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_change_category_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_change_role_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_checklist_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_edit_header_details_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_fetch_pdf_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_reject_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_schedule_by_dates_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_submit_header_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_third_party_approval_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_workforce_list_model.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/dio_client.dart';
import 'sys_user_checklist_repository.dart';

class SysUserCheckListRepositoryImpl extends SysUserCheckListRepository {
  @override
  Future<ChecklistListModel> fetchCheckList(
      int pageNo, String hashCode, String filter) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}checklist/getallchecklists?pageno=$pageNo&hashcode=$hashCode&filter=$filter");
    return ChecklistListModel.fromJson(response);
  }

  @override
  Future<ChecklistScheduledByDatesModel> fetchCheckListScheduleDates(
      String checklistId, String hashCode) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}checklist/getscheduleddates?checklistid=$checklistId&hashcode=$hashCode");
    return ChecklistScheduledByDatesModel.fromJson(response);
  }

  @override
  Future<CheckListWorkforceListModel> fetchCheckListWorkforceList(
      String scheduleId, String hashCode, String role) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}checklist/getallworkforce?scheduleid=$scheduleId&hashcode=$hashCode&role=$role");
    return CheckListWorkforceListModel.fromJson(response);
  }

  @override
  Future<CheckListRolesModel> fetchCheckListRole(
      String hashCode, String userId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}checklist/getroles?hashcode=$hashCode&userid=$userId");
    return CheckListRolesModel.fromJson(response);
  }

  @override
  Future<GetCheckListFilterCategoryModel> fetchCheckListCategory(
      String hashCode, String userId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}checklist/getmaster?hashcode=$hashCode&userid=$userId");
    return GetCheckListFilterCategoryModel.fromJson(response);
  }

  @override
  Future<ChecklistApproveModel> checkListApprove(Map postApproveDataMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}checklist/approvechecklist",
        postApproveDataMap);
    return ChecklistApproveModel.fromJson(response);
  }

  @override
  Future<ChecklistRejectModel> checkListReject(Map postRejectDataMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}checklist/rejectchecklist", postRejectDataMap);
    return ChecklistRejectModel.fromJson(response);
  }

  @override
  Future<SaveCheckListThirdPartyApproval> checklistThirdPartyApproval(
      Map postThirdPartyApprovalMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}checklist/savethirdpartysign",
        postThirdPartyApprovalMap);
    return SaveCheckListThirdPartyApproval.fromJson(response);
  }

  @override
  Future<CheckListEditHeaderDetailsModel> fetchCheckListEditHeader(
      String scheduleId, String hashCode) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}checklist/gettemplatecustomfields?scheduleid=$scheduleId&hashcode=$hashCode");
    return CheckListEditHeaderDetailsModel.fromJson(response);
  }

  @override
  Future<ChecklistSubmitHeaderModel> submitCheckListHeader(
      Map postSubmitHeaderMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}checklist/savetemplatecustomfields",
        postSubmitHeaderMap);
    return ChecklistSubmitHeaderModel.fromJson(response);
  }

  @override
  Future<GetPdfModel> fetchCheckListPdf(
      String responseId, String hashCode) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}checklist/getpdf?responseid=$responseId&hashcode=$hashCode");
    return GetPdfModel.fromJson(response);
  }
}
