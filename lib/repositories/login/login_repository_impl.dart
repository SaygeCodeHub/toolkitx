import '../../data/models/login/generate_login_opt_model.dart';
import '../../data/models/login/login_model.dart';
import '../../data/models/login/validate_email_model.dart';
import '../../utils/constants/api_constants.dart';
import '../../utils/dio_client.dart';
import 'login_repository.dart';

class LoginRepositoryImpl extends LoginRepository {
  @override
  Future<ValidateEmailModel> validateEmail(Map validateEmailMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}common/validateemail", validateEmailMap);
    return ValidateEmailModel.fromJson(response);
  }

  @override
  Future<GenerateLoginOtpModel> getOptLogin(Map getOptLoginMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}common/generateotp", getOptLoginMap);
    return GenerateLoginOtpModel.fromJson(response);
  }

  @override
  Future<LoginModel> postLogin(Map postLogin) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}common/login", postLogin);
    return LoginModel.fromJson(response);
  }
}
