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

class GetWorkforceQuiz extends StartCourseCertificateEvent {
  final String quizId;

  GetWorkforceQuiz({required this.quizId});
}

class GetQuizQuestions extends StartCourseCertificateEvent {
  final String workforcequizId;
  final int pageNo;

  GetQuizQuestions({required this.workforcequizId, required this.pageNo});
}

class SelectedQuizAnswerEvent extends StartCourseCertificateEvent {
  final String answerId;
  final GetQuizQuestionsModel getQuizQuestionsModel;
  SelectedQuizAnswerEvent(
      {required this.answerId, required this.getQuizQuestionsModel});
}

class SaveQuizQuestionAnswer extends StartCourseCertificateEvent {
  final Map questionAnswerMap;
  SaveQuizQuestionAnswer({required this.questionAnswerMap});
}

class SubmitCertificateQuiz extends StartCourseCertificateEvent {
  final Map finishQuizMap;
  SubmitCertificateQuiz({required this.finishQuizMap});
}

class StartCertificateQuiz extends StartCourseCertificateEvent {
  final String quizId;
  StartCertificateQuiz({required this.quizId});
}

class FetchCertificateQuizReport extends StartCourseCertificateEvent {
  final String workforceQuizId;
  FetchCertificateQuizReport({required this.workforceQuizId});
}

class ReattemptCertificateQuiz extends StartCourseCertificateEvent {
  final String workforceQuizId;
  ReattemptCertificateQuiz({required this.workforceQuizId});
}
