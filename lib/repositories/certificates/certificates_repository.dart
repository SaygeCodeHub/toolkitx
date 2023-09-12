import 'package:toolkit/data/models/certificates/upload_certificate_model.dart';

import '../../data/models/certificates/certificate_list_model.dart';

abstract class CertificateRepository {
  Future<FetchCertificatesModel> fetchCertificatesRepository(
    int pageNo,
    String hashCode,
    String userId,
  );

  Future<UploadCertificateModel> uploadCertificates(Map uploadCertificateMap);
}
