part of 'sign_in_list_bloc.dart';

abstract class SignInListState {}

class SignInListInitial extends SignInListState {}

class FetchingSignInList extends SignInListState {}

class SignInListFetched extends SignInListState {
  final FetchCurrentSignInModel currentSignInListModel;
  SignInListFetched({required this.currentSignInListModel});
}

class SignInListError extends SignInListState {
  final String error;

  SignInListError(this.error);

  List<Object> get props => [error];
}
