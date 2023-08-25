import '../../data/models/certificates/certificate_list_model.dart';

abstract class CertificateRepository {
  Future<FetchCertificateListModel> fetchCertificateListRepository(
    int pageNo,
    String hashCode,
    String userId,
  );
}
