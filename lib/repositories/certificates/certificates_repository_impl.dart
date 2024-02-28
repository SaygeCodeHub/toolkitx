import 'package:toolkit/data/models/certificates/certificate_list_model.dart';
import 'package:toolkit/data/models/certificates/feedback_certificate_model.dart';
import 'package:toolkit/data/models/certificates/finish_quiz_certificate_model.dart';
import 'package:toolkit/data/models/certificates/get_certificate_details_model.dart';
import 'package:toolkit/data/models/certificates/get_course_certificate_model.dart';
import 'package:toolkit/data/models/certificates/get_notes_certificate_model.dart';
import 'package:toolkit/data/models/certificates/get_quiz_questions_model.dart';
import 'package:toolkit/data/models/certificates/get_topic_certificate_model.dart';
import 'package:toolkit/data/models/certificates/update_user_track_model.dart';
import 'package:toolkit/data/models/certificates/get_workforce_quiz_model.dart';
import 'package:toolkit/data/models/certificates/save_question_answer.dart';
import 'package:toolkit/data/models/certificates/start_quiz_model.dart';
import 'package:toolkit/data/models/certificates/upload_certificate_model.dart';
import 'package:toolkit/repositories/certificates/certificates_repository.dart';

import '../../utils/constants/api_constants.dart';
import '../../utils/dio_client.dart';

class CertificateRepositoryImpl extends CertificateRepository {
  @override
  Future<FetchCertificatesModel> fetchCertificatesRepository(
      int pageNo, String hashCode, String userId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}certificate/get?pageno=$pageNo&hashcode=$hashCode&workforceid=$userId");
    return FetchCertificatesModel.fromJson(response);
  }

  @override
  Future<UploadCertificateModel> uploadCertificates(
      Map uploadCertificateMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}certificate/uploadcertificate",
        uploadCertificateMap);
    return UploadCertificateModel.fromJson(response);
  }

  @override
  Future<FeedbackCertificateModel> feedbackCertificate(
      String hashCode, String userId, String certificateId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}certificate/getfeedbackquestionwithresponse?hashcode=$hashCode&workforceid=$userId&certificateid=$certificateId");
    return FeedbackCertificateModel.fromJson(response);
  }

  @override
  Future<GetCourseCertificateModel> getCourseCertificates(
      String hashCode, String certificateId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}certificate/GetCourses?hashcode=$hashCode&certificateid=$certificateId");
    return GetCourseCertificateModel.fromJson(response);
  }

  @override
  Future<GetTopicCertificateModel> getTopicCertificates(
      String hashCode, String userId, String courseId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}certificate/GetTopics?hashcode=$hashCode&courseid=$courseId&workforceid=$userId");
    return GetTopicCertificateModel.fromJson(response);
  }

  @override
  Future<FetchGetNotesModel> getNotesCertificates(
      String hashCode, String userId, String topicId, int pageNo) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}certificate/GetNotes?hashcode=$hashCode&pageno=$pageNo&topicid=$topicId&workforceid=$userId");
    return FetchGetNotesModel.fromJson(response);
  }

  @override
  Future<UpdateUserTrackModel> updateUserTrackRepo(
      Map updateUserTrackMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}certificate/UpdateUserTrack",
        updateUserTrackMap);
    return UpdateUserTrackModel.fromJson(response);
  }

  @override
  Future<GetWorkforceQuizModel> getWorkforceQuiz(
      String hashCode, String userId, String quizId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}certificate/GetWorkforceQuiz?hashcode=$hashCode&quizid=$quizId&workforceid=$userId");
    return GetWorkforceQuizModel.fromJson(response);
  }

  @override
  Future<GetQuizQuestionsModel> getQuizQuestions(
      String hashCode, int pageNo, String workforcequizId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}certificate/GetQuizQuestion?hashcode=$hashCode&workforcequizid=$workforcequizId&pageno=$pageNo");
    return GetQuizQuestionsModel.fromJson(response);
  }

  @override
  Future<SaveQuestionAnswerModel> saveQuestionAnswer(
      Map questionAnswerMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}certificate/SaveQuestionAnswer",
        questionAnswerMap);
    return SaveQuestionAnswerModel.fromJson(response);
  }

  @override
  Future<FinishQuizCertificateModel> finishQuizCertificate(
      Map finishQuizMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}certificate/FinishQuiz", finishQuizMap);
    return FinishQuizCertificateModel.fromJson(response);
  }

  @override
  Future<FetchCertificateDetailsModel> fetchCertificateDetails(
      String hashCode, String userId, String certificateId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}certificate/getcertificate?certificateid=$certificateId&hashcode=$hashCode&workforceid=$userId");
    return FetchCertificateDetailsModel.fromJson(response);
  }

  @override
  Future<StartQuizModel> startQuiz(Map startQuizMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}certificate/StartQuiz", startQuizMap);
    return StartQuizModel.fromJson(response);
  }
}
