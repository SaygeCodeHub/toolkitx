import 'package:equatable/equatable.dart';

import '../../../data/models/SignInQRCode/sign_in_location_details_model.dart';

abstract class SignInDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchSignInLocationDetails extends SignInDetailsEvent {
  final String locationId;

  FetchSignInLocationDetails({required this.locationId});
}

class ToggleSwitchIndex extends SignInDetailsEvent {
  final int selectedIndex;
  final FetchLocationDetailsSignInModel fetchLocationDetailsSignInModel;

  ToggleSwitchIndex(
      {required this.selectedIndex,
      required this.fetchLocationDetailsSignInModel});

  @override
  List<Object?> get props => [selectedIndex];
}
