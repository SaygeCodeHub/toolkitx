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

class GetNotesCertificate extends StartCourseCertificateEvent {
  final String topicId;
  final int pageNo;

  GetNotesCertificate({
    required this.topicId,
    required this.pageNo,
  });
}

class UpdateUserTrack extends StartCourseCertificateEvent {
  final String certificateId;
  final String noteId;
  final String idm;

  UpdateUserTrack(
      {required this.certificateId, required this.noteId, required this.idm});
}
