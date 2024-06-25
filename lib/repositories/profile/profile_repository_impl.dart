import 'package:toolkit/repositories/profile/profile_repository.dart';

import '../../data/models/profile/change_password_model.dart';
import '../../data/models/profile/generate_change_password_opt_model.dart';
import '../../data/models/profile/update_user_profile_model.dart';
import '../../data/models/profile/user_profile_model.dart';
import '../../utils/constants/api_constants.dart';
import '../../utils/dio_client.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  @override
  Future<UserProfileModel> fetchUserProfile(String hashCode) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}/common/getuserprofile?hashcode=$hashCode");
    return UserProfileModel.fromJson(response);
  }

  @override
  Future<UpdateUserProfileModel> updateUserProfile(
      Map updateUserProfileMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}common/updateprofile", updateUserProfileMap);
    return UpdateUserProfileModel.fromJson(response);
  }

  @override
  Future<GenerateChangePasswordOtpModel> generateOtp(Map generateOtpMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}common/generateotpbyuser", generateOtpMap);
    return GenerateChangePasswordOtpModel.fromJson(response);
  }

  @override
  Future<ChangePasswordModel> changePassword(Map changePasswordMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}common/changepassword", changePasswordMap);
    return ChangePasswordModel.fromJson(response);
  }
}
