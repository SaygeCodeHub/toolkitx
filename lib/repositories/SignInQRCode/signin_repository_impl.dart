import 'dart:developer';

import 'package:toolkit/data/models/SignInQRCode/process_singin_model.dart';
import 'package:toolkit/repositories/SignInQRCode/signin_repository.dart';

import '../../data/models/SignInQRCode/current_signin_model.dart';
import '../../data/models/SignInQRCode/signin_unathorized_model.dart';
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
  Future<ProcessSignInModel> processSignIn(Map processSingInMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}common/processsignin", processSingInMap);
    return ProcessSignInModel.fromJson(response);
  }

  @override
  Future<SignInUnathorizedModel> unathorizedSignIn(Map unathorizedSingInMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}common/processunauthorizedsignin", unathorizedSingInMap);
    log("response======>$response");
    return SignInUnathorizedModel.fromJson(response);
  }
}
