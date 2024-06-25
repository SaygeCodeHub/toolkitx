import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/profile/profile_events.dart';
import 'package:toolkit/blocs/profile/profile_states.dart';
import 'package:toolkit/data/enums/user_type_emun.dart';
import 'package:toolkit/data/models/encrypt_class.dart';
import 'package:toolkit/data/models/profile/change_password_model.dart';
import 'package:toolkit/data/models/profile/generate_change_password_opt_model.dart';
import 'package:toolkit/data/models/profile/user_profile_model.dart';
import 'package:toolkit/repositories/profile/profile_repository.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/models/profile/update_user_profile_model.dart';
import '../../di/app_module.dart';

class ProfileBloc extends Bloc<ProfileEvents, ProfileStates> {
  final ProfileRepository _profileRepository = getIt<ProfileRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  Map profileDataMap = {};
  Map updateProfileDataMap = {};

  ProfileStates get initialState => ProfileInitial();

  ProfileBloc() : super(ProfileInitial()) {
    on<FetchUserProfile>(_fetchUserProfile);
    on<UpdateProfile>(_updateProfile);
    on<DecryptUserProfileData>(_decryptUserProfileData);
    on<InitializeEditUserProfile>(_initializeEditUserProfile);
    on<ChangePasswordType>(_changePasswordType);
    on<GenerateChangePasswordOtp>(_generateChangePasswordOtp);
    on<ChangePassword>(_changePassword);
    on<CheckChangePasswordType>(_checkChangePasswordType);
    on<Logout>(_logOut);
  }

  FutureOr<void> _fetchUserProfile(
      FetchUserProfile event, Emitter<ProfileStates> emit) async {
    emit(UserProfileFetching());
    try {
      String? userName = await _customerCache.getUserName(CacheKeys.userName);
      String typeValue =
          (await _customerCache.getUserType(CacheKeys.userType))!;
      String userType = UserType.values
          .elementAt(UserType.values
              .indexWhere((element) => element.value == typeValue))
          .type;
      if (userName == null) {
        String hashCode =
            (await _customerCache.getHashCode(CacheKeys.hashcode))!;
        UserProfileModel userProfileModel =
            await _profileRepository.fetchUserProfile(hashCode);
        if (userProfileModel.status == 200) {
          profileDataMap = userProfileModel.data!.toJson();
          _customerCache.setUserName(CacheKeys.userName,
              '${userProfileModel.data!.fname} ${userProfileModel.data!.lname}');
          emit(UserProfileFetched(
              userType: userType,
              userName:
                  '${userProfileModel.data!.fname} ${userProfileModel.data!.lname}'));
        } else {
          emit(UserProfileFetchError());
        }
      } else {
        emit(UserProfileFetched(userType: userType, userName: userName));
      }
    } catch (e) {
      emit(UserProfileFetchError());
    }
  }

  FutureOr<void> _decryptUserProfileData(
      DecryptUserProfileData event, Emitter<ProfileStates> emit) async {
    emit(EditProfileInitializing());
    try {
      if (profileDataMap.isEmpty) {
        String hashCode =
            (await _customerCache.getHashCode(CacheKeys.hashcode))!;
        UserProfileModel userProfileModel =
            await _profileRepository.fetchUserProfile(hashCode);
        if (userProfileModel.status == 200) {
          _customerCache.setUserName(CacheKeys.userName,
              '${userProfileModel.data!.fname} ${userProfileModel.data!.lname}');
          Map decryptedDataMap = userProfileModel.data!.toJson();
          String bloodGroupDecrypt = '';
          String contactDecrypt = '';
          String privateKey =
              (await _customerCache.getApiKey(CacheKeys.apiKey))!;
          if (userProfileModel.data!.bloodgrp.toString() != '') {
            bloodGroupDecrypt = await EncryptData.decryptAESPrivateKey(
                userProfileModel.data!.bloodgrp, privateKey);
          }
          if (userProfileModel.data!.contact.toString() != '') {
            contactDecrypt = await EncryptData.decryptAESPrivateKey(
                userProfileModel.data!.contact, privateKey);
          }
          decryptedDataMap['bloodgrp'] = bloodGroupDecrypt;
          decryptedDataMap['contact'] = contactDecrypt;
          updateProfileDataMap = decryptedDataMap;

          add(InitializeEditUserProfile(profileDetailsMap: decryptedDataMap));
        } else {
          emit(EditProfileError(
              errorMessage:
                  DatabaseUtil.getText('some_unknown_error_please_try_again')));
        }
      } else {
        Map decryptedDataMap = Map.from(profileDataMap);
        String bloodGroupDecrypt = '';
        String contactDecrypt = '';
        String privateKey = (await _customerCache.getApiKey(CacheKeys.apiKey))!;
        if (profileDataMap['bloodgrp'].toString() != '') {
          bloodGroupDecrypt = await EncryptData.decryptAESPrivateKey(
              profileDataMap['bloodgrp'], privateKey);
        }
        if (profileDataMap['contact'].toString() != '') {
          contactDecrypt = await EncryptData.decryptAESPrivateKey(
              profileDataMap['contact'], privateKey);
        }
        decryptedDataMap['bloodgrp'] = bloodGroupDecrypt;
        decryptedDataMap['contact'] = contactDecrypt;
        updateProfileDataMap = decryptedDataMap;

        add(InitializeEditUserProfile(profileDetailsMap: decryptedDataMap));
      }
    } catch (e) {
      emit(EditProfileError(
          errorMessage:
              DatabaseUtil.getText('some_unknown_error_please_try_again')));
    }
  }

  FutureOr<void> _initializeEditUserProfile(
      InitializeEditUserProfile event, Emitter<ProfileStates> emit) async {
    emit(EditProfileInitialized(profileDetailsMap: event.profileDetailsMap));
    profileDataMap.clear();
  }

