abstract class ProfileEvents {}

class FetchUserProfile extends ProfileEvents {}

class UpdateProfile extends ProfileEvents {
  final Map updateProfileMap;

  UpdateProfile({required this.updateProfileMap});
}

class GenerateChangePasswordOtp extends ProfileEvents {}

class DecryptUserProfileData extends ProfileEvents {}

class InitializeEditUserProfile extends ProfileEvents {
  Map profileDetailsMap;

  InitializeEditUserProfile({required this.profileDetailsMap});
}

class ChangePassword extends ProfileEvents {
  final Map changePasswordMap;

  ChangePassword({required this.changePasswordMap});
}

class ChangePasswordType extends ProfileEvents {
  final String changePasswordType;

  ChangePasswordType({required this.changePasswordType});
}

class CheckChangePasswordType extends ProfileEvents {
  final bool changePasswordOtp;

  CheckChangePasswordType({required this.changePasswordOtp});
}

class Logout extends ProfileEvents {}
