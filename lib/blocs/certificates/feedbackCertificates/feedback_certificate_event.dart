abstract class FeedbackCertificateEvent {}

class FetchFeedbackCertificate extends FeedbackCertificateEvent {
  final String certificateId;

  FetchFeedbackCertificate({required this.certificateId});
}

class SaveCertificateFeedback extends FeedbackCertificateEvent {
  final String certificateId;
  final List feedbackAnswerList;

  SaveCertificateFeedback(
      {required this.certificateId, required this.feedbackAnswerList});
}
