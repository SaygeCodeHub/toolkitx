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

class QuestionAnswerEvent extends StartCourseCertificateEvent{
  final Map questionAnswerMap;
  QuestionAnswerEvent({required this.questionAnswerMap});
}
