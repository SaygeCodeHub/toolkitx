import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/models/certificates/get_course_certificate_model.dart';
import 'package:toolkit/data/models/certificates/update_user_track_model.dart';

import '../../../data/cache/cache_keys.dart';
import '../../../data/cache/customer_cache.dart';
import '../../../data/models/certificates/get_notes_certificate_model.dart';
import '../../../data/models/certificates/get_topic_certificate_model.dart';
import '../../../di/app_module.dart';
import '../../../repositories/certificates/certificates_repository.dart';

part 'start_course_certificate_event.dart';
part 'start_course_certificate_state.dart';

class StartCourseCertificateBloc
    extends Bloc<StartCourseCertificateEvent, StartCourseCertificateState> {
  final CertificateRepository _certificateRepository =
      getIt<CertificateRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  String certificateId = '';
  StartCourseCertificateState get initialState =>
      StartCourseCertificateInitial();

  StartCourseCertificateBloc() : super(StartCourseCertificateInitial()) {
    on<GetCourseCertificate>(_getCourseCertificate);
    on<GetTopicCertificate>(_getTopicCertificate);
    on<GetNotesCertificate>(_getNotesCertificate);
    on<UpdateUserTrack>(_updateUserTrack);
  }

  Future<FutureOr<void>> _getCourseCertificate(GetCourseCertificate event,
      Emitter<StartCourseCertificateState> emit) async {
    emit(FetchingGetCourseCertificate());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      certificateId = event.certificateId;
      GetCourseCertificateModel getCourseCertificateModel =
          await _certificateRepository.getCourseCertificates(
              hashCode!, event.certificateId);
      if (getCourseCertificateModel.status == 200) {
        emit(GetCourseCertificateFetched(
          getCourseCertificateModel: getCourseCertificateModel,
        ));
      }
    } catch (e) {
      emit(GetCourseCertificateError(getCourseError: e.toString()));
    }
  }

  Future<FutureOr<void>> _getTopicCertificate(GetTopicCertificate event,
      Emitter<StartCourseCertificateState> emit) async {
    emit(FetchingGetTopicCertificate());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      GetTopicCertificateModel getTopicCertificateModel =
          await _certificateRepository.getTopicCertificates(
              hashCode!, userId!, event.courseId);
      log('courseId==============>${event.courseId}');
      if (getTopicCertificateModel.status == 200) {
        emit(GetTopicCertificateFetched(
            getTopicCertificateModel: getTopicCertificateModel));
      }
    } catch (e) {
      emit(GetTopicCertificateError(getTopicError: e.toString()));
    }
  }

  Future<FutureOr<void>> _getNotesCertificate(GetNotesCertificate event,
      Emitter<StartCourseCertificateState> emit) async {
    emit(FetchingGetNotesCertificate());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      FetchGetNotesModel fetchGetNotesModel =
          await _certificateRepository.getNotesCertificates(
              hashCode!, userId!, event.topicId, event.pageNo);
      if (fetchGetNotesModel.status == 200) {
        emit(
            GetNotesCertificateFetched(fetchGetNotesModel: fetchGetNotesModel));
      }
    } catch (e) {
      emit(GetNotesCertificateError(getNotesError: e.toString()));
    }
  }

  Future<FutureOr<void>> _updateUserTrack(
      UpdateUserTrack event, Emitter<StartCourseCertificateState> emit) async {
    emit(UserTrackUpdating());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userid = await _customerCache.getUserId(CacheKeys.userId);

      Map userTrackMap = {
        "idm": event.idm,
        "hashcode": hashCode,
        "workforceid": userid,
        "noteid": event.noteId,
        "certificateid": event.certificateId
      };

      UpdateUserTrackModel updateUserTrackModel =
          await _certificateRepository.updateUserTrackRepo(userTrackMap);
      if (updateUserTrackModel.status == 200) {
        emit(UserTrackUpdated(updateUserTrackModel: updateUserTrackModel));
      }
    } catch (e) {
      emit(UserTrackUpdateError(error: e.toString()));
    }
  }
}
