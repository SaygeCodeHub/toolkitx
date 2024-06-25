import 'package:toolkit/data/models/checklist/systemUser/sys_user_third_party_approval_model.dart';
import 'package:toolkit/data/models/checklist/systemUser/sys_user_workforce_list_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_approve_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_change_category_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_change_role_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_checklist_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_edit_header_details_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_fetch_pdf_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_reject_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_schedule_by_dates_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_submit_header_model.dart';

abstract class SysUserCheckListRepository {
  Future<ChecklistListModel> fetchCheckList(
      int pageNo, String hashCode, String filter);

  Future<ChecklistScheduledByDatesModel> fetchCheckListScheduleDates(
      String checklistId, String hashCode);

  Future<CheckListWorkforceListModel> fetchCheckListWorkforceList(
      String scheduleId, String hashCode, String role);

  Future<CheckListRolesModel> fetchCheckListRole(
      String hashCode, String userId);

  Future<GetCheckListFilterCategoryModel> fetchCheckListCategory(
      String hashCode, String userId);

  Future<ChecklistApproveModel> checkListApprove(Map postApproveDataMap);

  Future<ChecklistRejectModel> checkListReject(Map postRejectDataMap);

  Future<SaveCheckListThirdPartyApproval> checklistThirdPartyApproval(
      Map postThirdPartyApprovalMap);

  Future<CheckListEditHeaderDetailsModel> fetchCheckListEditHeader(
      String scheduleId, String hashCode);

  Future<ChecklistSubmitHeaderModel> submitCheckListHeader(
      Map postSubmitHeaderMap);

  Future<GetPdfModel> fetchCheckListPdf(String responseId, String hashCode);
}
