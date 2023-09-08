import 'package:toolkit/data/models/certificates/upload_certificate_model.dart';

import '../../data/models/certificates/certificate_list_model.dart';
import '../../data/models/certificates/get_course_certificate_model.dart';
import '../../data/models/certificates/get_topic_certificate_model.dart';

abstract class CertificateRepository {
  Future<FetchCertificatesModel> fetchCertificatesRepository(
    int pageNo,
    String hashCode,
    String userId,
  );

  Future<UploadCertificateModel> uploadCertificates(Map uploadCertificateMap);

  Future<GetCourseCertificateModel> getCourseCertificates(String hashCode, String certificateId);

  Future<GetTopicCertificateModel> getTopicCertificates(String hashCode, String userId, String courseId);
}
