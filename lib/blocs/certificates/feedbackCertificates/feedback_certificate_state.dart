
import 'package:toolkit/data/models/certificates/feedback_certificate_model.dart';

abstract class FeedbackCertificateState{}

class FeedbackCertificateInitial extends FeedbackCertificateState{}

class FeedbackCertificateFetching extends FeedbackCertificateState{}

class FeedbackCertificateFetched extends FeedbackCertificateState{
  final FeedbackCertificateModel feedbackCertificateModel;

  FeedbackCertificateFetched({required this.feedbackCertificateModel});
}

class FeedbackCertificateError extends FeedbackCertificateState{
  final String feedbackError;
  FeedbackCertificateError(this.feedbackError);
}