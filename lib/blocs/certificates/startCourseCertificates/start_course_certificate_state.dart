part of 'start_course_certificate_bloc.dart';

abstract class StartCourseCertificateState {}

class StartCourseCertificateInitial extends StartCourseCertificateState {}

class FetchingGetCourseCertificate extends StartCourseCertificateState {}

class GetCourseCertificateFetched extends StartCourseCertificateState {
  final GetCourseCertificateModel getCourseCertificateModel;
  GetCourseCertificateFetched({
    required this.getCourseCertificateModel,
  });
}

class GetCourseCertificateError extends StartCourseCertificateState {
  final String getCourseError;

  GetCourseCertificateError({required this.getCourseError});
}

class FetchingGetTopicCertificate extends StartCourseCertificateState {}

class GetTopicCertificateFetched extends StartCourseCertificateState {
  final GetTopicCertificateModel getTopicCertificateModel;
  GetTopicCertificateFetched({
    required this.getTopicCertificateModel,
  });
}

class GetTopicCertificateError extends StartCourseCertificateState {
  final String getTopicError;

  GetTopicCertificateError({required this.getTopicError});
}

class WorkforceQuizFetching extends StartCourseCertificateState {}

class WorkforceQuizFetched extends StartCourseCertificateState {
  final GetWorkforceQuizModel getWorkforceQuizModel;
  WorkforceQuizFetched({required this.getWorkforceQuizModel});
}

class WorkforceQuizError extends StartCourseCertificateState {
  final String getError;

  WorkforceQuizError({required this.getError});
}
