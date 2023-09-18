part of 'start_course_certificate_bloc.dart';

abstract class StartCourseCertificateEvent {}

class GetCourseCertificate extends StartCourseCertificateEvent {
  final String certificateId;

  GetCourseCertificate({required this.certificateId});
}

class GetTopicCertificate extends StartCourseCertificateEvent {
  final String courseId;

  GetTopicCertificate({required this.courseId});
}

class GetWorkforceQuiz extends StartCourseCertificateEvent {
  final String quizId;

  GetWorkforceQuiz({required this.quizId});
}
