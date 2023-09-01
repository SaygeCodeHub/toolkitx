import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/models/SignInQRCode/current_signin_model.dart';
import 'package:toolkit/di/app_module.dart';

import '../../../data/cache/cache_keys.dart';
import '../../../data/cache/customer_cache.dart';
import '../../../repositories/SignInQRCode/signin_repository.dart';

part 'sign_in_list_event.dart';
part 'sign_in_list_state.dart';

class SignInListBloc extends Bloc<SignInList, SignInListState> {
  final SignInRepository _signInRepository = getIt<SignInRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  SignInListBloc() : super(FetchingSignInList()) {
    on<SignInList>(_fetchSignInList);
  }

  FutureOr<void> _fetchSignInList(
      SignInList event, Emitter<SignInListState> emit) async {
    emit(FetchingSignInList());
    String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
    String? userId = await _customerCache.getUserId(CacheKeys.userId);
    FetchCurrentSignInModel currentSignInListModel =
        await _signInRepository.signInList(userId!, hashCode!);
    emit(SignInListFetched(currentSignInListModel: currentSignInListModel));
  }
}
