import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/data/models/SignInQRCode/process_sign_out_model.dart';
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
    on<UnauthorizedSignIn>(_signInUnauthorized);
    on<ProcessSignOut>(_processSignOut);
  }
  String qrCode = '';

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
      qrCode = event.qRCode!;
      ProcessSignInModel processSignInModel =
          await _signInRepository.processSignIn(signInMap);
      if (processSignInModel.status == 200) {
        if (processSignInModel.message != '1') {
          emit(SignInUnauthorizedPop());
        } else {
          emit(SignInProcessed(processSignInModel: processSignInModel));
        }
      } else {
        emit(SignInProcessed(processSignInModel: processSignInModel));
      }
    }
  }

  Future<FutureOr<void>> _signInUnauthorized(
      UnauthorizedSignIn event, Emitter<SignInProcessState> emit) async {
    emit(SignInUnauthorizedProcessing());
    String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
    String? userid = await _customerCache.getUserId(CacheKeys.userId);
    if (event.qRCode.isEmpty) {
      emit(SignInUnathorizedError(errorMsg: StringConstants.kQRError));
    } else {
      Map unauthorizedSingInMap = {
        "userid": userid,
        "qrcode": event.qRCode,
        "hashcode": hashCode
      };
      SignInUnathorizedModel signInUnauthorizedModel =
          await _signInRepository.unathorizedSignIn(unauthorizedSingInMap);
      if (qrCode == event.qRCode) {
        if (signInUnauthorizedModel.status == 200) {
          emit(SignInUnauthorized(
              signInUnathorizedModel: signInUnauthorizedModel));
        }
      } else {
        emit(SignInUnathorizedError(errorMsg: StringConstants.kQRError));
      }
    }
  }

  Future<FutureOr<void>> _processSignOut(
      ProcessSignOut event, Emitter<SignInProcessState> emit) async {
    emit(SignOutProcessing());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userid = await _customerCache.getUserId(CacheKeys.userId);
      Map processSignOutMap = {
        "userid": userid,
        "qrcode": event.qRCode,
        "hashcode": hashCode
      };
      ProcessSignOutModel processSignOutModel =
          await _signInRepository.processSignOut(processSignOutMap);
      if (qrCode == event.qRCode) {
        if (processSignOutModel.status == 200) {
          emit(SignOutProcessed());
        }
      } else {
        emit(SignOutNotProcessed(errorMsg: processSignOutModel.message));
      }
    } catch (e) {
      emit(SignOutNotProcessed(errorMsg: e.toString()));
    }
  }
}
