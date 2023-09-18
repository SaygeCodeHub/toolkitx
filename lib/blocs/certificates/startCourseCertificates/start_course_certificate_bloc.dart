import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/models/certificates/get_course_certificate_model.dart';

import '../../../data/cache/cache_keys.dart';
import '../../../data/cache/customer_cache.dart';
import '../../../data/models/certificates/get_topic_certificate_model.dart';
import '../../../data/models/certificates/get_workforce_quiz_model.dart';
import '../../../di/app_module.dart';
import '../../../repositories/certificates/certificates_repository.dart';

part 'start_course_certificate_event.dart';
part 'start_course_certificate_state.dart';

class StartCourseCertificateBloc
    extends Bloc<StartCourseCertificateEvent, StartCourseCertificateState> {
  final CertificateRepository _certificateRepository =
      getIt<CertificateRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  StartCourseCertificateState get initialState =>
      StartCourseCertificateInitial();

  StartCourseCertificateBloc() : super(StartCourseCertificateInitial()) {
    on<GetCourseCertificate>(_getCourseCertificate);
    on<GetTopicCertificate>(_getTopicCertificate);
    on<GetWorkforceQuiz>(_getWorkforceQuiz);
  }

  Future<FutureOr<void>> _getCourseCertificate(GetCourseCertificate event,
      Emitter<StartCourseCertificateState> emit) async {
    emit(FetchingGetCourseCertificate());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
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
      if (getTopicCertificateModel.status == 200) {
        emit(GetTopicCertificateFetched(
            getTopicCertificateModel: getTopicCertificateModel));
      }
    } catch (e) {
      emit(GetTopicCertificateError(getTopicError: e.toString()));
    }
  }

  Future<FutureOr<void>> _getWorkforceQuiz(
      GetWorkforceQuiz event, Emitter<StartCourseCertificateState> emit) async {
    emit(GetWorkforceQuizFetching());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);

      GetWorkforceQuizModel getWorkforceQuizModel = await _certificateRepository
          .getWorkforceQuiz(hashCode!, userId!, event.quizId);
      if (getWorkforceQuizModel.status == 200) {
        emit(GetWorkforceQuizFetched(
            getWorkforceQuizModel: getWorkforceQuizModel));
      }
    } catch (e) {
      emit(GetCourseCertificateError(getCourseError: e.toString()));
    }
  }
}
