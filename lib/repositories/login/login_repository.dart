import '../../data/models/login/generate_login_opt_model.dart';
import '../../data/models/login/login_model.dart';
import '../../data/models/login/validate_email_model.dart';

abstract class LoginRepository {
  Future<ValidateEmailModel> validateEmail(Map validateEmailMap);

  Future<GenerateLoginOtpModel> getOptLogin(Map getOptLoginMap);

  Future<LoginModel> postLogin(Map postLogin);
}
