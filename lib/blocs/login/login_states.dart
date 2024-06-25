import 'package:equatable/equatable.dart';
import 'package:toolkit/data/models/login/generate_login_opt_model.dart';
import 'package:toolkit/data/models/login/login_model.dart';

import '../../data/models/login/validate_email_model.dart';

abstract class LoginStates extends Equatable {}

class LoginInitial extends LoginStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class UserTypeChanged extends LoginStates {
  final String userType;
  final String typeValue;

  UserTypeChanged({required this.userType, required this.typeValue});

  @override
  List<Object?> get props => [userType];
}

class ValidatingEmail extends LoginStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class EmailValidated extends LoginStates {
  final ValidateEmailModel validateEmailModel;

  EmailValidated({required this.validateEmailModel});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class ValidateEmailError extends LoginStates {
  final String message;

  ValidateEmailError({required this.message});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class GeneratingOtpLogin extends LoginStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoginOtpGenerated extends LoginStates {
  final GenerateLoginOtpModel generateOtpLoginModel;

  LoginOtpGenerated({required this.generateOtpLoginModel});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class GenerateOtpLoginError extends LoginStates {
  final String message;

  GenerateOtpLoginError({required this.message});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoginLoading extends LoginStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoginLoaded extends LoginStates {
  final LoginModel loginModel;

  LoginLoaded({required this.loginModel});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoginError extends LoginStates {
  final String message;

  LoginError({required this.message});

  @override
  List<Object?> get props => throw UnimplementedError();
}
