import 'package:toolkit/data/models/certificates/certificate_list_model.dart';
import 'package:toolkit/data/models/certificates/get_course_certificate_model.dart';
import 'package:toolkit/data/models/certificates/get_notes_certificate_model.dart';
import 'package:toolkit/data/models/certificates/get_topic_certificate_model.dart';
import 'package:toolkit/data/models/certificates/update_user_track_model.dart';
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
  Future<FetchGetNotesModel> getNotesCertificates(String hashCode, String userId, String topicId, int pageNo) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}certificate/GetNotes?hashcode=$hashCode&pageno=$pageNo&topicid=$topicId&workforceid=$userId");
    return FetchGetNotesModel.fromJson(response);
  }

  @override
  Future<UpdateUserTrackModel> updateUserTrackRepo(Map updateUserTrackMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}certificate/UpdateUserTrack",updateUserTrackMap);
    return UpdateUserTrackModel.fromJson(response);
  }
}
