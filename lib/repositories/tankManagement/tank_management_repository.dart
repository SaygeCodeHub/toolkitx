import 'package:toolkit/data/models/tankManagement/fetch_tank_management_list_module.dart';

abstract class TankManagementRepository {
  Future<FetchTankManagementListModel> fetchTankManagementList(
      int pageNo, String hashCode, String filter, String userId);
}