  FutureOr<void> _updateProfile(
      UpdateProfile event, Emitter<ProfileStates> emit) async {
    emit(UserProfileUpdating());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      String contactEncrypt = '';
      String bloodGroupEncrypt = '';
      String privateKey = (await _customerCache.getApiKey(CacheKeys.apiKey))!;
      if (event.updateProfileMap['bloodgrp'].toString() != '') {
        bloodGroupEncrypt = EncryptData.encryptAESPrivateKey(
            event.updateProfileMap['bloodgrp'], privateKey);
      }
      if (event.updateProfileMap['contact'].toString() != '' ||
          event.updateProfileMap['contact'].isNotEmpty) {
        contactEncrypt = await EncryptData.encryptAESPrivateKey(
            event.updateProfileMap['contact'].trim(), privateKey);
      }
      if (event.updateProfileMap['fname'].toString().trim() == '') {
        emit(UserProfileUpdateError(
            message: StringConstants.kFirstNameValidate));
      } else if (event.updateProfileMap['lname'].toString().trim() == '') {
        emit(
            UserProfileUpdateError(message: StringConstants.kLastNameValidate));
      } else if (event.updateProfileMap['contact'].toString() == '' ||
          event.updateProfileMap['contact'].isEmpty) {
        emit(UserProfileUpdateError(message: StringConstants.kContactValidate));
      } else {
        Map updateUserProfileMap = {
          'hashcode': hashCode,
          'fname': event.updateProfileMap['fname'].toString().trim(),
          'lname': event.updateProfileMap['lname'].toString().trim(),
          'contact': contactEncrypt,
          'contact2': event.updateProfileMap['contact2'].trim(),
          'bloodgrp': bloodGroupEncrypt,
          'sign': event.updateProfileMap['sign'].trim()
        };
        UpdateUserProfileModel updateUserProfileModel =
            await _profileRepository.updateUserProfile(updateUserProfileMap);
        if (updateUserProfileModel.status == 200) {
          _customerCache.setUserName(CacheKeys.userName,
              '${event.updateProfileMap['fname'].trim()} ${event.updateProfileMap['lname'].trim()}');
          emit(UserProfileUpdated(
              updateUserProfileModel: updateUserProfileModel));
        } else {
          emit(UserProfileUpdateError(
              message:
                  DatabaseUtil.getText('some_unknown_error_please_try_again')));
        }
      }
    } catch (e) {
      emit(UserProfileUpdateError());
    }
  }

  _changePasswordType(ChangePasswordType event, Emitter<ProfileStates> emit) {
    emit(
        ChangePasswordTypeLoaded(changePasswordType: event.changePasswordType));
  }

  _checkChangePasswordType(
      CheckChangePasswordType event, Emitter<ProfileStates> emit) {
    emit(ChangePasswordTypeChecked(changePasswordOtp: event.changePasswordOtp));
  }

  FutureOr<void> _generateChangePasswordOtp(
      GenerateChangePasswordOtp event, Emitter<ProfileStates> emit) async {
    emit(GeneratingChangePasswordOtp());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      String userId = (await _customerCache.getUserId(CacheKeys.userId))!;
      Map generateOtpMap = {"hashcode": hashCode, "userid": userId};
      GenerateChangePasswordOtpModel generateChangePasswordOtpModel =
          await _profileRepository.generateOtp(generateOtpMap);
      emit(ChangePasswordOtpGenerated(
          generateChangePasswordOtpModel: generateChangePasswordOtpModel));
    } catch (e) {
      emit(ChangePasswordOtpError());
    }
  }

  FutureOr<void> _changePassword(
      ChangePassword event, Emitter<ProfileStates> emit) async {
    emit(PasswordChanging());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      String userId = (await _customerCache.getUserId(CacheKeys.userId))!;
      String privateKey = (await _customerCache.getApiKey(CacheKeys.apiKey))!;
      if (event.changePasswordMap['oldPass_opt'].toString().trim() == 'null') {
        emit(ChangePasswordError(message: DatabaseUtil.getText('emptyOtp')));
      } else if (event.changePasswordMap['newPassword'].toString().trim() ==
          'null') {
        emit(
            ChangePasswordError(message: StringConstants.kValidateNewPassword));
      } else if (event.changePasswordMap['confirmPassword'].toString().trim() ==
          'null') {
        emit(ChangePasswordError(
            message: StringConstants.kValidateConfirmPassword));
      } else if (event.changePasswordMap['newPassword'].toString().trim() !=
          event.changePasswordMap['confirmPassword'].toString().trim()) {
        emit(ChangePasswordError(
            message: StringConstants.kValidatePasswordMatch));
      } else {
        String newPassword = await EncryptData.encryptAESPrivateKey(
            event.changePasswordMap['newPassword'].toString().trim(),
            privateKey);
        String oldPassword = await EncryptData.encryptAESPrivateKey(
            event.changePasswordMap['oldPass_opt'], privateKey);
        Map changePasswordMap = {
          "hashcode": hashCode,
          "newpassword": newPassword,
          "oldpassword": oldPassword,
          "userid": userId
        };
        ChangePasswordModel changePasswordModel =
            await _profileRepository.changePassword(changePasswordMap);
        if (changePasswordModel.status == 200) {
          emit(PasswordChanged(changePasswordModel: changePasswordModel));
        } else {
          emit(ChangePasswordError(message: changePasswordModel.message!));
        }
      }
    } catch (e) {
      emit(ChangePasswordError(message: e.toString()));
    }
  }

  FutureOr<void> _logOut(Logout event, Emitter<ProfileStates> emit) async {
    _customerCache.clearAll();
    DatabaseUtil.box.clear();
    emit(LoggedOut());
  }
}
