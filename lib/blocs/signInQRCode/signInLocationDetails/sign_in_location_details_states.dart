import 'package:equatable/equatable.dart';

import '../../../data/models/SignInQRCode/sign_in_location_details_model.dart';

abstract class SignInLocationDetailsStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignInLocationInitialState extends SignInLocationDetailsStates {}

class SignInLocationDetailsFetched extends SignInLocationDetailsStates {
  final FetchLocationDetailsSignInModel fetchLocationDetailsSignInModel;
  final int? selectedIndex;

  SignInLocationDetailsFetched(
      {this.selectedIndex, required this.fetchLocationDetailsSignInModel});

  @override
  List<Object?> get props => [selectedIndex];
}

class SignInLocationNotFetched extends SignInLocationDetailsStates {
  final String detailsNotFetched;

  SignInLocationNotFetched({required this.detailsNotFetched});
}
