import 'package:toolkit/data/models/certificates/feedback_certificate_model.dart';

abstract class FeedbackCertificateState {}

class FeedbackCertificateInitial extends FeedbackCertificateState {}

class FeedbackCertificateFetching extends FeedbackCertificateState {}

class FeedbackCertificateFetched extends FeedbackCertificateState {
  final FeedbackCertificateModel feedbackCertificateModel;

  FeedbackCertificateFetched({required this.feedbackCertificateModel});
}

class FeedbackCertificateError extends FeedbackCertificateState {
  final String feedbackError;
  FeedbackCertificateError(this.feedbackError);
}

class CertificateFeedbackSaving extends FeedbackCertificateState {}

class CertificateFeedbackSaved extends FeedbackCertificateState {}

class CertificateFeedbackNotSaved extends FeedbackCertificateState {
  final String getError;

  CertificateFeedbackNotSaved({required this.getError});
}
