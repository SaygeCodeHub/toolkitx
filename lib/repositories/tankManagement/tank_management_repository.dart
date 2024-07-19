import 'package:toolkit/data/models/tankManagement/fetch_nomination_checklist_model.dart';
import 'package:toolkit/data/models/tankManagement/fetch_tank_management_details_model.dart';
import 'package:toolkit/data/models/tankManagement/fetch_tank_management_list_module.dart';

abstract class TankManagementRepository {
  Future<FetchTankManagementListModel> fetchTankManagementList(
      int pageNo, String hashCode, String filter, String userId);

  Future<FetchTankManagementDetailsModel> fetchTankManagementDetails(
      String nominationId, String hashCode);

  Future<FetchNominationChecklistModel> fetchNominationChecklist(
      String nominationId, String hashCode, String userId);
}
