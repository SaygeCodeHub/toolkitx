import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/di/app_module.dart';

import '../../../data/cache/cache_keys.dart';
import '../../../data/cache/customer_cache.dart';
import '../../../data/models/SignInQRCode/sign_in_location_details_model.dart';
import '../../../repositories/SignInQRCode/signin_repository.dart';
import 'sign_in_location_details_event.dart';
import 'sign_in_location_details_states.dart';

class SignInLocationDetailsBloc
    extends Bloc<SignInDetailsEvent, SignInLocationDetailsStates> {
  final SignInRepository _signInRepository = getIt<SignInRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  SignInLocationDetailsBloc() : super(SignInLocationInitialState()) {
    on<FetchSignInLocationDetails>(_fetchLocationDetails);
    on<ToggleSwitchIndex>(_toggleSwitchIndex);
  }

  int indexSelected = 0;

  FutureOr<void> _fetchLocationDetails(FetchSignInLocationDetails event,
      Emitter<SignInLocationDetailsStates> emit) async {
    String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
    String? userId = await _customerCache.getUserId(CacheKeys.userId);
    FetchLocationDetailsSignInModel fetchLocationDetailsSignInModel =
        await _signInRepository.signInLocationDetails(
      hashCode!,
      event.locationId,
      userId!,
    );
    emit(SignInLocationDetailsFetched(
        fetchLocationDetailsSignInModel: fetchLocationDetailsSignInModel));
    add(ToggleSwitchIndex(
        selectedIndex: 0,
        fetchLocationDetailsSignInModel: fetchLocationDetailsSignInModel));
  }

  _toggleSwitchIndex(
      ToggleSwitchIndex event, Emitter<SignInLocationDetailsStates> emit) {
    indexSelected = event.selectedIndex;
    emit(SignInLocationDetailsFetched(
        fetchLocationDetailsSignInModel: event.fetchLocationDetailsSignInModel,
        selectedIndex: event.selectedIndex));
  }
}
