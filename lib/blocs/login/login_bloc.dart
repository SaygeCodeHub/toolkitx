import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/models/encrypt_class.dart';
import '../../data/models/login/generate_login_opt_model.dart';
import '../../data/models/login/login_model.dart';
import '../../data/models/login/validate_email_model.dart';
import '../../di/app_module.dart';
import '../../repositories/login/login_repository.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import 'login_events.dart';
import 'login_states.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  final LoginRepository _loginRepository = getIt<LoginRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  String encryptedEmail = '';

  LoginStates get initialState => LoginInitial();

  LoginBloc() : super(LoginInitial()) {
    on<ChangeUserType>(_changeUserType);
    on<ValidateEmail>(_validateEmail);
    on<GenerateLoginOtp>(_generateLoginOtp);
    on<LoginEvent>(_loginEvent);
  }

  FutureOr<void> _changeUserType(
      ChangeUserType event, Emitter<LoginStates> emit) async {
    _customerCache.setUserType(CacheKeys.userType, event.typeValue);
    emit(UserTypeChanged(userType: event.userType, typeValue: event.typeValue));
  }

  FutureOr<void> _validateEmail(
      ValidateEmail event, Emitter<LoginStates> emit) async {
    emit(ValidatingEmail());
    try {
      if (event.email == null || event.email!.trim() == '') {
        emit(ValidateEmailError(message: StringConstants.kValidateEmptyEmail));
      } else {
        encryptedEmail = await EncryptData.encryptAES(event.email!.trim());
        Map validateEmailMap = {'emailaddress': encryptedEmail};
        ValidateEmailModel validateEmailModel =
            await _loginRepository.validateEmail(validateEmailMap);
        if (validateEmailModel.message.isEmpty) {
          emit(ValidateEmailError(
              message: DatabaseUtil.getText('EmailNotAssociatedWithToolkitx')));
        } else {
          if (validateEmailModel.message == '1,2') {
            add(ChangeUserType(userType: 'null', typeValue: ''));
          } else {
            _customerCache.setUserType(
                CacheKeys.userType, validateEmailModel.message);
          }
          emit(EmailValidated(validateEmailModel: validateEmailModel));
        }
      }
    } catch (e) {
      emit(ValidateEmailError(message: e.toString()));
    }
  }

  FutureOr<void> _generateLoginOtp(
      GenerateLoginOtp event, Emitter<LoginStates> emit) async {
    emit(GeneratingOtpLogin());
    try {
      Map generateOtpMap = {'emailaddress': encryptedEmail};
      GenerateLoginOtpModel generateOtpLoginModel =
          await _loginRepository.getOptLogin(generateOtpMap);
      emit(LoginOtpGenerated(generateOtpLoginModel: generateOtpLoginModel));
    } catch (e) {
      emit(GenerateOtpLoginError(message: e.toString()));
    }
  }

  FutureOr<void> _loginEvent(
      LoginEvent event, Emitter<LoginStates> emit) async {
    emit(LoginLoading());
    try {
      String? type = await _customerCache.getUserType(CacheKeys.userType);
      if (event.loginMap['password'] == null ||
          event.loginMap['password'].trim() == '') {
        emit(LoginError(message: DatabaseUtil.getText('emptyOtp')));
      } else if (type!.isEmpty) {
        emit(LoginError(message: StringConstants.kSelectUserTypeValidation));
      } else {
        String password =
            await EncryptData.encryptAES(event.loginMap['password'].trim());
        Map loginMap = {
          'username': encryptedEmail,
          'password': password,
          'type': type
        };
        LoginModel loginModel = await _loginRepository.postLogin(loginMap);
        if (loginModel.status == 200) {
          _customerCache.setIsLoggedIn(CacheKeys.isLoggedIn, true);
          _customerCache.setClientDataKey(
              CacheKeys.clientDataKey, loginModel.message!);
          emit(LoginLoaded(loginModel: loginModel));
        } else {
          emit(LoginError(message: loginModel.message!));
        }
      }
    } catch (e) {
      emit(LoginError(message: e.toString()));
    }
  }
}
