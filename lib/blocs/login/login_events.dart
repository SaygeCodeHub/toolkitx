abstract class LoginEvents {}

class ChangeUserType extends LoginEvents {
  final String userType;
  final String typeValue;

  ChangeUserType({required this.typeValue, required this.userType});
}

class ValidateEmail extends LoginEvents {
  final String? email;

  ValidateEmail({required this.email});
}

class GenerateLoginOtp extends LoginEvents {}

class LoginEvent extends LoginEvents {
  final Map loginMap;

  LoginEvent({required this.loginMap});
}
