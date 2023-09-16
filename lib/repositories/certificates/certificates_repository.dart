import 'package:toolkit/data/models/certificates/feedback_certificate_model.dart';
import 'package:toolkit/data/models/certificates/upload_certificate_model.dart';

import '../../data/models/certificates/certificate_list_model.dart';

abstract class CertificateRepository {
  Future<FetchCertificatesModel> fetchCertificatesRepository(
    int pageNo,
    String hashCode,
    String userId,
  );

  Future<UploadCertificateModel> uploadCertificates(Map uploadCertificateMap);

  Future<FeedbackCertificateModel> feedbackCertificate(String hashCode,String userId, String certificateId);

}
