import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/data/models/SignInQRCode/process_singin_model.dart';
import 'package:toolkit/data/models/SignInQRCode/signin_unathorized_model.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../data/cache/customer_cache.dart';
import '../../../di/app_module.dart';
import '../../../repositories/SignInQRCode/signin_repository.dart';

part 'sign_in_process_event.dart';

part 'sign_in_process_state.dart';

class SignInProcessBloc extends Bloc<SignInProcessEvent, SignInProcessState> {
  final SignInRepository _signInRepository = getIt<SignInRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  SignInProcessState get initialState => SignInProcessInitial();

  SignInProcessBloc() : super(SignInProcessInitial()) {
    on<SignInProcess>(_processSignInProcess);
    on<UnauthorizedSignIn>(_signInUnathorized);
  }

  Future<FutureOr<void>> _processSignInProcess(
      SignInProcess event, Emitter<SignInProcessState> emit) async {
    emit(SignInProcessing());
    String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
    String? userid = await _customerCache.getUserId(CacheKeys.userId);
    if (event.qRCode == null || event.qRCode!.isEmpty) {
      emit((SignInProcessingError(errorMsg: StringConstants.kQRError)));
    } else {
      Map signInMap = {
        "userid": userid,
        "qrcode": event.qRCode,
        "hashcode": hashCode
      };
      ProcessSignInModel processSignInModel =
          await _signInRepository.processSignIn(signInMap);
      if (processSignInModel.message == '1') {
        emit(SignInUnauthorizedPop());
      } else {
        emit(SignInProcessed(processSignInModel: processSignInModel));
      }
    }
  }

  Future<FutureOr<void>> _signInUnathorized(
      UnauthorizedSignIn event, Emitter<SignInProcessState> emit) async {
    emit(SignInUnauthorizedProcessing());
    String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
    String? userid = await _customerCache.getUserId(CacheKeys.userId);
    if (event.qRCode.isEmpty) {
      emit(SignInUnathorizedError(errorMsg: StringConstants.kQRError));
    } else {
      Map unathorizedSingInMap = {
        "userid": userid,
        "qrcode": event.qRCode,
        "hashcode": hashCode
      };
      SignInUnathorizedModel signInUnathorizedModel =
          await _signInRepository.unathorizedSignIn(unathorizedSingInMap);
      if (signInUnathorizedModel.status == 200) {
        emit(
            SignInUnauthorized(signInUnathorizedModel: signInUnathorizedModel));
      } else {
        emit(SignInUnathorizedError(errorMsg: StringConstants.kQRError));
      }
    }
  }
}
