part of 'sign_in_process_bloc.dart';

abstract class SignInProcessEvent {}

class SignInProcess extends SignInProcessEvent {
  final String? qRCode;

  SignInProcess({required this.qRCode});
}

class UnauthorizedSignIn extends SignInProcessEvent {
  final String qRCode;

  UnauthorizedSignIn({required this.qRCode});
}

class ProcessSignOut extends SignInProcessEvent {
  final String qRCode;

  ProcessSignOut({required this.qRCode});
}
