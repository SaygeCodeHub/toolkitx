part of 'sign_in_process_bloc.dart';

abstract class SignInProcessState {}

class SignInProcessInitial extends SignInProcessState {}

class SignInProcessing extends SignInProcessState {}

class SignInProcessed extends SignInProcessState {
  final ProcessSignInModel processSignInModel;

  SignInProcessed({required this.processSignInModel});
}

class SignInProcessingError extends SignInProcessState {
  final String errorMsg;

  SignInProcessingError({required this.errorMsg});
}

class SignInUnauthorizedPop extends SignInProcessState {}

class SignInUnauthorizedProcessing extends SignInProcessState {}

class SignInUnauthorized extends SignInProcessState {
  final SignInUnathorizedModel signInUnathorizedModel;

  SignInUnauthorized({required this.signInUnathorizedModel});
}

class SignInUnathorizedError extends SignInProcessState {
  final String errorMsg;

  SignInUnathorizedError({required this.errorMsg});
}

class SignOutProcessing extends SignInProcessState {}

class SignOutProcessed extends SignInProcessState {}

class SignOutNotProcessed extends SignInProcessState {
  final String errorMsg;

  SignOutNotProcessed({required this.errorMsg});
}
