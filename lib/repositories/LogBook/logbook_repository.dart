import '../../data/models/LogBook/fetch_logbook_list_model.dart';
import '../../data/models/LogBook/fetch_logbook_master_model.dart';
import '../../data/models/LogBook/report_new_logbook_model.dart';

abstract class LogbookRepository {
  Future<FetchLogBookListModel> fetchLogbookList(
      String userId, String hashCode, String filter, int page);

  Future<LogBookFetchMasterModel> fetchLogBookMaster(String hashCode);

  Future<ReportNewLogBookModel> reportNewLogbook(Map reportNewLogbookMap);
}
