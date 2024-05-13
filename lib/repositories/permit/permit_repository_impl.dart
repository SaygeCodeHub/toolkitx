import 'package:toolkit/data/models/permit/accept_permit_request_model.dart';
import 'package:toolkit/data/models/permit/fetch_clear_permit_details_model.dart';
import 'package:toolkit/data/models/permit/fetch_data_for_open_permit_model.dart';
import 'package:toolkit/data/models/permit/fetch_permit_basic_details_model.dart';
import 'package:toolkit/data/models/permit/save_clear_permit_model.dart';
import 'package:toolkit/data/models/permit/save_mark_as_prepared_model.dart';
import 'package:toolkit/utils/constants/api_constants.dart';
import '../../data/models/pdf_generation_model.dart';
import '../../data/models/permit/all_permits_model.dart';
import '../../data/models/permit/close_permit_details_model.dart';
import '../../data/models/permit/open_close_permit_model.dart';
import '../../data/models/permit/open_permit_details_model.dart';
import '../../data/models/permit/permit_details_model.dart';
import '../../data/models/permit/permit_get_master_model.dart';
import '../../data/models/permit/permit_roles_model.dart';
import '../../utils/dio_client.dart';
import 'permit_repository.dart';

class PermitRepositoryImpl extends PermitRepository {
  @override
  Future<AllPermitModel> getAllPermits(
      String hashCode, String filter, String role, int pageNo) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}permit/get?pageno=$pageNo&hashcode=$hashCode&filter=$filter&role=$role");
    return AllPermitModel.fromJson(response);
  }

  @override
  Future<PermitRolesModel> fetchPermitRoles(
      String hashCode, String userId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}permit/getroles?hashcode=$hashCode&userid=$userId");
    return PermitRolesModel.fromJson(response);
  }

  @override
  Future<PermitDetailsModel> fetchPermitDetails(
      String hashCode, String permitId, String role) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}permit/GetPermitAllDetails?permitid=$permitId&hashcode=$hashCode&role=$role");
    return PermitDetailsModel.fromJson(response);
  }

  @override
  Future<PdfGenerationModel> generatePdf(
      String hashCode, String permitId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}permit/getpdf?permitid=$permitId&hashcode=$hashCode");
    return PdfGenerationModel.fromJson(response);
  }

  @override
  Future<PermitGetMasterModel> fetchMaster(String hashCode) async {
    final response = await DioClient()
        .get("${ApiConstants.baseUrl}permit/getmaster?hashcode=$hashCode");
    return PermitGetMasterModel.fromJson(response);
  }

  @override
  Future<ClosePermitDetailsModel> closePermitDetails(
      String hashCode, String permitId, String role) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}permit/getdataforclosepermit?permitid=$permitId&hashcode=$hashCode&role=$role");
    return ClosePermitDetailsModel.fromJson(response);
  }

  @override
  Future<OpenPermitDetailsModel> openPermitDetails(
      String hashCode, String permitId, String role) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}permit/getdataforopenpermit?permitid=$permitId&hashcode=$hashCode&role=$role");
    return OpenPermitDetailsModel.fromJson(response);
  }

  @override
  Future<OpenClosePermitModel> closePermit(Map closePermitMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}permit/closepermit", closePermitMap);
    return OpenClosePermitModel.fromJson(response);
  }

  @override
  Future<OpenClosePermitModel> openPermit(Map openPermitMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}permit/openpermit", openPermitMap);
    return OpenClosePermitModel.fromJson(response);
  }

  @override
  Future<OpenClosePermitModel> requestPermit(Map requestPermitMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}permit/RequestPermit", requestPermitMap);
    return OpenClosePermitModel.fromJson(response);
  }

  @override
  Future<FetchPermitBasicDetailsModel> fetchPermitBasicDetails(
      String permitId, String hashCode, String roleId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}permit/getbasicdetails?permitid=$permitId&hashcode=$hashCode&role=$roleId");
    return FetchPermitBasicDetailsModel.fromJson(response);
  }

  @override
  Future<FetchDataForOpenPermitModel> fetchDataForOpenPermit(
      String permitId, String hashCode, String roleId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}permit/getdataforopenpermit?permitid=$permitId&hashcode=$hashCode&role=$roleId");
    return FetchDataForOpenPermitModel.fromJson(response);
  }

  @override
  Future<SaveMarkAsPreparedModel> saveMarkAsPrepared(
      Map saveMarkAsPreparedMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}permit/markasprepared", saveMarkAsPreparedMap);
    return SaveMarkAsPreparedModel.fromJson(response);
  }

  @override
  Future<AcceptPermitRequestModel> acceptPermitRequest(
      Map acceptPermitRequestMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}permit/accpetpermitrequest",
        acceptPermitRequestMap);
    return AcceptPermitRequestModel.fromJson(response);
  }

  @override
  Future<FetchClearPermitDetailsModel> fetchClearPermitDetails(
      Map clearPermitMap) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}permit/getdataforclearpermit?permitid=${clearPermitMap['permit_id']}&hashcode=${clearPermitMap['hashcode']}&role=${clearPermitMap['role']}");
    return FetchClearPermitDetailsModel.fromJson(response);
  }

  @override
  Future<SaveClearPermitModel> saveClearPermit(Map clearPermitMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}permit/clearpermit", clearPermitMap);
    return SaveClearPermitModel.fromJson(response);
  }
}
