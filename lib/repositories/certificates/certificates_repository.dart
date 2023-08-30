import '../../data/models/certificates/certificate_list_model.dart';

abstract class CertificateRepository {
  Future<FetchCertificatesModel> fetchCertificateListRepository(
    int pageNo,
    String hashCode,
    String userId,
  );
}
