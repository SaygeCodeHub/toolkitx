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
        "${ApiConstants.baseUrl}common/getlocationdetails?hashcode=$hashCode&locationid=Ema+c++ehfgiM5Gpd7T6pg==&userid=$userId");
    return FetchLocationDetailsSignInModel.fromJson(response);
  }
}
