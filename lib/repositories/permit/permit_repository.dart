import 'package:toolkit/data/models/permit/accept_permit_request_model.dart';
import 'package:toolkit/data/models/permit/change_permit_cp_model.dart';
import 'package:toolkit/data/models/permit/fetch_clear_permit_details_model.dart';
import 'package:toolkit/data/models/permit/fetch_data_for_change_permit_cp_model.dart';
import 'package:toolkit/data/models/permit/fetch_data_for_open_permit_model.dart';
import 'package:toolkit/data/models/permit/fetch_permit_basic_details_model.dart';
import 'package:toolkit/data/models/permit/open_close_permit_model.dart';
import 'package:toolkit/data/models/permit/open_permit_details_model.dart';
import 'package:toolkit/data/models/permit/permit_roles_model.dart';
import 'package:toolkit/data/models/permit/save_clear_permit_model.dart';
import 'package:toolkit/data/models/permit/save_mark_as_prepared_model.dart';
import 'package:toolkit/data/models/permit/save_permit_safety_notice_model.dart';
import 'package:toolkit/data/models/permit/sync_transfer_cp_model.dart';

import '../../data/models/pdf_generation_model.dart';
import '../../data/models/permit/all_permits_model.dart';
import '../../data/models/permit/close_permit_details_model.dart';
import '../../data/models/permit/offline_permit_model.dart';
import '../../data/models/permit/permit_details_model.dart';
import '../../data/models/permit/permit_get_master_model.dart';
import '../../data/models/permit/surrender_permit_model.dart';

abstract class PermitRepository {
  Future<AllPermitModel> getAllPermits(
      String hashCode, String filter, String role, int pageNo);

  Future<PermitRolesModel> fetchPermitRoles(String hashCode, String userId);

  Future<PermitDetailsModel> fetchPermitDetails(
      String hashCode, String permitId, String role);

  Future<PdfGenerationModel> generatePdf(String hashCode, String permitId);

  Future<PermitGetMasterModel> fetchMaster(String hashCode);

  Future<OpenClosePermitModel> closePermit(Map closePermitMap);

  Future<ClosePermitDetailsModel> closePermitDetails(
      String hashCode, String permitId, String role);

  Future<OpenPermitDetailsModel> openPermitDetails(
      String hashCode, String permitId, String role);

  Future<OpenClosePermitModel> openPermit(Map openPermitMap);

  Future<OpenClosePermitModel> requestPermit(Map requestPermitMap);

  Future<OfflinePermitModel> fetchOfflinePermit(String hashCode);

  Future<FetchPermitBasicDetailsModel> fetchPermitBasicDetails(
      String permitId, String hashCode, String roleId);

  Future<FetchDataForOpenPermitModel> fetchDataForOpenPermit(
      String permitId, String hashCode, String roleId);

  Future<SaveMarkAsPreparedModel> saveMarkAsPrepared(Map saveMarkAsPreparedMap);

  Future<AcceptPermitRequestModel> acceptPermitRequest(
      Map acceptPermitRequestMap);

  Future<FetchClearPermitDetailsModel> fetchClearPermitDetails(
      Map clearPermitMap);

  Future<SaveClearPermitModel> saveClearPermit(Map clearPermitMap);

  Future<SavePermitEditSafetyDocumentModel> saveEditSafetyNoticeDocument(
      Map editSafetyDocumentMap);

  Future<SurrenderPermitModel> surrenderPermit(Map surrenderPermitMap);

  Future<FetchDataForChangePermitCpModel> fetchDataForChangePermitCP(
      String permitId, String hashCode);

  Future<ChangePermitCpModel> changePermitCP(Map changePermitCPMap);

  Future<SyncTransferCpPermitModel> syncTransferCp(Map syncTransferCpMap);
}
