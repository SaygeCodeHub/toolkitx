import 'package:toolkit/data/models/certificates/certificate_list_model.dart';
import 'package:toolkit/repositories/certificates/certificates_repository.dart';

import '../../utils/constants/api_constants.dart';
import '../../utils/dio_client.dart';

class CertificateRepositoryImpl extends CertificateRepository {

  @override
  Future<FetchCertificatesModel> fetchCertificatesRepository(int pageNo, String hashCode, String userId) async {

    final response = await DioClient().get(
        "${ApiConstants.baseUrl}certificate/get?pageno=$pageNo&hashcode=$hashCode&workforceid=$userId");
    return FetchCertificatesModel.fromJson(response);

  }
}
