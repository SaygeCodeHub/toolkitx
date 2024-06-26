import 'package:toolkit/data/models/certificates/feedback_certificate_model.dart';
import 'package:toolkit/data/models/certificates/finish_quiz_certificate_model.dart';
import 'package:toolkit/data/models/certificates/get_certificate_details_model.dart';
import 'package:toolkit/data/models/certificates/get_quiz_questions_model.dart';
import 'package:toolkit/data/models/certificates/get_workforce_quiz_model.dart';
import 'package:toolkit/data/models/certificates/reattempt_certificate_quiz_model.dart';
import 'package:toolkit/data/models/certificates/save_question_answer.dart';
import 'package:toolkit/data/models/certificates/start_quiz_model.dart';
import 'package:toolkit/data/models/certificates/update_user_track_model.dart';
import 'package:toolkit/data/models/certificates/upload_certificate_model.dart';

import '../../data/models/certificates/certificate_list_model.dart';
import '../../data/models/certificates/get_course_certificate_model.dart';
import '../../data/models/certificates/get_notes_certificate_model.dart';
import '../../data/models/certificates/get_quiz_report_model.dart';
import '../../data/models/certificates/get_topic_certificate_model.dart';
import '../../data/models/certificates/save_certificate_feedback_model.dart';

abstract class CertificateRepository {
  Future<FetchCertificatesModel> fetchCertificatesRepository(
    int pageNo,
    String hashCode,
    String userId,
  );

  Future<UploadCertificateModel> uploadCertificates(Map uploadCertificateMap);

  Future<FeedbackCertificateModel> feedbackCertificate(
      String hashCode, String userId, String certificateId);

  Future<GetCourseCertificateModel> getCourseCertificates(
      String hashCode, String certificateId);

  Future<GetTopicCertificateModel> getTopicCertificates(
      String hashCode, String userId, String courseId);

  Future<FetchGetNotesModel> getNotesCertificates(
      String hashCode, String userId, String topicId, int pageNo);

  Future<UpdateUserTrackModel> updateUserTrackRepo(Map updateUserTrackMap);

  Future<GetWorkforceQuizModel> getWorkforceQuiz(
      String hashCode, String userId, String quizId);

  Future<GetQuizQuestionsModel> getQuizQuestions(
      String hashCode, int pageNo, String workforcequizId);

  Future<SaveQuestionAnswerModel> saveQuestionAnswer(Map questionAnswerMap);

  Future<FinishQuizCertificateModel> finishQuizCertificate(Map finishQuizMap);

  Future<FetchCertificateDetailsModel> fetchCertificateDetails(
      String hashCode, String userId, String certificateId);

  Future<StartQuizModel> startQuiz(Map startQuizMap);

  Future<FetchQuizReportModel> fetchQuizReport(
      String hashcode, String workforceQuizId);

  Future<ReattemptCertificateQuizModel> reattemptCertificateQuiz(
      Map reattemptQuizMap);

  Future<SaveCertificateFeedbackModel> saveCertificateFeedback(
      Map saveFeedbackMap);
}
