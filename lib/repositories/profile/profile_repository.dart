import 'package:toolkit/data/models/profile/change_password_model.dart';
import 'package:toolkit/data/models/profile/generate_change_password_opt_model.dart';
import 'package:toolkit/data/models/profile/update_user_profile_model.dart';
import 'package:toolkit/data/models/profile/user_profile_model.dart';

abstract class ProfileRepository {
  Future<UserProfileModel> fetchUserProfile(String hashCode);

  Future<UpdateUserProfileModel> updateUserProfile(Map updateUserProfileMap);

  Future<GenerateChangePasswordOtpModel> generateOtp(Map generateOtpMap);

  Future<ChangePasswordModel> changePassword(Map changePasswordMap);
}
