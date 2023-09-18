abstract class FeedbackCertificateEvent {}

class FetchFeedbackCertificate extends FeedbackCertificateEvent {
  final String certificateId;
  FetchFeedbackCertificate({required this.certificateId});
}
