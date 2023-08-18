
import '../../data/models/SignInQRCode/current_signin_model.dart';

abstract class SignInRepository {
  Future<FetchCurrentSignInModel> signInList(String userId, String hashCode);
}
