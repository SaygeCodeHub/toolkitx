import 'package:toolkit/data/models/SignInQRCode/signin_unathorized_model.dart';

import '../../data/models/SignInQRCode/current_signin_model.dart';
import '../../data/models/SignInQRCode/process_singin_model.dart';
import '../../data/models/SignInQRCode/sign_in_location_details_model.dart';

abstract class SignInRepository {
  Future<FetchCurrentSignInModel> signInList(String userId, String hashCode);

  Future<ProcessSignInModel> processSignIn(Map processSingInMap);

  Future<SignInUnathorizedModel> unathorizedSignIn(Map unathorizedSingInMap);

  Future<FetchLocationDetailsSignInModel> signInLocationDetails(
      String hashCode, String locationId, String userId);
}
