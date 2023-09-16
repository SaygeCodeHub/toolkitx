import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/models/certificates/feedback_certificate_model.dart';

import '../../../data/cache/cache_keys.dart';
import '../../../data/cache/customer_cache.dart';
import '../../../di/app_module.dart';
import '../../../repositories/certificates/certificates_repository.dart';
import 'feedback_certificate_event.dart';
import 'feedback_certificate_state.dart';

class FeedbackCertificateBloc
    extends Bloc<FeedbackCertificateEvent, FeedbackCertificateState> {
  final CertificateRepository _certificateRepository =
      getIt<CertificateRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  FeedbackCertificateState get initialState => FeedbackCertificateInitial();
  FeedbackCertificateBloc() : super(FeedbackCertificateInitial()) {
    on<FetchFeedbackCertificate>(_feedbackCertificate);
  }

  Future<FutureOr<void>> _feedbackCertificate(FetchFeedbackCertificate event,
      Emitter<FeedbackCertificateState> emit) async {
    emit(FeedbackCertificateFetching());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      FeedbackCertificateModel feedbackCertificateModel =
          await _certificateRepository.feedbackCertificate(
              hashCode!, userId!, event.certificateId);
      if (feedbackCertificateModel.status == 200) {
        emit(FeedbackCertificateFetched(
            feedbackCertificateModel: feedbackCertificateModel));
      }
    } catch (e) {
      emit(FeedbackCertificateError(e.toString()));
    }
  }
}
