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


class FetchingGetNotesCertificate extends StartCourseCertificateState {}

class GetNotesCertificateFetched extends StartCourseCertificateState {
  final FetchGetNotesModel fetchGetNotesModel;
  GetNotesCertificateFetched({
    required this.fetchGetNotesModel,
  });
}

class GetNotesCertificateError extends StartCourseCertificateState {
  final String getNotesError;

  GetNotesCertificateError({required this.getNotesError});
}


class UserTrackUpdating extends StartCourseCertificateState {}

class UserTrackUpdated extends StartCourseCertificateState {
  final UpdateUserTrackModel updateUserTrackModel;
  UserTrackUpdated({
    required this.updateUserTrackModel,
  });
}

class UserTrackUpdateError extends StartCourseCertificateState {
  final String error;

  UserTrackUpdateError({required this.error});
}
