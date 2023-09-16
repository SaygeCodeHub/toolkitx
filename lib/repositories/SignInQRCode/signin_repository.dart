import 'package:toolkit/data/models/SignInQRCode/assign_to_me_workorder_model.dart';

import '../../data/models/SignInQRCode/assign_to_me_checklist_model.dart';
import '../../data/models/SignInQRCode/assign_to_me_loto_model.dart';
import '../../data/models/SignInQRCode/assign_to_me_permit_model.dart';
import '../../data/models/SignInQRCode/current_signin_model.dart';
import '../../data/models/SignInQRCode/sign_in_location_details_model.dart';
import '../../data/models/SignInQRCode/process_singin_model.dart';
import '../../data/models/SignInQRCode/signin_unathorized_model.dart';

abstract class SignInRepository {
  Future<FetchCurrentSignInModel> signInList(String userId, String hashCode);

  Future<FetchLocationDetailsSignInModel> signInLocationDetails(
      String hashCode, String locationId, String userId);

  Future<AssignToMeWorkOrderModel> assignToMeWorkOrder(
      Map assignToMeWorkorderMap);

  Future<AssignToMePermitModel> assignToMePermit(Map assignToMePermitMap);

  Future<AssignToMeLotoModel> assignToMeLOTO(Map assignToMeLOTOMap);

  Future<AssignToMeChecklistModel> assignToMeChecklist(
      Map assignToMeChecklistMap);

  Future<ProcessSignInModel> processSignIn(Map processSingInMap);

  Future<SignInUnathorizedModel> unathorizedSignIn(Map unathorizedSingInMap);

}
