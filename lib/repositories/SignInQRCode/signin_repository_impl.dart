import 'package:toolkit/data/models/SignInQRCode/assign_to_me_checklist_model.dart';
import 'package:toolkit/data/models/SignInQRCode/assign_to_me_loto_model.dart';
import 'package:toolkit/data/models/SignInQRCode/assign_to_me_permit_model.dart';
import 'package:toolkit/data/models/SignInQRCode/assign_to_me_workorder_model.dart';
import 'package:toolkit/repositories/SignInQRCode/signin_repository.dart';

import '../../data/models/SignInQRCode/current_signin_model.dart';
import '../../data/models/SignInQRCode/sign_in_location_details_model.dart';
import '../../utils/constants/api_constants.dart';
import '../../utils/dio_client.dart';

class SignInImpl extends SignInRepository {
  @override
  Future<FetchCurrentSignInModel> signInList(
    String userId,
    String hashCode,
  ) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}common/getcurrentsignin?hashcode=$hashCode&userid=$userId");
    return FetchCurrentSignInModel.fromJson(response);
  }

  @override
  Future<FetchLocationDetailsSignInModel> signInLocationDetails(
      String hashCode, String locationId, String userId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}common/getlocationdetails?hashcode=$hashCode&locationid=$locationId&userid=$userId");
    return FetchLocationDetailsSignInModel.fromJson(response);
  }

  @override
  Future<AssignToMeChecklistModel> assignToMeChecklist(
      Map assignToMeChecklistMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}checklist/assignchecklist",
        assignToMeChecklistMap);
    return AssignToMeChecklistModel.fromJson(response);
  }

  @override
  Future<AssignToMeLotoModel> assignToMeLOTO(Map assignToMeLOTOMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}loto/selfassignworkforce", assignToMeLOTOMap);
    return AssignToMeLotoModel.fromJson(response);
  }

  @override
  Future<AssignToMePermitModel> assignToMePermit(
      Map assignToMePermitMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}permit/assignworkforce", assignToMePermitMap);
    return AssignToMePermitModel.fromJson(response);
  }

  @override
  Future<AssignToMeWorkOrderModel> assignToMeWorkOrder(
      Map assignToMeWorkorderMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}workorder/selfassignworkforce",
        assignToMeWorkorderMap);

    return AssignToMeWorkOrderModel.fromJson(response);
  }
}
